

var geotweepApp = angular.module('GeoTweepApp', ['ngResource']).config(
	['$httpProvider', function($httpProvider) {
	var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
	var defaults = $httpProvider.defaults.headers;

	defaults.common["X-CSRF-TOKEN"] = authToken;
	defaults.patch = defaults.patch || {};
	defaults.patch['Content-Type'] = 'application/json';
	defaults.common['Accept'] = 'application/json';
}]);

geotweepApp.factory('Search', ['$resource', function($resource) {
  return $resource('/searches/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

geotweepApp.controller('GeoCtrl', ['$scope', 'Search', function($scope, Search) {
    $scope.searches= [];

    $scope.newSearch = new Search();

    Search.query(function(searches) {
      $scope.searches = searches;
	});

    $scope.saveSearch = function () {
      $scope.newSearch.$save(function(search) {
        $scope.searches.push(search);
        $scope.newSearch = new Search();
      });
    };

    $scope.showSearchField = function(search) {
      // search.terms = true;
    };

    $scope.hideSearchField = function(search) {
      // search.terms = false;
    };

    $scope.clearErrors = function() {
      $scope.errors = null;
    };
}]);