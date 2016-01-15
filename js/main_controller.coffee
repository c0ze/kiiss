---
---

app.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', '$cookies', '$window', 'RssService'
  ($scope, $rootScope, $modal, $cookies, $window, RssService) ->

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

    $scope.addFeed = ->
      console.log "Add feed called."
      $scope.addModal.$scope.$show()

    $scope.logOut = ->
      console.log "logout called."
      $cookies[COOKIE_KEY] = ""
      KiiUser.logOut()
      $scope.user = {}
      $window.location.reload();

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
      $scope.$apply()

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

    if $cookies[COOKIE_KEY]
      KiiUser.authenticateWithToken($cookies[COOKIE_KEY],
        success: (user) ->
          $scope.login(user)
        failure: (user, anErrorString) ->
          $scope.errorMessage = "Invalid Token"
          $scope.messageClass = "alert alert-danger"
          $scope.addModal.$scope.$hide()
          $scope.loginModal.$scope.$show()
      )
    else
      $scope.addModal.$scope.$hide()
      $scope.loginModal.$scope.$show()

]
