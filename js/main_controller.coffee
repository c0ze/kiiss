---
---

KiissApp = angular.module('kiiss', ['ngAnimate', 'mgcrea.ngStrap'])
KiissApp.controller 'MainCtrl', ['$scope', '$modal', ($scope, $modal) ->

  Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US

  $scope.myModal =
    title: "Please Login",
    template: "templates/modal.html",
    controller: "LoginCtrl",
    scope: $scope

  unless Kii.loggedIn()
    $modal($scope.myModal)

]
