app.controller("MasterCtrl", ["$scope",
	function($scope){
		$scope.menu;
		$scope.back;

		$scope.initialize = function(){
			$scope.menu = true;
			$scope.back = false;
		}

		$scope.$on("category", function(event, result) {
			$scope.categories = result;
			var page = window.location.hash.split("/")[1];
			switch(page){
				case "view":
					$scope.menu = false;
					$scope.back = true;
					break;
				default:
					$scope.menu = true;
					$scope.back = false;
					break;
			}
        });

        $scope.$on("isSelected", function(event, result) {
        	$(".category-li").css("background-color", "transparent");
        	if(result == "all"){
        		$(".category-default").css("background-color", "#474C50");
        	}
        	else{
        		$("#category" + result).css("background-color", "#474C50");
        	}
        });
	}
]);
