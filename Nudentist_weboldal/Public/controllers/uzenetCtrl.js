app.controller('uzenetCtrl', function($scope, DB, $rootScope,$routeParams){
    $scope.uzenet={};
    if($routeParams.id!=null){1
        DB.select('uzenetek','ID',$routeParams.id).then(function(res){
            $scope.uzenet = res.data[0]
        }
    )}

    $scope.cucc=function(){
        console.log($scope.uzenet)
    }
    }
)