
app.controller("ConfirmCtrl", ["$scope", "$sce", "$rootScope", "http", "cookie",
	function($scope, $sce, $rootScope, http, cookie){
	    $scope.api = {};
	    $scope.thumbnails = [];
	    $scope.current_thumbnail = "/images/default.png";
	    $scope.random_thumbnails = [];

	    if($rootScope["post_data"]){
	        $scope.data = $rootScope["post_data"];
	        if($scope.data.tags == undefined){
	            $scope.data.tags = [];
	        }
	    }
	    else{
	        location.href = "#!/create";
	    }

	    if($rootScope["thumbnails"] && $rootScope["thumbnails"].length > 0){
	        $scope.thumbnails = $rootScope["thumbnails"];

	        if($rootScope["thumbnails"]["current_thumbnail"]){
	            $scope.current_thumbnail = $rootScope["thumbnails"]["current_thumbnail"];
	        }
	        else{
	            var random_index1 = Math.floor(Math.random() * $scope.thumbnails.length);
	            var random_index2 = Math.floor(Math.random() * 20);
	            $scope.current_thumbnail = $scope.thumbnails[random_index1].thumbnails[random_index2];
	        }

	        $scope.random_thumbnails = [];
	        for(var i = 0; i < $scope.thumbnails.length; i++){
	            var tmp_thumbnails = [];
	            var tmp_thumbnails = $.extend(true, [], $scope.thumbnails[i].thumbnails)

	            for(var j = 0; j < 12; j++){
	                var random_index3 = Math.floor(Math.random() * tmp_thumbnails.length);
	                $scope.random_thumbnails.push(tmp_thumbnails.splice(random_index3, 1));
	            }
	        }
	    }

	    $scope.initialize = function(){
	    	/*
	    	if(!cookie.getCookie("beta")){
                location.href = "#!/top";
            }
            */

	    	$(".to-create-page").css("display", "none");
	    	http.getCreateBasicData($scope.api);
	    }

	    $scope.appendSrc = function(data){
            var src;
            if(!data.match(/[^0-9]+/)){
                src = "http://flashservice.xvideos.com/embedframe/" + data;
            }
            else{
                src = "http://asg.to/blogFrame.html?mcd=" + data;
            }

            return $sce.trustAsResourceUrl(src);
        }

	    $scope.sendData = function(){
	        var tmp_data = $scope.data;
	        if(tmp_data.contents.length == 0){
	        	$(".alert-message").show();
	        	$(".alert-message").addClass("alert-animation");
	        	setTimeout(function(){
	        		$(".alert-message").hide(500);
	        		$(".alert-message").removeClass("alert-animation");
	        	}, 5000);

	        	return;
	        }

	        for(var i = 0; i < tmp_data.contents.length; i++){
	            tmp_data.contents[i].order = i;
	        }

	        tmp_data.thumb = $scope.current_thumbnail;
	        tmp_data.post_type = $scope.api.data.post_type.general;

	        var data = {
	        	"posts": tmp_data
	        };

	        http.createContent(data);
	        $rootScope["post_data"] = null;
	        $rootScope["thumbnails"] = null;
	    }

	    $scope.backPage = function(){
	        $rootScope["post_data"] = $scope.data;
	        $rootScope["thumbnails"]["current_thumbnail"] = $scope.current_thumbnail;
	        window.scrollTo(0, 0);
	    }

	    $scope.addTag = function(){
	        if($scope.tag){
	            if(event.keyCode === 13){
	                $scope.data.tags.push($scope.tag);
	                $scope.tag = null;
	            }
	        }
	    }

	    $scope.deleteTag = function(index){
	    	if(index != undefined){
	    		$scope.data.tags.splice(index, 1);
	    	}
	    }

	    $scope.sanitize = function(text){
	        if(text != ""){
	            return $sce.trustAsHtml(text.replace(/\n/g, '<br>'));
	        }
	    }

	    $scope.showCategoryName = function(category_id){
	    	if(category_id && $scope.api.data){
		        for(var i = 0; i < $scope.api.data.category.length; i++){
		            if(category_id == $scope.api.data.category[i].id){
		                return $scope.api.data.category[i].name;
		            }
		        }
		    }
	    }

	    $scope.showModal = function(){
	    	if($scope.random_thumbnails.length == 0){
	    		return;
	    	}

	        $(".thumbnails-modal").css("display", "block").animate({"opacity": 1, "top": 60 + "px"}, 500);
	        $(".layer").css("display", "block");
	    }

	    $scope.hideModal = function(){
	        $(".thumbnails-modal").css({"display": "none", "opacity": 1, "top": 0 + "px"});
	        $(".layer").css("display", "none");
	    }

	    $(".layer").click(function(){
	        $(".thumbnails-modal").css({"display": "none", "opacity": 1, "top": 0 + "px"});
	        $(".layer").css("display", "none");
	    });

	    $scope.selectThumbnail = function(src){
	        if(src){
	            $scope.current_thumbnail = src;
	            $(".thumbnails-modal").css({"display": "none", "opacity": 1, "top": 0 + "px"});
	            $(".layer").css("display", "none");
	        }
	    }
	}
]);

