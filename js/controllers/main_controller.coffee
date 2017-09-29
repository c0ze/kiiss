---
---

app.config( (localStorageServiceProvider) ->
  localStorageServiceProvider.setPrefix('KIISS')
)

app.controller 'MainCtrl', ['$scope', '$rootScope', '$modal', '$window', 'RssService', 'UserService',
  ($scope, $rootScope, $modal, $window, RssService, UserService) ->

    Kii.initializeWithSite "79255555", "6aa6ef92c2cd9d1f9a00e330f6b93e4e", KiiSite.US
    $scope.rss = RssService

    $rootScope.$on "login", (e, user) ->
      unless e.defaultPrevented
        $scope.user = user
        $scope.loginModal?.hide()
        $scope.$broadcast "login"

    $rootScope.$on "failure", (e, message) ->
      unless e.defaultPrevented
        $scope.loginModal ?=
          $modal
            title: "Please Login",
            template: "/templates/login_modal.html",
            controller: "LoginCtrl"
        $scope.loginModal?.show()

    $rootScope.$on "added", (e) ->
      unless e.defaultPrevented
        $scope.addModal?.hide()
        $scope.$broadcast "login"

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

    UserService.login()
]
