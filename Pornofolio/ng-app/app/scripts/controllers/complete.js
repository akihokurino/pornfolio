app.controller("CompleteCtrl", ["$scope", "cookie", "$location",
	function($scope, cookie, $location){
	    $scope.backPage = function(){
	        window.scrollTo(0, 0);
	    }

	    $scope.initialize = function(){
	    	$(".to-create-page").css("display", "inline-block");
	    	/*
	    	if(!cookie.getCookie("beta")){
	    		location.href = "#!/top";
	    	}
	    	*/

	    	var query = $location.search();
	    	if(Object.keys(query).length > 0){
	    		var last_id = query.last_id;
	    		$(".to-created").attr("href", "#/view/" + last_id);
	    	}
	    	else{
	    		location.href = "#!/!top";
	    	}
	    }
	}
]);