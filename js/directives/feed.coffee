---
---

app.directive "feed", [ () ->
  scope: true
  restrict: 'E'
  replace: 'true'
  templateUrl: '/templates/directives/feed.html'
  controller: ($scope) ->

    $scope.data = {}
    console.log $scope
    $scope.$watch 'feed', ->
      $scope.data.url = "/feed.html#?uuid=#{$scope.feed.getUUID()}"
      $scope.$apply

    $scope.delete =  ->
      $scope.feed.delete
        success: ->
          console.log "deleted."
          $scope.reloadFeeds()

]
