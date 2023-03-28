app.controller('kedvencekCtrl', function($scope, DB, $rootScope, $location) {
    $scope.Munkatarsak = [];
    $scope.kedvencek=[];


    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });


});