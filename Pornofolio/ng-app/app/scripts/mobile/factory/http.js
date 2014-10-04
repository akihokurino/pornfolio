app.factory("http", ["$http", "env", "$rootScope", "localstorage", "cookie", function($http, env, $rootScope, localstorage, cookie){
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
		getTopData: function(url, scope_content){
			var partNum = 12;
			http(url, "GET", {},
				function(data, status, headers, config){
					scope_content.categories = data.content.categories;
					$rootScope.$broadcast("category", data.content.categories);
					scope_content.tags = data.content.tags;
					scope_content.posts = data.content.posts;

					var query_hash = {};
					if(window.location.hash.split("?")[1]){
						var query = window.location.hash.split("?")[1].split("&");
						for(var i = 0; i < query.length; i++){
						    var tmp = query[i].split("=");
						    query_hash[tmp[0]] = tmp[1];
						}
					}

					var find = false;
					angular.forEach(data.content.categories, function(value, key){
						if(query_hash["category_id"] && query_hash["category_id"] == value.id){
							scope_content.sub_header_title = value.name;
							$rootScope.$broadcast("isSelected", query_hash["category_id"]);
							find = true;
						}
					});

					if(!find){
						scope_content.sub_header_title = "すべて";
						$rootScope.$broadcast("isSelected", "all");
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

		getViewData: function(post_id, scope_content, scope_user_hash){
			http(HOST + "/api/posts/" + post_id, "GET", {},
				function(data, status, headers, config){
					$rootScope.$broadcast("category", data.content.categories);
					scope_content.post = data.content.post;
					scope_content.posts = data.content.posts;
					scope_user_hash.hash = data.user_hash;

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
					$rootScope.$broadcast("category", data.content.categories);
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
		},

		pagenation: function(url, scope_content){
			partNum = 12;
			http(url, "GET", {},
				function(data, status, headers, config){
					if(data.content.posts.length == 0){
						$(".more").css("display", "none");
						return;
					}
					angular.forEach(data.content.posts, function(post){
						scope_content.posts.push(post);
					})

					if(!localstorage.checkStorage()){
						localstorage.setStorage(data.user_hash);
					}
				},
				function(data, status, headers, config){
				}
			);
		},

		getTags: function(scope_content){
			http(HOST + "/api/tags", "GET", {},
				function(data, status, headers, config){
					$rootScope.$broadcast("category", data.content.categories);
					scope_content.tags = data.content.tags;
				},
				function(data, status, headers, config){

				}
			)
		}
	}
}])