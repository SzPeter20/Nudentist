app.controller('kezelesekCtrl', function($scope, DB, $rootScope,) {

    $scope.kategoriak=[];
    $scope.kezelesek=[];

    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        
    });
    DB.selectDistinct('kezelesek','kategoria').then(function(res){
        $scope.kategoriak=res.data;
    })

    
    $scope.cheatsheet=function(){
        console.log($scope.kategoriak[0])
    }
});
