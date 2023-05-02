app.controller('munkatarsakCtrl', function($scope, DB, $rootScope, fileUpload,$location) {

    $scope.Munkatarsak = [];


    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });  
    $scope.toDocProfile=function(id){
        $location.path('/dokprofil/' + id)
    }
});