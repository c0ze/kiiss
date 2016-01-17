---
---

KiissApp = angular.module('kiiss')
KiissApp.controller 'AddCtrl', ['$scope', '$rootScope', 'RssService',
  ($scope, $rootScope, RssService) ->

    $scope.addFeed = () ->
      RssService.addFeed($scope.feedUrl).then ->
        $rootScope.$emit 'added'

]
