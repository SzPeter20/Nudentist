let app = new angular.module('Nudentist', ['ngRoute']);



app.run(function($rootScope, $locale, DB) {

    $locale.NUMBER_FORMATS.GROUP_SEP = ".";
    $locale.NUMBER_FORMATS.DECIMAL_SEP = ",";

    $rootScope.regist=0;
    $rootScope.settings = {};
    $rootScope.loggedUser = {};
    $rootScope.settings.appTitle = 'Nudentist';
    $rootScope.settings.company = 'Bajai SZC Türr István Technikum';
    $rootScope.settings.author = '2/14.szft szoftverfejlesztő';
    $rootScope.loggedUser = angular.fromJson(sessionStorage.getItem('Nudentist'));
});

app.config(function($routeProvider) {
    $routeProvider
    // bárki számára
        .when('/', {
            templateUrl: '/Public/Views/Homepage.html',
            controller: 'userCtrl'
        })
        .when('/reg', {
        templateUrl: '/Public/views/Regisztracio.html',
            controller: 'userCtrl'
        })
        .when('/bemutatkozas', {
            templateUrl: '/Public/views/bemutatkozas.html',
            controller: 'userCtrl'
        })
        // orvos funkciók
        .when('/profil', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'orvos') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: '/public/views/profil.html',
            controller: 'profilCtrl'
        })
        
        
        .otherwise('/')

});