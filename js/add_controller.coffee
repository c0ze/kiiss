---
---

KiissApp = angular.module('kiiss')
KiissApp.controller 'AddCtrl', ['$scope', ($scope) ->

  $scope.user = Kii.getCurrentUser()

  $scope.addFeed = () ->
    console.log "Add feed called with " + $scope.feedUrl
    console.log $scope

]
