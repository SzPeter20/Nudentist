app.controller('kezelesekCtrl', function($scope, DB, $rootScope,) {
    $scope.kezelesek=[];
    $scope.rontgenek=[];
    $scope.potlasok=[];
    $scope.konzervalok=[];
    $scope.parodonok=[];
    $scope.sebeszetek=[];
    $scope.surgossegeg=[];
    $scope.lathatatlanok=[];
    $scope.kezeles={};
    $scope.db = [];
    DB.selectAll('kezelesek').then(function(res) {
        $scope.kezelesek= res.data;
        
    });
});
