app.controller('munkatarsakCtrl', function($scope, DB, $rootScope, fileUpload,$location) {

    $scope.Munkatarsak = [];
    $scope.Munkatars = {};
    $scope.db = [];
    $scope.chosenDoc;

    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
        for (let i = 0; i < $scope.Munkatarsak.length; i++) {
            $scope.db[i] = 1;
        }
    });  
    $scope.toDocProfile=function(id){
        $location.path('/dokprofil/' + id)
    }
});