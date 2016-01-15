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
    console.log "service login called"
    console.log user
    if $cookies[COOKIE_KEY]
      KiiUser.authenticateWithToken($cookies[COOKIE_KEY],
        success: (theUser) ->
          console.log "User successfully authenticated!"
          handleLogin(theUser)
        failure: (user, errorString) ->
          $rootScope.$emit 'failure', errorString
      )
    else
      console.log "login called with " + user
      if user? and user.useremail? and user.password?
        KiiUser.authenticate( user.useremail, user.password,
          success: (theUser) ->
            console.log "User successfully authenticated!"
            handleLogin(theUser)
          failure: (theUser, errorString) ->
            console.log "Error while authenticating: " + errorString
            if (errorString.indexOf('invalid_grant') > -1)
              $rootScope.$emit 'failure', "User or password incorrect"
            else
              $rootScope.$emit 'failure', errorString
        )
      else
        $rootScope.$emit 'failure', "Not Logged in."

  @register = (user) ->
    console.log "register called with " + user
    username = user.useremail.replace /@/, ""
    kiiUser = KiiUser.userWithEmailAddressAndUsername(user.useremail, username, user.password);
    console.log(kiiUser)
    kiiUser.register(
      success: (theUser) ->
        console.log("User registered!")
        console.log(theUser)
        handleLogin(theUser)
      failure: (theUser, errorString) ->
        $rootScope.$emit 'failure', "Error while registering: " + errorString
    )

  @
]
