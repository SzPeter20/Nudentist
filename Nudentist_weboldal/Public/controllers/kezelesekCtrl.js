app.controller('kezelesekCtrl', function($scope, DB, $rootScope,) {

    $scope.chosenKezeles=[];
    $scope.kategoriak=[];
    $scope.kezelesek=[];

    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        for (let i = 0; i < $scope.kezelesek.length; i++) {
            $scope.db[i] = 1;
        }
    });
    DB.selectDistinct('kezelesek','kategoria').then(function(res){
        $scope.kategoriak=res.data;
    })

    
    $scope.cheatsheet=function(){
        DB.select('kezelesek','ID',1).then(function(res){
            console.log(res.data)
        })
    }
    $scope.idtransfer=function(id){
        DB.select('kezelesek','ID',id).then(function(res){
            $scope.chosenKezeles=res.data;
        })
        console.log($scope.chosenKezeles)
    }
});
