app.controller('kedvencekCtrl', function($scope, DB, $rootScope, $location,$timeout) {
    $scope.Munkatarsak = [];
    $scope.userek=[];
    $scope.kedvencek=[];
    $scope.ownfav=[];

    DB.select('kedvencek','userID',$rootScope.loggedUser.ID).then(function(res) {
        $scope.kedvencek = res.data;
        $timeout(function(){$scope.find()},100)
    })
    $scope.find=function(){
        for (let i = 0; i < $scope.Munkatarsak.length; i++){
            for (let j = 0; j < $scope.kedvencek.length; j++){
                if($scope.Munkatarsak[i].ID==$scope.kedvencek[j].orvosID){
                    $scope.ownfav.push($scope.Munkatarsak[i])
                }
            }
            
        }
        console.log($scope.ownfav);
    }

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