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
            templateUrl: '/Public/views/Bemutatkozas.html',
            controller: 'userCtrl'
        })
        .when('/kezelesek', {
            templateUrl: '/Public/views/Kezelesek.html',
            controller: 'kezelesekCtrl'
        })
        .when('/uzenetek', {
            templateUrl: '/Public/views/Uzenetek.html',
            controller: 'profilokCtrl'
        })
        .when('/jelszomod', {
            templateUrl: '/Public/views/Passwordmod.html',
            controller: 'profilokCtrl'
        })
        .when('/userprofil', {
            templateUrl: '/Public/views/Userprofil.html',
            controller: 'profilokCtrl'
        })
        // orvos funkciók
        .when('/doktorprofil', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'orvos') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: '/public/views/Doktorprofil.html',
            controller: 'profilokCtrl'
        })
        
        
        .otherwise('/')

});