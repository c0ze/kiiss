---
---

app.factory 'UserService', ['$rootScope', '$cookies', ($rootScope, $cookies) ->

  user = {}
  COOKIE_KEY = "KIISSTOKEN"

  handleLogin = (theUser) ->
    $cookies[COOKIE_KEY] = theUser.getAccessToken()
    user = theUser
    $rootScope.$emit 'login', theUser

  @logout = () ->
    $cookies[COOKIE_KEY] = ""
    KiiUser.logOut()
    user = {}


  @login = (user) ->
    if $cookies[COOKIE_KEY]
      KiiUser.authenticateWithToken($cookies[COOKIE_KEY],
        success: (theUser) ->
          handleLogin(theUser)
        failure: (user, errorString) ->
          $rootScope.$emit 'failure', errorString
      )
    else
      if user? and user.useremail? and user.password?
        KiiUser.authenticate( user.useremail, user.password,
          success: (theUser) ->
            handleLogin(theUser)
          failure: (theUser, errorString) ->
            if (errorString.indexOf('invalid_grant') > -1)
              $rootScope.$emit 'failure', "User or password incorrect"
            else
              $rootScope.$emit 'failure', errorString
        )
      else
        $rootScope.$emit 'failure', "Not Logged in."

  @register = (user) ->
    username = user.useremail.replace /@/, ""
    kiiUser = KiiUser.userWithEmailAddressAndUsername(user.useremail, username, user.password);
    kiiUser.register(
      success: (theUser) ->
        handleLogin(theUser)
      failure: (theUser, errorString) ->
        $rootScope.$emit 'failure', "Error while registering: " + errorString
    )

  @
]
