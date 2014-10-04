app.controller("TopCtrl", ["$scope", "$rootScope", "http", "$sce", "env",
	function($scope, $rootScope, http, $sce, env){
		$scope.content = {};
		$scope.all_page = [];
		$scope.top2 = [];
		$scope.right3 = [];
		$scope.footer_ads = [];
		var pageNum;
		var HOST = env.getHost();
		$scope.show_more_tags = false;

		$scope.initialize = function(){
			$(".to-create-page").css("display", "inline-block");
			pageNum = 1;
			$rootScope = null;

			var url = setUrl(pageNum);

            http.getTopData(url, $scope.content, $scope.all_page, pageNum, $scope.top2, $scope.right3);

            http.getAd("top", $scope.footer_ads);
		}

		$scope.strimwidth = function(str, max){
			if(str && str.length > parseInt(max)){
				str = str.slice(0, parseInt(max));
				str += "...";
				return str;
			}
			return str;
		}

		$scope.getPage = function(page){
			if(page == "dammy"){
				return;
			}
			pageNum = parseInt(page);
			var url = setUrl(pageNum);

			http.getTopData(url, $scope.content, $scope.all_page, pageNum);

            $("html, body").scrollTop(320);
		}

		$scope.setPage = function(page){
			$(".page" + page).removeClass("current");
			$(".page" + page).css("border", "solid 1px #CCC");

			if(page == "dammy"){
				$(".pagedammy").css({
					"border": "none",
				});
				return "...";
			}

			if(pageNum == page){
				$(".page" + page).addClass("current");
			}
			return page;
		}

		function setUrl(page){
			var query_hash = {};
			if(window.location.hash.split("?")[1]){
				var query = window.location.hash.split("?")[1].split("&");
				for(var i = 0; i < query.length; i++){
	                var tmp = query[i].split("=");
	                query_hash[tmp[0]] = tmp[1];
	            }
	        }

	        var url;
            if(query_hash["category_id"] != undefined){
            	url = HOST + "/api/posts?category_id=" + query_hash["category_id"] + "&page=" + page;
            }
            else if(query_hash["tag_id"] != undefined){
            	url = HOST + "/api/posts?tag_id=" + query_hash["tag_id"] + "&page=" + page;
            }
            else{
            	url = HOST + "/api/posts?page=" + page;
            }

            return url;
		}

		$scope.toPageTop = function(){
			window.scrollTo(0, 0);
		}

		$scope.isSelected = function(category_id){
			if(category_id != undefined){
				var query_hash = {};
				if(window.location.hash.split("?")[1]){
					var query = window.location.hash.split("?")[1].split("&");
					for(var i = 0; i < query.length; i++){
				        var tmp = query[i].split("=");
				        query_hash[tmp[0]] = tmp[1];
				    }

				    if(query_hash["category_id"] != undefined && query_hash["category_id"] == category_id){
						return "category-selected";
					}
				}
			}
		}

		$scope.isDefault = function(){
			if(!window.location.hash.split("?")[1]){
				return "category-selected";
			}
		}

		$scope.adjustTop = function(){
	        $("html, body").scrollTop(320);
	        return false;
	    }

	    $scope.countClick = function(ad_id){
	    	var data = {
	    		"ad": {
	    			"ad_id": ad_id,
		    		"view_url": "http://pornfolio.jp",
		    		"post_id": null
	    		}
	    	};

	    	http.countClick(data);
	    }

	    $scope.parseHtml = function(val){
	    	return $sce.trustAsHtml(val);
	    }

	    $scope.showMoreTags = function(){
	    	$scope.show_more_tags = true;
	    }
	}
]);

