app.controller('kezelesekCtrl', function($scope, DB, $rootScope,$location) {

    $scope.chosenKezeles={};
    $scope.kategoriak=[];
    $scope.kezelesek=[];

    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        
    });
    DB.selectDistinct('kezelesek','kategoria').then(function(res){
        $scope.kategoriak=res.data;
    })

    $scope.chooseKezeles=function(id){
        console.log(id)
        $location.path('/kezeles/' + id)
    }
    
    $scope.cheatsheet=function(){
        console.log($scope.chosenKezeles)
    }
});
