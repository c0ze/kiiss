---
---

app.factory 'UserService', ['$rootScope', 'localStorageService', ($rootScope, localStorageService) ->

  user = {}
  COOKIE_KEY = "KIISSTOKEN"

  handleLogin = (theUser) ->
    localStorageService.set(COOKIE_KEY, theUser.getAccessToken())
    user = theUser
    $rootScope.$emit 'login', theUser

  @logout = () ->
    localStorageService.set(COOKIE_KEY, "")
    KiiUser.logOut()
    user = {}


  @login = (user) ->
    userKey = localStorageService.get(COOKIE_KEY)
    if userKey
      KiiUser.authenticateWithToken(userKey,
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
