---
---

KiissApp = angular.module('kiiss')
KiissApp.controller 'LoginCtrl', ['$scope', '$rootScope', ($scope, $rootScope) ->

  $scope.login = () ->
    console.log "login called with " + $scope.useremail + $scope.password
    KiiUser.authenticate( $scope.useremail, $scope.password,
      success: (theUser) ->
        console.log "User successfully authenticated!"
        $scope.user = theUser
        $scope.$apply()
        $rootScope.$emit 'login'
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
        $scope.$emit "login"
      failure: (theUser, errorString) ->
        console.log "Error while registering: " + errorString
    )

]
