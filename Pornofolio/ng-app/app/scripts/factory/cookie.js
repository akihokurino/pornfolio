app.factory("cookie", function(){
    function set(name, value, expiredays){
        var path = location.pathname;
        var paths = new Array();
        paths = path.split("/");
        if(paths[paths.length - 1] != ""){
            paths[paths.length - 1] = "";
            path = paths.join("/");
        }

        var extime = new Date().getTime();
        var cltime = new Date(extime + (60 * 60 * 24 * 1000 * expiredays));
        var exdate = cltime.toUTCString();

        var s = "";
        s += name + "=" + escape(value);// 値はエンコードしておく
        s += "; path=" + path;
        if(expiredays){
            s += "; expires=" + exdate + "; ";
        }
        else{
            s += "; ";
        }

        document.cookie = s;
    }

	return {
		getCookie: function(key){
            var cookieString = document.cookie;
            var cookieKeyArray = cookieString.split(";");

            for(var i = 0; i < cookieKeyArray.length; i++){
                var targetCookie = cookieKeyArray[i];
                targetCookie = targetCookie.replace(/^\s+|\s+$/g, "");
                var valueIndex = targetCookie.indexOf("=");

                if(targetCookie.substring(0, valueIndex) == key){
                    return unescape(targetCookie.slice(valueIndex + 1));
                }
            }

            return false;
        },

        setCookie: function(value){
            var today = new Date();
            today.setYear(today.getFullYear() + 20);
            set("user_hash", value, today);
        }
	}
})