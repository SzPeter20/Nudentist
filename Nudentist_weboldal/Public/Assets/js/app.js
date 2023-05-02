let app = new angular.module('NudentistApp', ['ngRoute']);

app.run(function($rootScope, $locale, DB) {

    $locale.NUMBER_FORMATS.GROUP_SEP = ".";
    $locale.NUMBER_FORMATS.DECIMAL_SEP = ",";

    $rootScope.settings = {};
    $rootScope.loggedUser = {};
    $rootScope.settings.appTitle = 'NudentistApp';
    $rootScope.settings.company = 'Bajai SZC Türr István Technikum';
    $rootScope.settings.author = 'Zámbó Illés és Szabó Péter';
    $rootScope.penznem = 'Ft';
    $rootScope.decimals = 0;
    $rootScope.exch = 1;
    $rootScope.loggedUser = angular.fromJson(sessionStorage.getItem('NudentistApp'));

});

app.config(function($routeProvider) {
    $routeProvider
    // bárki számára
        .when('/', {
            templateUrl: 'views/Homepage.html',
            controller: 'munkatarsakCtrl'
        })
        .when('/reg', {
            templateUrl: 'views/Registration.html',
            controller: 'userCtrl'
        })
        .when('/bemutatkozas', {
            templateUrl: 'views/Bemutatkozas.html',
            controller: 'userCtrl'
        })
        .when('/munkatarsak', {
            templateUrl: 'views/Munkatarsak.html',
            controller: 'munkatarsakCtrl'
        })
        .when('/kezelesek', {
            templateUrl: 'views/Kezelesek.html',
            controller: 'kezelesekCtrl'

        })
        .when('/kezeles/:id', {
            templateUrl: 'views/Kezeles.html',

            controller: 'kezelesCtrl'

        })
        .when('/elerhetoseg', {
            templateUrl: 'views/Elerhetosegek.html',
            controller: 'munkatarsakCtrl'
        })
        
        .when('/dokprofil/:id', {
            templateUrl: 'views/Doktorprofil.html',
            controller: 'profilokCtrl'
        })
        // user funkciók
        .when('/passwordmod', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Passwordmod.html',
            controller: 'userCtrl'
        })
        .when('/mail', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Mail.html',
            controller: 'uzenetCtrl'
        })
        .when('/kedvencek', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Kedvencek.html',
            controller: 'kedvencekCtrl'
        })
        .when('/idopontokkezelese', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Idopontok.html',
            controller: 'IdopontokCtrl'
        })
        .when('/uzenetek', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Uzenetek.html',
            controller: 'userCtrl'
        })
        .when('/uzenet/:id', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Uzenet.html',
            controller: 'uzenetCtrl'
        })
        .when('/profilom', {
            resolve: {
                function($rootScope, $location) {

                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin'&& $rootScope.loggedUser.jogok != 'doktor') {

                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Userprofil.html',
            controller: 'userCtrl'
        })

        .otherwise('/')
        

});

app.directive('fileModel', function($parse) {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            var model = $parse(attrs.fileModel);
            var modelSetter = model.assign;

            element.bind('change', function() {
                scope.$apply(function() {
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
});

app.service('fileUpload', function($http, $q) {

    this.uploadFile = function(file, uploadUrl) {
        var fd = new FormData();
        fd.append('file', file);

        var deffered = $q.defer();
        $http.post(uploadUrl, fd, {
            transformRequest: angular.identity,
            headers: { 'Content-Type': undefined }

        }).then(
            function(res) {
                deffered.resolve(res);
            },
            function(err) {
                deffered.reject(err);
            }
        );
        return deffered.promise;
    }
});
