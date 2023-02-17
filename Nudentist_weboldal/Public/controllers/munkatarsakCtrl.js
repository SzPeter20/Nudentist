app.controller('munkatarsakCtrl', function($scope, DB, $rootScope,) {
    $scope.munkatarsak=[];
    $scope.munkas={};
   
    DB.selectAll('orvosok').then(function(res) {
        $scope.munkatarsak= res.data;
        
    });
});
