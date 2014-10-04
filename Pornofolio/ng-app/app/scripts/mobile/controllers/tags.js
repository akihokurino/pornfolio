app.controller("TagsCtrl", ["$scope", "http",
	function($scope, http){
		$scope.content = {
			"tags": {}
		};

		$scope.initialize = function(){
			http.getTags($scope.content);
		}
	}
]);