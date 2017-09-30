---
---

app.directive "feed", [ () ->
  scope: true
  restrict: 'E'
  replace: 'true'
  templateUrl: '/templates/directives/feed.html'
  controller: ($scope, $location) ->

    $scope.$watch 'feed', ->
      $scope.url = "/feed/#{$scope.feed.getUUID()}"

    $scope.delete =  ->
      $scope.feed.delete
        success: ->
          console.log "deleted."
          $scope.reloadFeeds()

]
