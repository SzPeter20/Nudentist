app.controller('kedvencekCtrl', function($scope, DB, $rootScope, $location) {
    $scope.Munkatarsak = [];
    $scope.userek=[];
    $scope.kedvencek=[];
    $scope.sajatkedvencek=[];

    DB.select('kedvencek','userID',$rootScope.loggedUser.ID).then(function(res){
        $scope.sajatkedvencek=res.data;
        console.log($scope.kedvencek);
        /*
        for(let i = 0; i < $scope.Munkatarsak.length; i++){
            for(let j = 0; j < $scope.kedvencek.length; j++){
                if($scope.Munkatarsak[i].ID==$scope.kedvencek[j].orvosID){
                    $scope.sajatkedvencek.push($scope.Munkatarsak[j])
                }
            }
            
        }
        */
    })
    DB.selectAll('orvosok').then(function(res){
        $scope.Munkatarsak=res.data;
        console.log($scope.Munkatarsak);
    })
    DB.selectAll('users').then(function(res){
        $scope.userek=res.data;
    })
    $scope.toDocProfile=function(id){
        $location.path('/dokprofil/' + id)
    }

});