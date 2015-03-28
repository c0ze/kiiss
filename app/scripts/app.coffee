'use strict'

###*
 # @ngdoc overview
 # @name kiiRssApp
 # @description
 # # kiiRssApp
 #
 # Main module of the application.
###
angular
  .module 'kiiRssApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .when '/login',
        templateUrl: 'views/login.html'
        controller: 'LoginCtrl'
      .when '/rss',
        templateUrl: 'views/rss.html'
        controller: 'RssCtrl'
      .otherwise
        redirectTo: '/'

