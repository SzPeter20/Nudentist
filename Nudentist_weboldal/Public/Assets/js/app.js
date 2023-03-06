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
            controller: 'MunkatarsakCtrl'
        })
        .when('/reg', {
            templateUrl: 'views/registration.html',
            controller: 'userCtrl'
        })
        .when('/bemutatkozas', {
            templateUrl: 'views/Bemutatkozas.html',
            controller: 'userCtrl'
        })
        .when('/munkatarsak', {
            templateUrl: 'views/Munkatarsak.html',
            controller: 'MunkatarsakCtrl'
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
        .when('/passwordmod', {
            templateUrl: 'views/Passwordmod.html',
            controller: 'userCtrl'
        })
        .when('/dokprofil/:id', {
            templateUrl: 'views/Doktorprofil.html',
            controller: 'profilokCtrl'
        })
        // admin funkciók
        
        .when('/uzenetek', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.jogok != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Uzenetek.html',
            controller: 'uzenetCtrl'
        })
        // user funkciók
        .when('/idopontokkezelese', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin') {
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
                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/uzenetek.html',
            controller: 'uzenetCtrl'
        })
        .when('/profilom', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Userprofil.html',
            controller: 'userCtrl'
        })

        .otherwise('/')
        .when('/jelszomod', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.jogok != 'user' && $rootScope.loggedUser.jogok != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/Passwordmod.html',
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

    this.uploadFileToUrl = function(file, uploadUrl) {
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
