app.controller('kezelesCtrl', function($scope, DB, $rootScope,$routeParams,$location){
    $scope.kezeles={};
    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
        for (let i = 0; i < $scope.Munkatarsak.length; i++) {
            $scope.db[i] = 1;
        }
    });
    $scope.toDocProfile=function(id){
        $location.path('/dokprofil/' + id)
    }  
    if($routeParams.id!=null){
        DB.select('kezelesek','ID',$routeParams.id).then(function(res){
            $scope.kezeles = res.data[0]
        }
)}

    }
)