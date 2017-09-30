---
---

app.controller 'FeedCtrl',
  ['$scope', '$rootScope', '$routeParams', 'UserService', 'RssService',
   ($scope,   $rootScope,   $routeParams,   UserService,   RssService) ->

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
          RssService.parseFeed($scope.activeFeed.url).then( (feed) ->
            console.log feed
            $scope.loadButtonText = $scope.activeFeed.name
            console.log feed
            $scope.activeFeed.description = feed.meta.description
            $scope.links = feed.entries
            $scope.$apply()
          )

        failure: (obj) ->
          console.log "object fetch failed."
      )
]
