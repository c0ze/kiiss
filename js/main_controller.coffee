---
---

KiissApp = angular.module('kiiss', ['ngAnimate', 'ngCookies', 'mgcrea.ngStrap'])
KiissApp.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', '$cookies', 'RssService'
  ($scope, $rootScope, $modal, $cookies, RssService) ->

    Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US
    COOKIE_KEY = "KIISSTOKEN"

    $rootScope.$on "login", ->
      console.log "got the login event"
      user = Kii.getCurrentUser()
      $cookies[COOKIE_KEY] = user.getAccessToken()
      $scope.login(user)

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

    $scope.delete = (feed) ->
      feed.delete
        success: ->
          $scope.reloadFeeds()

    $scope.reloadFeeds = ->
      RssService.getFeeds($scope.user).then (feeds) ->
        $scope.feeds = feeds

    $scope.login = (user) ->
      $scope.loginModal.$scope.$hide()
      $scope.user = user
      $scope.active_feed = {}
      $scope.reloadFeeds()

    if $cookies[COOKIE_KEY]
      KiiUser.authenticateWithToken($cookies[COOKIE_KEY],
        success: (user) ->
          $scope.login(user)
        failure: (user, anErrorString) ->
          $scope.errorMessage = "Invalid Token"
          $scope.messageClass = "alert alert-danger"
      )

    unless Kii.loggedIn()
      $scope.loginModal.$scope.$show()
      $scope.addModal.$scope.$hide()
]
