app.directive("slideMenu", function() {
	return function(scope, elm, attr) {
		elm.bind("click", function() {
			if($(".menu").css("display") == "none"){
				var height = $(window).height();
				$(".menu").css({"display": "block", "height": height});
				$(".wrapper").animate({"left": 250 + "px"}, 300,
					function(){
						$("html").css("overflow", "hidden");
						$("body").css("overflow", "hidden");
						$(".wrapper").bind("touchmove", function(e){
							e.preventDefault();
						}).css("overflow", "hidden");
						$(".container").css("overflow", "hidden");
						$(".layer").bind("touchmove", function(e){
							e.preventDefault();
						});
						$(".layer").css("display", "block");
					}
				)
			}
			else{
				$(".category-li").css("background-color", "transparent");
				$(".layer").css("display", "none");
				$(".wrapper").animate({"left": 0 + "px"}, 300,
					function(){
						$("html").css("overflow", "auto");
						$("body").css("overflow", "auto");
						$(".wrapper").unbind("touchmove").css("overflow", "auto");
						$(".container").css("overflow", "auto");
						$(".layer").unbind("touchmove");
						$(".menu").css("display", "none");
					}
				)
			}
		});
	};
});