---
---

angular.module 'kiiss'
  .factory 'RssService',
    ['$rootScope', '$location', '$http', '$q',
    ($rootScope, $location, $http, $q) ->

      console.log "Rss controller called."

      @addFeed = (url) ->
        deferred = $q.defer()
        feed = @feeds_bucket.createObject()
        @parseFeed(url).then (res) ->
          feed.set("name", res.data.responseData.feed.title)
          feed.set("url", url)
          feed.save
            success: (theObject) ->
              console.log "Object saved!"
              console.log theObject
              deferred.resolve theObject
            failure: (theObject, errorString) ->
              console.log "Error saving object: " + errorString
              deferred.reject errorString
        return deferred.promise

      @getFeeds = (user) ->
        deferred = $q.defer()
        @feeds_bucket = user.bucketWithName("feeds")
        all_query = KiiQuery.queryWithClause()

        queryCallbacks =
          success: (queryPerformed, resultSet, nextQuery) ->
            console.log "Got feeds :"
            console.log resultSet
            @feeds = resultSet
            if nextQuery != null
              @feeds_bucket.executeQuery(nextQuery, queryCallbacks)
            deferred.resolve @feeds
          failure: (queryPerformed, anErrorString) ->
            console.log anErrorString
            deferred.reject anErrorString

        @feeds_bucket.executeQuery(all_query, queryCallbacks)
        return deferred.promise

      @loadFeed = (feed)->
        @active_feed.url = feed.get("url")
        @active_feed.name = feed.get("name")
        @parseFeed($scope.active_feed.url).then( (res) ->
          @loadButtonText = $scope.active_feed.name
          console.log res
          @feed_source = res.data.responseData.feed.entries
        )

      @parseFeed = (url) ->
        return $http.jsonp('http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=50&callback=JSON_CALLBACK&q=' + encodeURIComponent(url))

      @
  ]
