---
---

app.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', '$window', 'RssService', 'UserService',
  ($scope, $rootScope, $modal, $window, RssService, UserService) ->

    Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US

    $rootScope.$on "login", (e, user) ->
      console.log "got the login event"
      unless e.defaultPrevented
        console.log e
        e.preventDefault()
        e.stopPropagation()
        console.log user
        $scope.user = user
        $scope.login()

    $rootScope.$on "failure", (e, message) ->
      console.log "failure"
      console.log message
      $scope.errorMessage = message
      $scope.messageClass = "alert alert-danger"
      $scope.addModal.$scope.$hide()
      $scope.loginModal.$scope.$show()

    $rootScope.$on "added", ->
      $scope.addModal.$scope.$hide()
      $scope.reloadFeeds()

    $scope.loadButtonText = "Load"

    $scope.addFeed = ->
      console.log "Add feed called."
      $scope.addModal.$scope.$show()

    $scope.logOut = ->
      UserService.logout()
      $window.location.reload();

    $scope.delete = (feed) ->
      feed.delete
        success: ->
          $scope.reloadFeeds()

    $scope.reloadFeeds = ->
      RssService.getFeeds($scope.user).then (feeds) ->
        $scope.feeds = feeds

    $scope.login = () ->
      $scope.loginModal.$scope.$hide()
      $scope.active_feed = {}
      $scope.reloadFeeds()
      $scope.$apply()

    $scope.loginModal ?=
      $modal
        title: "Please Login",
        template: "/templates/login_modal.html",
        controller: "LoginCtrl"
        show: false

    $scope.addModal ?=
      $modal
        title: "Enter a URL",
        template: "/templates/add_modal.html",
        controller: "AddCtrl",
        show: false

    UserService.login()
]
