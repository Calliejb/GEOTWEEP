
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
	var consumerKey = encodeURIComponent('ZVIgrKzFHV0s7MkUPsUaRxSB0');
    var consumerSecret = encodeURIComponent('8ZvyhbwenIBiiDZX2V5jbfCyClvliVX08nBmKCJWs8JthZDapL');
    var credentials = Base64.encode(consumerKey + ':' + consumerSecret);
    // Twitters OAuth service endpoint
    var twitterOauthEndpoint = $http.post(
        'https://api.twitter.com/oauth2/token', "grant_type=client_credentials", {headers: {'Authorization': 'Basic ' + credentials, 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'}}
    );
    twitterOauthEndpoint.success(function (response) {
        // a successful response will return
        // the "bearer" token which is registered
        // to the $httpProvider
        serviceModule.$httpProvider.defaults.headers.common['Authorization'] = "Bearer " + response.access_token;
    }).error(function (response) {
          // error handling to some meaningful extent
        });

//stuff that I have to fix!!!!
    var r = $resource('https://api.twitter.com/1.1/search/:action',
		{action: 'tweets.json',
				count: 10,
			},
			{
				<span style="line-height: 1.5;">
				paginate: {method: 'GET'}</span>
			})
    	return r;
	}

	.config(function ($httpProvider) {
		serviceModule.$httpProvider = $httpProvider
	});
})()

	return $resource('searches/:id',
		{id: '@id'},
		{update: { method: 'PATCH'}});
}]);


// geotweepApp.controller('GeoCtrl', ['$scope','Search', function($scope, $resource) {
//   var TwitterAPI = $resource("http://search.twitter.com/search.json",
//     { callback: "JSON_CALLBACK" },
//     { get: { method: "JSONP" }});

//   $scope.search = function() {
//     $scope.searchResult = TwitterAPI.get({ q: $scope.searchTerm });
//   };
// }