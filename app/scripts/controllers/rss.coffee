'use strict'

###*
 # @ngdoc function
 # @name kiiRssApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the kiiRssApp
###
angular.module 'kiiRssApp'
  .controller 'RssCtrl', ['$scope', '$location', ($scope, $location) ->

    unless Kii.loggedIn()
      $location.path('login')

    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
  ]