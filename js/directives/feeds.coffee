---
---

app.directive "feeds", () ->
  scope: true,
  restrict: 'E',
  replace: 'true',
  templateUrl: '/templates/directives/feeds.html',
  link: (scope, elem, attrs) ->
    console.log "hello from feeds directive."

    scope.reloadFeeds = ->
      scope.rss.getFeeds(scope.user).then (feeds) ->
        scope.feeds = feeds

    scope.$on "login", ->
      scope.reloadFeeds()
