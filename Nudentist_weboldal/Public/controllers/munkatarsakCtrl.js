app.controller('munkatarsakCtrl', function($scope, DB, $rootScope,) {
    $scope.munkatarsak=[];
    $scope.munkas={};
    $scope.db = [];
    DB.selectAll('users').then(function(res) {
        $scope.munkatarsak= res.data;
        
    });
});
