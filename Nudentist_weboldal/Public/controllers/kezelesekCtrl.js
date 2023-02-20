app.controller('kezelesekCtrl', function($scope, DB, $rootScope,) {
    $scope.kezelesek;
    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        
    });
    
    $scope.cheatsheet=function(){
        console.log("asd")
    }
});
