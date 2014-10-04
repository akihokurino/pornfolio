app.controller("MasterCtrl", ["$scope", "$resource", "$routeParams", "$sce", "$rootScope", "http", "cookie",
	function($scope, $resource, $routeParams, $sce, $rootScope, http, cookie){
		/*
		$scope.showAuthModal = function(){
			if(cookie.getCookie("beta")){
				location.href = "#!/create";
				return;
			}
			$(".authorization-layer").css("display", "block");
			$(".authorization-modal").css("display", "block");
			$(".authorization-modal").animate({"top": 100 + "px"}, 300);
		}

		$scope.hideAuthModal = function(){
			$(".authorization-layer").css("display", "none");
			$(".authorization-modal").css({"display": "none", "top": 0});
		}

		$scope.sendAuth = function(code){
			if(typeof code === undefined){
				return;
			}

			var data = {
				pass: code
			};

			$scope.auth_code = null;
			$(".authorization-modal input").val("");
			http.sendAuth(data);
		}
		*/
	}
]);
