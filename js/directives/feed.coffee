---
---

app.directive "feed", [ () ->
  scope: true
  restrict: 'E'
  replace: 'true'
  templateUrl: '/templates/directives/feed.html'
  controller: ($scope, $location) ->

    console.log $scope
    $scope.$watch 'feed', ->
      $scope.url = "/feed.html#?uuid=#{$scope.feed.getUUID()}"
      $scope.$apply

    $scope.goTo = ->
      window.location = $scope.url

    $scope.delete =  ->
      $scope.feed.delete
        success: ->
          console.log "deleted."
          $scope.reloadFeeds()

]
