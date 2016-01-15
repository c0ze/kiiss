---
---

app.controller 'FeedCtrl', ['$scope',
  ($scope) ->

    $scope.user = Kii.getCurrentUser()

    console.log "Hello from Feed Controller ! #{$scope.user.username}"
]
