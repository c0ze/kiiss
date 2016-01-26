---
---

app.directive "feed", ["$rootScope", ($rootScope) ->
  scope: true
  restrict: 'E'
  replace: 'true'
  templateUrl: '/templates/directives/feed.html'
  link: (scope, elem, attrs) ->
    scope.show = ->
      $rootScope.$emit "load", scope.feed

    scope.delete =  ->
      scope.feed.delete
        success: ->
          console.log "deleted."
          scope.reloadFeeds()

]
