app.controller("TopCtrl", ["$scope", "$rootScope", "http", "$sce", "env",
	function($scope, $rootScope, http, $sce, env){
		$scope.content = {};
		$scope.footer_ads = [];
		var HOST = env.getHost();

		$scope.initialize = function(){
			var oldest_id = null;
			var url = setUrl(oldest_id);
            http.getTopData(url, $scope.content);

            //http.getAd("top", $scope.footer_ads);
		}

		$scope.strimwidth = function(str, max){
			if(str && str.length > parseInt(max)){
				str = str.slice(0, parseInt(max));
				str += "...";
				return str;
			}
			return str;
		}

		function setUrl(oldest_id){
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
            	url = HOST + "/api/posts/mindex?category_id=" + query_hash["category_id"] + "&oldest=" + oldest_id;
            }
            else if(query_hash["tag_id"] != undefined){
            	url = HOST + "/api/posts/mindex?tag_id=" + query_hash["tag_id"] + "&oldest=" + oldest_id;
            }
            else{
            	url = HOST + "/api/posts/mindex?oldest=" + oldest_id;
            }

            return url;
		}

		$scope.toPageTop = function(){
			window.scrollTo(0, 0);
		}

		$scope.isDefault = function(){
			if(!window.location.hash.split("?")[1]){
				return "category-selected";
			}
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

	    $scope.pagenation = function(){
	    	var id_array = [];
	    	angular.forEach($scope.content.posts, function(post){
	    		id_array.push(post.post_id);
	    	});

	    	id_array = id_array.sort(function(a, b) {
  				return (parseInt(a) > parseInt(b)) ? 1 : -1;
			});

	    	var oldest_id = id_array[0];
	    	var url = setUrl(oldest_id);
	    	http.pagenation(url, $scope.content);
	    }
	}
]);

