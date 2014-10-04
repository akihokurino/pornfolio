app.controller("FavoriteCtrl", ["$scope", "$rootScope", "http",
	function($scope, $rootScope, http){
		$scope.content = {};

		$scope.initialize = function(){
			$rootScope = null;
			http.getFavoriteData($scope.content);
		}

		$scope.strimwidth = function(str, max){
			if(str && str.length > parseInt(max)){
				str = str.slice(0, parseInt(max));
				str += "...";
				return str;
			}
			return str;
		}
	}
]);