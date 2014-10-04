
app.controller("CreateCtrl", ["$scope", "$sce", "$rootScope", "http", "cookie", "env",
    function($scope, $sce, $rootScope, http, cookie, env){
        $scope.title_error_msg = null;
        $scope.desc_error_msg = null;
        $scope.category_error_msg = null;
        $scope.name_error_msg = null;
        $scope.contents = [];
        $scope.thumbnails = [];
        $scope.api = {};
        $scope.user = {};
        var HOST = env.getHost();

        if($rootScope["post_data"]){
            $scope.title = $rootScope["post_data"].title;
            $scope.desc = $rootScope["post_data"].desc;
            $scope.category = $rootScope["post_data"].category;
            $scope.user.name = $rootScope["post_data"].user_name;
            $scope.contents = $rootScope["post_data"].contents;
            $scope.tags = $rootScope["post_data"].tags;
        }

        if($rootScope["thumbnails"]){
            $scope.thumbnails = $rootScope["thumbnails"];
        }

        $scope.initialize = function(){
            /*
            if(!cookie.getCookie("beta")){
                location.href = "#!/top";
            }
            */

            $(".to-create-page").css("display", "none");
            http.getCreateBasicData($scope.api, $scope.user);
        }

        $scope.saveData = function(){
            if(basic_validate($scope.title, $scope.desc, $scope.user.name, $scope.category)){
                var data = {
                    "title": $scope.title,
                    "desc": $scope.desc,
                    "category": $scope.category,
                    "user_name": $scope.user.name,
                    "contents": $scope.contents,
                    "tags": $scope.tags
                }

                $rootScope["post_data"] = data;
                $rootScope["thumbnails"] = $scope.thumbnails;

                location.href = "#!/confirm";
                window.scrollTo(0, 0);
            }
        }

        function basic_validate(title, desc, user_name, category){
            $scope.title_error_msg = null;
            $scope.desc_error_msg = null;
            $scope.category_error_msg = null;
            $scope.name_error_msg = null;

            error = {};
            if(title == undefined){
                error["title"] = "empty";
            }
            if(title && title.length > 255){
                error["title"] = "length";
            }
            if(desc && desc.length > 255){
                error["desc"] = "length";
            }
            if(category == undefined){
                error["category"] = "empty";
            }
            if(user_name && user_name.length > 50){
                error["user_name"] = "length";
            }

            if(Object.keys(error).length > 0){
                for(var key in error){
                    if(key == "title" && error[key] == "empty"){
                        $scope.title_error_msg = "タイトルを記入して下さい";
                    }
                    if(key == "title" && error[key] == "length"){
                        $scope.title_error_msg = "255文字以内で記入して下さい";
                    }
                    if(key == "desc" && error["desc"] == "length"){
                        $scope.desc_error_msg = "255文字以内で記入して下さい";
                    }
                    if(key == "category" && error[key] == "empty"){
                        $scope.category_error_msg = "カテゴリーを選択して下さい";
                    }
                    if(key == "user_name" && error[key] == "length"){
                        $scope.name_error_msg = "50文字以内で記入して下さい";
                    }
                }
                return false;
            }

            return true;
        }

        $scope.showInput = function(type){
            $scope.hideInsertInputBtns();
            $scope.cancelInsert();
            $(".default-input-zone .input-zone").css("display", "none");
            switch(type){
                case "headline":
                    $(".headline-input-zone").show("normal");
                    break;
                case "url":
                    $(".url-input-zone").show("normal");
                    break;
                case "text":
                    $(".text-input-zone").show("normal");
                    break;
            }
        }

        $scope.cancelAdd = function(){
            $(".default-input-zone .input-zone").css("display", "none");
            $scope.headline = $scope.url = $scope.text = null;
        }

        $scope.addData = function(type, data){
            if(data != undefined){
                var parse_data;
                if(parse_data = content_validate(type, data)){
                    var content = setContent(type, parse_data);
                    $scope.contents.push(content);
                    $scope.cancelAdd();
                }
            }
        }

        function setContent(type, data){
            var detail_type;
            var content_type;
            switch(type){
                case "headline":
                    content_type = $scope.api.data.content_type.header;
                    detail_type = $scope.api.data.detail_type.header;
                    break;
                case "text":
                    content_type = $scope.api.data.content_type.text;
                    detail_type = $scope.api.data.detail_type.text;
                    break;
                case "url":
                    content_type = $scope.api.data.content_type.video;
                    var url;
                    if(!data.match(/[^0-9]+/)){
                        detail_type = $scope.api.data.detail_type.xvideos;
                        url = HOST + "/api/xvideos/thumbnails?id=" + data + "&size=l";
                    }
                    else{
                        detail_type = $scope.api.data.detail_type.agesage;
                        url = HOST + "/api/asgs/thumbnails?id=" + data + "&size=l";
                    }

                    http.getThumbnails(url, $scope.thumbnails);
                    break;
            }

            var content = {
                "content_type": content_type,
                "details": {
                    "detail_type": detail_type,
                    "substance": data
                },
                "order": null
            }

            return content;
        }

        function content_validate(type, data){
            clearContentErrorMsg();

            var key = null;
            var error = {};

            switch(type){
                case "headline":
                    if(typeof data === undefined){
                        error[type] = "empty";
                    }
                    break;
                case "url":
                    if(typeof data === undefined){
                        error[type] = "empty";
                    }
                    else{
                        var url_array = data.match(/^https?:\/\/(([^\.]+)\.?([^\/?#\.]*\.?[^\/?#\.]*)?)/);

                        if(url_array instanceof Array){
                            if(url_array[1] === "xvideos.com" || url_array[3] === "xvideos.com"){
                                var tmp = data.match(/video([0-9]+)/);
                                key = RegExp.$1;
                            }
                            else if(url_array[1] === "asg.to" || url_array[3] === "asg.to"){
                                var query_hash = {};
                                var query = data.split("?")[1];
                                var query_array = query.split("&");
                                for(var i = 0; i < query_array.length; i++){
                                    var tmp = query_array[i].split("=");
                                    query_hash[tmp[0]] = tmp[1];
                                }
                                key = query_hash["mcd"];
                            }
                            else{
                                error[type] = "not url";
                            }
                        }
                        else{
                            error[type] = "not url";
                        }
                    }

                    if(key == null){
                        error[type] = "not url";
                    }

                    break;
                case "text":
                    if(typeof data === undefined){
                        error[type] = "empty";
                    }
                    break;
            }

            if(Object.keys(error).length > 0){
                for(var key in error){
                    if(key === "headline" && error[key] === "empty"){
                        $scope.headline_error_msg = "見出しを記入して下さい";
                    }
                    if(key === "url" && error[key] === "empty"){
                        $scope.url_error_msg = "xvideosまたはアゲサゲのURLを入力して下さい";
                    }
                    if(key === "url" && error[key] === "not url"){
                        $scope.url_error_msg = "xvideosまたはアゲサゲのURLを入力して下さい";
                    }
                    if(key === "body" && error[key] === "empty"){
                        $scope.text_error_msg = "本文を記入して下さい";
                    }
                }
                return false;
            }

            if(key){
                data = key;
            }

            return data;
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

        $scope.deleteContent = function(index, content){
            $scope.contents.splice(index, 1);

            if(content.content_type = $scope.api.data.content_type.video){
                var key = content.details.substance;
                for(var i = 0; i < $scope.thumbnails.length; i++){
                    if($scope.thumbnails[i].video_id == key){
                        $scope.thumbnails.splice(i, 1);
                    }
                }
            }
        }

        $scope.sanitize = function(text){
            if(text !== ""){
                return $sce.trustAsHtml(text.replace(/\n/g, '<br>'));
            }
        }

        $scope.showInsertLine = function(index){
            if($("#hover-zone" + index).next(".insert-zone").css("display") == "block"){
                return;
            }

            $("#hover-zone" + index).css("opacity", 1);
        }

        $scope.hideInsertLine = function(index){
            $("#hover-zone" + index).css("opacity", 0);
        }

        $scope.showInsertInputBtns = function(index){
            if($("#hover-zone" + index).next(".insert-zone").css("display") == "block"){
                return;
            }

            $(".insert-zone").css("display", "none");
            $scope.cancelAdd();
            clearContentErrorMsg();
            resetInsertInput();
            clearContentModel();

            $("#hover-zone" + index).css("opacity", 0);
            $("#hover-zone" + index).next(".insert-zone").show("normal");
        }

        $scope.hideInsertInputBtns = function(){
            $(".insert-zone").css("display", "none");
            clearContentErrorMsg();
            resetInsertInput();
            clearContentModel();
        }

        $scope.showInsertInput = function(type, index){
            clearContentErrorMsg();
            resetInsertInput();
            clearContentModel();

            $("#insert-input-btns" + index).prev(".insert-input-zone").css("display", "block");

            switch(type){
                case "headline":
                    $(".headline-insert-zone").show("normal");
                    break;
                case "url":
                    $(".url-insert-zone").show("normal");
                    break;
                case "text":
                    $(".text-insert-zone").show("normal");
                    break;
            }
        }

        $scope.cancelInsert = function(){
            clearContentErrorMsg();
            resetInsertInput();
            clearContentModel();
        }

        $scope.insertData = function(type, data, index){
            var parse_data;
            if(parse_data = content_validate(type, data)){
                var content = setContent(type, parse_data);
                $scope.contents.splice(index, 0, content);
                $scope.hideInsertInputBtns();
            }
        }

        function resetInsertInput(){
            $(".insert-input-zone").css("display", "none");
            $(".insert-input-zone .input-zone").css("display", "none");
            $(".insert-input-zone input").val("");
            $(".insert-input-zone textarea").val("");
        }

        function clearContentErrorMsg(){
            $scope.headline_error_msg = null;
            $scope.url_error_msg = null;
            $scope.text_error_msg = null;
        }

        function clearContentModel(){
            $scope.insert_headline = null;
            $scope.insert_url = null;
            $scope.insert_text = null;
        }

        $("textarea").autosize();
    }
]);
