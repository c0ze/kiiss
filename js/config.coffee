---
---

app.config( (localStorageServiceProvider) ->
  localStorageServiceProvider.setPrefix('KIISS')
)

app.config( ($interpolateProvider) ->
  $interpolateProvider.startSymbol('[{')
  $interpolateProvider.endSymbol('}]')
)

app.config( ($qProvider) ->
  $qProvider.errorOnUnhandledRejections(false)
)

app.filter('trusted',
  ['$sce', ($sce) ->
    return (html) ->
      return $sce.trustAsHtml(html)
  ]
)

app.config( ($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/feed/:feedId', {
      templateUrl: '/feed.html',
      controller: 'FeedCtrl'
    })
    .when('/about', {
      templateUrl: '/about.html'
    })
    .otherwise({
      templateUrl: '/feeds.html',
      controller: 'MainCtrl'
    })
    .when('/Book/:bookId/ch/:chapterId', {
      templateUrl: 'chapter.html',
      controller: 'ChapterController'
    })

  $locationProvider.hashPrefix('')
  $locationProvider.html5Mode(true)
)
