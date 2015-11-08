---
---

KiissApp = angular.module('kiiss', ['ngAnimate', 'mgcrea.ngStrap'])
KiissApp.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', 'RssService'
  ($scope, $rootScope, $modal, RssService) ->

    Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US

    $rootScope.$on "login", ->
      console.log "got the login event"
      $scope.loginModal.$scope.$hide()
      $scope.user = Kii.getCurrentUser()
      $scope.active_feed = {}
      $scope.reloadFeeds()

    $rootScope.$on "added", ->
      $scope.addModal.$scope.$hide()
      $scope.reloadFeeds()

    $scope.loadButtonText = "Load"

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

    $scope.addFeed = ->
      console.log "Add feed called."
      $scope.addModal.$scope.$show()

    $scope.reloadFeeds = ->
      RssService.getFeeds($scope.user).then (feeds) ->
        $scope.feeds = feeds

    unless Kii.loggedIn()
      $scope.loginModal.$scope.$show()
      $scope.addModal.$scope.$hide()
]
