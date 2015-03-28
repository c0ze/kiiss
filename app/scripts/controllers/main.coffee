'use strict'

###*
 # @ngdoc function
 # @name kiiRssApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the kiiRssApp
###
angular.module 'kiiRssApp'
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
