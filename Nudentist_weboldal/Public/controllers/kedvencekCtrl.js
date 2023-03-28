app.controller('kedvencekCtrl', function($scope, DB, $rootScope, $location) {
    $scope.Munkatarsak = [];
    $scope.userek=[];

    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });
    DB.selectAll('users').then(function(res){
        $scope.userek=res.data;
    })
    $scope.toDocProfile=function(id){
        $location.path('/dokprofil/' + id)
    }

});