app.factory("http", ["$http", "pagenation", "env", "localstorage", "cookie", "$rootScope", function($http, pagenation, env, localstorage, cookie, $rootScope){
	var HOST = env.getHost();

	function http(url, method, data, success_fn, error_fn){
		if(localstorage.checkStorage()){
			cookie.setCookie(localstorage.getStorage());
		}

		$http({
			url: url,
			method: method,
			data: data,
			withCredentials: true,
			header: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
		})
		.success(success_fn)
		.error(error_fn);
	}

	return {
		getTopData: function(url, scope_content, scope_all_page, pageNum, scope_top2, scope_right3){
			var partNum = 12;
			var tmp_pagenation = [];

			http(url, "GET", {},
				function(data, status, headers, config){
					scope_content.categories = data.content.categories;
					scope_content.tags = data.content.tags;
					scope_content.posts = data.content.posts;
					if(scope_top2 && scope_right3 && data.content.ranking){
						for(var i = 0; i < data.content.ranking.length; i++){
							if(i < 2){
								scope_top2.push(data.content.ranking[i]);
							}
							else{
								scope_right3.push(data.content.ranking[i]);
							}
						}
					}

					if(scope_content.posts.length == 0){
						$(".no-content-message").css("display", "block");
					}
					else{
						$(".no-content-message").css("display", "none");
					}

					var post_count = data.content.post_count;
					var all_part = Math.ceil(post_count / partNum);

					for(var i = 1; i <= all_part; i++){
						tmp_pagenation.push(i);
					}

					if(tmp_pagenation.length > 15){
						pagenation.sort_page(scope_all_page, tmp_pagenation, pageNum);
					}
					else{
						scope_all_page.length = 0;
						for(var i = 0; i < tmp_pagenation.length; i++){
							scope_all_page.push(tmp_pagenation[i]);
						}
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		getAd: function(page, scope_footer_ads, scope_side_ads){
			http(HOST + "/api/ads", "GET", {},
				function(data, status, headers, config){
					switch(page){
						case "top":
							angular.forEach(data.content.footer, function(ad, i){
								scope_footer_ads.push(ad);
							});
							break;
						case "view":
							angular.forEach(data.content.footer, function(ad, i){
								scope_footer_ads.push(ad);
							});
							angular.forEach(data.content.side, function(ad, i){
								scope_side_ads.push(ad);
							});
							break;
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		countClick: function(data){
			http(HOST + "/api/ads", "POST", data,
				function(data, status, headers, config){
					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){

				}
			)
		},

		getViewData: function(post_id, scope_content, scope_user_hash, scope_top5){
			http(HOST + "/api/posts/" + post_id, "GET", {},
				function(data, status, headers, config){
					scope_content.post = data.content.post;
					scope_content.posts = data.content.posts;
					scope_user_hash.hash = data.user_hash;

					if(scope_top5 && data.content.ranking){
						for(var i = 0; i < data.content.ranking.length; i++){
							scope_top5.push(data.content.ranking[i]);
						}
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}

					$rootScope.$broadcast("change-page", data.content.post);
				},
				function(data, status, headers, config){
				}
			);
		},

		postComment: function(data, scope_content){
			http(HOST + "/api/post_comments", "POST", data,
				function(data, status, headers, config){
					scope_content.post.comments.push(data.content.comment);

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		addFavorite: function(data, scope_content){
			http(HOST + "/api/user_favorites", "POST", data,
				function(data, status, headers, config){
					scope_content.post.favorited = true;

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		removeFavorite: function(post_id, scope_content){
			http(HOST + "/api/user_favorites/" + post_id, "DELETE", {},
				function(data, status, headers, config){
					scope_content.post.favorited = false;

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		sendLike: function(data, scope_content){
			http(HOST + "/api/post_likes", "POST", data,
				function(data, status, headers, config){
					scope_content.post.liked = true;
					scope_content.post.like_count++;

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		sendUnLike: function(post_id, scope_content){
			http(HOST + "/api/post_likes/" + post_id, "DELETE", {},
				function(data, status, headers, config){
					scope_content.post.liked = false;
					scope_content.post.like_count--;

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		getFavoriteData: function(scope_content){
			http(HOST + "/api/user_favorites", "GET", {},
				function(data, status, headers, config){
					scope_content.posts = data.content.posts;
					if(scope_content.posts.length == 0){
						$(".no-favorite-message").css("display", "block");
					}
					else{
						$(".no-favorite-message").css("display", "none");
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		getCreateBasicData: function(scope_api, scope_user){
			http(HOST + "/api/posts/new", "GET", {},
				function(data, status, headers, config){
					scope_api.data = data.content;
					if(scope_user && !scope_user.name){
						scope_user.name = data.content.user_name;
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
					/*
					if(data.error.message == "Authentication is failed." && status == 401){
						location.href = "#!/top";
					}
					*/
				}
			);
		},

		getThumbnails: function(url, scope_thumbnails){
			http(url, "GET", {},
				function(data, status, headers, config){
					scope_thumbnails.push(data.content);

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		createContent: function(data){
			http(HOST + "/api/posts", "POST", data,
				function(data, status, headers, config){
					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}

					location.href = "#!/complete?last_id=" + data.content.last_id;
	            	window.scrollTo(0, 0);
				},
				function(data, status, headers, config){
					/*
					if(data.error.message == "Authentication is failed." && status == 401){
						location.href = "#!/top";
					}
					*/
				}
			);
		},

		sendAuth: function(data){
			http(HOST + "/api/beta", "POST", data,
				function(data, status, headers, config){
					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}

					if(data.content.result == true){
						$(".authorization-layer").css("display", "none");
						$(".authorization-modal").css({"display": "none", "top": 0});
						location.href = "#!/create";
					}
				},
				function(data, status, headers, config){
					/*
					if(data.error == "Authentication error."){
						$(".authorization-layer").css("display", "none");
						$(".authorization-modal").css({"display": "none", "top": 0});
					}
					*/
				}
			);
		},

		sendContact: function(data){
			http(HOST + "/api/contacts", "POST", data,
				function(data, status, headers, config){
					if(data.content.result){
						$(".contact-message").css("display", "block");
						setTimeout(function(){
							$(".contact-message").animate({"opacity": 0}, 1000, function(){
								$(".contact-message").css("display", "none");
							});
						}, 3000);
					}

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){

				}
			);
		}
	}
}])