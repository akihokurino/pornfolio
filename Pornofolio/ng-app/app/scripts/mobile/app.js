var app = angular.module("Pornfolio", ["ngResource", "ngRoute", "ngAnimate"]).config(["$routeProvider", "$locationProvider", function($routeProvider, $locationProvider){
    $routeProvider.when('/', {
        templateUrl: 'views/mobile/top.html',
        controller: "TopCtrl"
    });
    $routeProvider.when('/favorite', {
        templateUrl: 'views/mobile/favorite.html',
        controller: "FavoriteCtrl"
    });
    $routeProvider.when('/view/:post_id', {
        templateUrl: 'views/mobile/view.html',
        controller: "ViewCtrl"
    });
    $routeProvider.when('/privacy', {
        templateUrl: 'views/privacy.html',
    });
    $routeProvider.when('/policy', {
        templateUrl: 'views/policy.html',
    });
    $routeProvider.when('/contact', {
        templateUrl: 'views/contact.html',
        controller: "ContactCtrl"
    });
    $routeProvider.when('/tags', {
        templateUrl: 'views/mobile/tags.html',
        controller: "TagsCtrl"
    });
    $routeProvider.otherwise({redirectTo: '/'});
    $locationProvider.hashPrefix('!');
}]);


