let app = new angular.module('NudentistApp', ['ngRoute']);

app.run(function($rootScope, $locale, DB) {

    $locale.NUMBER_FORMATS.GROUP_SEP = ".";
    $locale.NUMBER_FORMATS.DECIMAL_SEP = ",";

    $rootScope.settings = {};
    $rootScope.loggedUser = {};
    $rootScope.settings.appTitle = 'NudentistApp';
    $rootScope.settings.company = 'Bajai SZC Türr István Technikum';
    $rootScope.settings.author = '2/14.szft szoftverfejlesztő';
    $rootScope.penznem = 'Ft';
    $rootScope.decimals = 0;
    $rootScope.exch = 1;
    $rootScope.loggedUser = angular.fromJson(sessionStorage.getItem('NudentistApp'));
    if ($rootScope.loggedUser) {

        DB.select('carts', 'userID', $rootScope.loggedUser.ID).then(function(res) {
            $rootScope.itemsInCart = res.data.length;
        });
    }

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
        // admin funkciók
        .when('/pizzak', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/pizzak.html',
            controller: 'pizzaCtrl'
        })
        .when('/rendelesek', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/rendelesek.html',
            controller: 'rendelesCtrl'
        })
        .when('/statisztika', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/statisztika.html',
            controller: 'statisztikaCtrl'
        })
        // user funkciók
        .when('/kosar', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'user' && $rootScope.loggedUser.rights != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/kosar.html',
            controller: 'kosarCtrl'
        })
        .when('/rendeleseim', {
            resolve: {
                function($rootScope, $location) {
                    if ($rootScope.loggedUser.rights != 'user' && $rootScope.loggedUser.rights != 'admin') {
                        $location.path('/');
                    }
                }
            },
            templateUrl: 'views/rendeleseim.html',
            controller: 'rendelesCtrl'
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