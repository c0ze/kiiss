---
---

app.controller 'FeedCtrl', ['$scope', '$rootScope', '$location', '$sce', 'UserService', 'RssService',
  ($scope, $rootScope, $location, $sce, UserService, RssService) ->

    UserService.login()
    $scope.activeFeed = {}
    $scope.activeLink = 0

    $scope.feedId =  $routeParams.feedId

    $rootScope.$on "login", (e, user) ->
      $scope.user = user
      bucket = user.bucketWithName("feeds")
      obj = KiiObject.objectWithID(bucket, $scope.feedId)
      obj.refresh(
        success: (feed) ->
          $scope.activeFeed.url = feed.get("url")
          $scope.activeFeed.name = feed.get("name")
          RssService.parseFeed($scope.activeFeed.url).then( (res) ->
            $scope.loadButtonText = $scope.activeFeed.name
            console.log res
            $scope.activeFeed.description = res.data.responseData.feed.description
            $scope.links = res.data.responseData.feed.entries
            $scope.$apply
          )

        failure: (obj) ->
          console.log "object fetch failed."
      )
]
