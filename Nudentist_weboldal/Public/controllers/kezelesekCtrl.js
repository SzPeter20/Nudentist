app.controller('kezelesekCtrl', function($scope, DB, $rootScope,) {
    $scope.kezelesek=[];
    $scope.kezeles={};
    $scope.db = [];
    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        
    });
});
