---
---

app.controller 'FeedCtrl', ['$scope', '$rootScope', '$location', 'UserService', 'RssService',
  ($scope, $rootScope, $location, UserService, RssService) ->

    UserService.login()
    $scope.activeFeed = {}
    console.log $scope.user

    uuid = $location.search().uuid

    $rootScope.$on "login", (e, user) ->
      $scope.user = user
      bucket = user.bucketWithName("feeds")
      obj = KiiObject.objectWithID(bucket, uuid)
      obj.refresh(
        success: (feed) ->
          $scope.activeFeed.url = feed.get("url")
          $scope.activeFeed.name = feed.get("name")
          RssService.parseFeed($scope.activeFeed.url).then( (res) ->
            $scope.loadButtonText = $scope.activeFeed.name
            console.log res
            $scope.links = res.data.responseData.feed.entries
          )

        failure: (obj) ->
          console.log "object fetch failed."
      )
]
