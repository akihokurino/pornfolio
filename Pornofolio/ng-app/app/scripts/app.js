var app = angular.module("Pornfolio", ["ngResource", "ngRoute", "ngAnimate"]).config(["$routeProvider", "$locationProvider", function($routeProvider, $locationProvider){
    $routeProvider.when('/', {
        templateUrl: 'views/top.html',
        controller: "TopCtrl"
    });
    $routeProvider.when('/create', {
        templateUrl: 'views/create.html',
        controller: "CreateCtrl"
    });
    $routeProvider.when('/confirm', {
        templateUrl: 'views/confirm.html',
        controller: "ConfirmCtrl"
    });
    $routeProvider.when('/complete', {
        templateUrl: 'views/complete.html',
        controller: "CompleteCtrl"
    });
    $routeProvider.when('/favorite', {
        templateUrl: 'views/favorite.html',
        controller: "FavoriteCtrl"
    });
    $routeProvider.when('/view/:post_id', {
        templateUrl: 'views/view.html',
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
    $routeProvider.otherwise({redirectTo: '/'});
    $locationProvider.hashPrefix('!');
}]);


