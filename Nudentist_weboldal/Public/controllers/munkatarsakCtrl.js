app.controller('munkatarsakCtrl', function($scope, DB, $rootScope,) {
    $scope.munkatarsak=[];
    $scope.munkas={};
    $scope.db = [];
    DB.selectAll('orvosok').then(function(res) {
        $scope.munkatarsak= res.data;
        for (let i = 0; i < $scope.munkatarsak.length; i++) {
            $scope.db[i] = 1;
        }
    });
});
