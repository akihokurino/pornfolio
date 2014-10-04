app.factory("pagenation", function(){
	return {
		sort_page: function(scope_all_page, tmp_pagenation, pageNum){
			var tmp_array = $.extend(true, [], tmp_pagenation);
			tmp_pagenation.length = 0;

			if(pageNum > 0 && pageNum <= 10){
				var last_offset = tmp_array.length - 1;
				for(var i = 1; i <= tmp_array.length; i++){
					if(i < 13){
						tmp_pagenation.push(i);
					}
					else if(i == 13){
						tmp_pagenation.push("dammy");
					}
					else if(i > 13 && i <= 15){
						tmp_pagenation.push(last_offset);
						last_offset++;
					}
					else{
						break;
					}
				}
			}
			else if(pageNum >= tmp_array.length - 10 && pageNum <= tmp_array.length){
				var last_offset = tmp_array.length - 11;
				for(var i = 1; i <= tmp_array.length; i++){
					if(i < 3){
						tmp_pagenation.push(i);
					}
					else if(i == 3){
						tmp_pagenation.push("dammy");
					}
					else if(i > 3 && i <= 15){
						tmp_pagenation.push(last_offset);
						last_offset++;
					}
					else{
						break;
					}
				}
			}
			else{
				console.log("test");
				var offset = pageNum - 4;
				var last_offset = tmp_array.length - 1;
				for(var i = 1; i <= tmp_array.length; i++){
					if(i < 3){
						tmp_pagenation.push(i);
					}
					else if(i == 3){
						tmp_pagenation.push("dammy");
					}
					else if(i > 3 && i < 13){
						tmp_pagenation.push(offset);
						offset++;
					}
					else if(i == 13){
						tmp_pagenation.push("dammy");
					}
					else if(i > 13 && i <= 15){
						tmp_pagenation.push(last_offset);
						last_offset++;
					}
					else{
						break;
					}
				}
			}

			scope_all_page.length = 0;
			for(var i = 0; i < tmp_pagenation.length; i++){
				scope_all_page.push(tmp_pagenation[i]);
			}
		}
	}
})