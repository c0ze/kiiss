---
---

app.config( (localStorageServiceProvider) ->
  localStorageServiceProvider.setPrefix('KIISS')
)

app.config( ($routeProvider, $locationProvider) ->
  $routeProvider
   .when('/feed/:feedId', {
    templateUrl: 'feed.html',
    controller: 'FeedCtrl'
   })
    .when('/Book/:bookId/ch/:chapterId', {
      templateUrl: 'chapter.html',
      controller: 'ChapterController'
    })

  $locationProvider.html5Mode(true);
)
