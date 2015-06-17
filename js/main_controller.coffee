---
---

KiissApp = angular.module('kiiss', ['ngAnimate', 'mgcrea.ngStrap'])
KiissApp.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', ($scope, $rootScope, $modal) ->

  Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US

  $scope.loginModal ?=
    $modal
      title: "Please Login",
      template: "templates/login_modal.html",
      controller: "LoginCtrl"

  $scope.addModal ?=
    $modal
      title: "Enter a URL",
      template: "templates/add_modal.html",
      controller: "AddCtrl",
      show: false

  $rootScope.$on 'login', ->
    $scope.loginModal.$scope.$hide()

  $scope.addFeed = ->
    console.log "Add feed called."
    $scope.addModal.$scope.$show()

  unless Kii.loggedIn()
    $scope.loginModal.$scope.$show()
    $scope.addModal.$scope.$hide()
]
