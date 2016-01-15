---
---

app.controller 'LoginCtrl', ['$scope', 'UserService', ($scope, UserService) ->

  $scope.login = () ->
    UserService.login $scope.user

  $scope.register = () ->
    UserService.register $scope.user
]
