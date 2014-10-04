app.controller("ViewCtrl", ["$scope", "$sce", "http",
	function($scope, $sce, http){
		var post_id;
		$scope.content = {};
		$scope.user_hash = {};
		$scope.footer_ads = [];
		$scope.side_ads = [];

		$scope.initialize = function(){
			var urlArray = window.location.hash.split("/");
			post_id = parseInt(urlArray.pop());

			http.getViewData(post_id, $scope.content, $scope.user_hash);

			//http.getAd("view", $scope.footer_ads, $scope.side_ads);
			$("textarea").autosize();
		}

		$scope.strimwidth = function(str, max){
			if(str && str.length > parseInt(max)){
				str = str.slice(0, parseInt(max));
				str += "...";
				return str;
			}
			return str;
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


		$scope.postComment = function(){
			if(!$scope.comment_body){
				return;
			}

			var data = {
				"post_comments": {
					"post_id": $scope.content.post.id,
					"text": $scope.comment_body,
					"user_hash": $scope.user_hash.hash
				}
			};

			http.postComment(data, $scope.content);
			$scope.comment_body = null;
		}

		$scope.addFavorite = function(){
			var data = {
				"user_favorites": {
					"post_id": $scope.content.post.id,
					"user_hash": $scope.user_hash.hash
				}
			};

			http.addFavorite(data, $scope.content);
		}

		$scope.removeFavorite = function(){
			http.removeFavorite($scope.content.post.id, $scope.content);
		}

		$scope.sendLike = function(){
			var data = {
				"post_likes": {
					"post_id": $scope.content.post.id,
					"user_hash": $scope.user_hash.hash
				}
			};

			http.sendLike(data, $scope.content);
		}

		$scope.sendUnLike = function(){
			http.sendUnLike($scope.content.post.id, $scope.content);
		}

		$scope.countClick = function(ad_id){
	    	var data = {
	    		"ad": {
	    			"ad_id": ad_id,
		    		"view_url": "http://pornfolio.jp",
		    		"post_id": $scope.content.post.id
	    		}
	    	};

	    	http.countClick(data);
	    }

	    $scope.parseHtml = function(val){
	    	return $sce.trustAsHtml(val);
	    }
	}
]);