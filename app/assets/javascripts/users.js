

var geotweepApp = angular.module('geotweepApp', ['ngResource']).config(
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

geotweepApp.controller('SearchesCtrl', ['$scope', 'Search', function($scope, Search) {
    $scope.searches= [];

    console.log("attempting search");
    Search.query(function(searches) {
      $scope.searches = searches;
      console.log($scope.searches);
	});

}]);
