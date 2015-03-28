'use strict'

###*
 # @ngdoc function
 # @name kiiRssApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the kiiRssApp
###
angular.module 'kiiRssApp'
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
