---
---

app.controller 'FeedCtrl', ['$scope', '$rootScope',
  ($scope, $rootScope) ->

    $scope.user = Kii.getCurrentUser()

    console.log "Hello from Feed Controller ! #{$scope.user}"

    $rootScope.$on "load", (e, feed) ->
      console.log feed
]
