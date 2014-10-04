app.controller("ContactCtrl", ["$scope", "http",
	function($scope, http){
		$scope.sendContact = function(){
			if(!$scope.name || !$scope.body){
				return;
			}

			var data = {
				"contact": {
					"name": $scope.name,
					"body": $scope.body
				}
			};

			http.sendContact(data);

			$scope.name = null;
			$scope.body = null;
		}
	}
]);