app.factory("localstorage", function(){
	return{
		isEnableStorage: function(){
			if(("localStorage" in window) && window["localStorage"] !== null){
				return true;
			}
			else{
				return false;
			}
		},

		checkStorage: function(){
			if(this.isEnableStorage() && localStorage.getItem("user_hash")){
				return true;
			}
			else{
				return false;
			}
		},

		setStorage: function(value){
			if(this.isEnableStorage()){
				localStorage.setItem("user_hash", value);
			}
		},

		getStorage: function(){
			return localStorage.getItem("user_hash");
		}
	}
})