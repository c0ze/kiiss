'use strict'

###*
 # @ngdoc function
 # @name kiiRssApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the kiiRssApp
###
angular.module 'kiiRssApp'
  .controller 'RssCtrl',
    ['$scope', '$location', '$http',
    ($scope, $location, $http) ->

      unless Kii.loggedIn()
        $location.path('login')

      $scope.user = Kii.getCurrentUser()
      $scope.active_feed = {}
      $scope.feeds_bucket = $scope.user.bucketWithName("feeds")

      $scope.addFeed = () ->
        feed = $scope.feeds_bucket.createObject()
        feed.set("name", $scope.name)
        feed.set("url", $scope.url)
        feed.save
          success: (theObject) ->
            console.log "Object saved!"
            console.log theObject
            $scope.$apply()
          failure: (theObject, errorString) ->
            console.log "Error saving object: " + errorString

      $scope.getFeeds = () ->
        all_query = KiiQuery.queryWithClause()

        queryCallbacks =
          success: (queryPerformed, resultSet, nextQuery) ->
            console.log "Got feeds :"
            console.log resultSet
            $scope.feeds = resultSet
            $scope.$apply()
            if nextQuery != null
              $scope.feeds_bucket.executeQuery(nextQuery, queryCallbacks)
          failure: (queryPerformed, anErrorString) ->
            console.log anErrorString

        $scope.feeds_bucket.executeQuery(all_query, queryCallbacks)

      $scope.getFeeds()

      $scope.loadButtonText = "Load"

      $scope.loadFeed = (feed)->
        $scope.active_feed.url = feed.get("url")
        $scope.active_feed.name = feed.get("name")
        $scope.parseFeed($scope.active_feed.url).then( (res) ->
          $scope.loadButtonText = $scope.active_feed.name
          console.log res
          $scope.feed_source = res.data.responseData.feed.entries
          $scope.$apply()
          )

      $scope.parseFeed = (url) ->
        return $http.jsonp('http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=50&callback=JSON_CALLBACK&q=' + encodeURIComponent(url))

      $scope.awesomeThings = [
        'HTML5 Boilerplate'
        'AngularJS'
        'Karma'
      ]
  ]
