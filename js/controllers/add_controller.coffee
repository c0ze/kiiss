---
---

KiissApp = angular.module('kiiss')
KiissApp.controller 'AddCtrl', ['$scope', '$rootScope', 'RssService',
  ($scope, $rootScope, RssService) ->

    $scope.user = Kii.getCurrentUser()

    $scope.addFeed = () ->
      console.log "Add feed called with " + $scope.feedUrl
      console.log $scope
      RssService.addFeed($scope.feedUrl).then ->
        $rootScope.$emit 'added'

]
