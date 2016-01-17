---
---

app.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', '$window', 'RssService', 'UserService',
  ($scope, $rootScope, $modal, $window, RssService, UserService) ->

    Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US

    $rootScope.$on "login", (e, user) ->
      unless e.defaultPrevented
        e.preventDefault()
        e.stopPropagation()
        $scope.user = user
        $scope.loginModal?.hide()
        $scope.active_feed = {}
        $scope.reloadFeeds()
        $scope.$apply()


    $rootScope.$on "failure", (e, message) ->
      unless e.defaultPrevented
        e.preventDefault()
        e.stopPropagation()
        $scope.loginModal ?=
          $modal
            title: "Please Login",
            template: "/templates/login_modal.html",
            controller: "LoginCtrl"
        $scope.loginModal?.show()

    $rootScope.$on "added", (e) ->
      unless e.defaultPrevented
        e.preventDefault()
        e.stopPropagation()
        $scope.addModal?.hide()
        $scope.reloadFeeds()

    $scope.addFeed = ->
      $scope.addModal ?=
        $modal
          title: "Enter a URL",
          template: "/templates/add_modal.html",
          controller: "AddCtrl"
      $scope.addModal?.show()

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

    UserService.login()
]
