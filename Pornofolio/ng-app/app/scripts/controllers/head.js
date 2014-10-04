app.controller("HeadCtrl", ["$scope",
	function($scope){
		$scope.head = {
			"title": "Pornfolio [ポルノフォリオ] | みんなのエロがあつまるサイト",
			"description": "あらゆる「エロ」を自由に組み合わせ、ひとつのページにまとめて保存・紹介できるキュレーションメディア。スマートフォン対応、スタイリッシュで無駄が一切ない、「究極のエロ動画サイト」です。"
		}

		$scope.$on("change-page", function(event, data){
			$scope.head.title = data.title;
			$scope.head.description = data.desc;
		})
	}
]);
