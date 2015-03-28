'use strict'

angular.module 'kiiRssApp'
  .controller 'LoginCtrl', ($scope) ->
    console.log Kii.getSDKVersion()

    if Kii.loggedIn()
      $scope.user = Kii.getCurrentUser()
    else
      $scope.user = {}

    console.log $scope.user

    $scope.login = () ->
      console.log "login called with " + $scope.useremail + $scope.password
      KiiUser.authenticate( $scope.useremail, $scope.password,
        success: (theUser) ->
          console.log "User successfully authenticated!"
          $scope.user = theUser
          $scope.$apply()
        failure: (theUser, errorString) ->
          console.log "Error while authenticating: " + errorString
          if (errorString.indexOf('invalid_grant') > -1)
            $scope.errorMessage = "User or password incorrect"
            $scope.messageClass = "alert alert-danger"
          else
            $scope.errorMessage = errorString
      )

    $scope.register = () ->
      console.log "register called with " + $scope.useremail + $scope.password
      user = KiiUser.userWithEmailAddress($scope.useremail, $scope.password);
      user.register(
        success: (theUser) ->
          console.log("User registered!")
          console.log(theUser)
          $scope.user = theUser
          $scope.$apply()
        failure: (theUser, errorString) ->
          console.log "Error while registering: " + errorString
      )

    $scope.isUserLoggedIn = () ->
      Kii.loggedIn()

    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

