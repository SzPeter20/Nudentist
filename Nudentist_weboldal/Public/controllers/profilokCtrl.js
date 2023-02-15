app.controller('profilCtrl', function($scope, DB, $rootScope,) {
    $scope.munkatarsak=[];
    DB.selectAll('orvosok').then(function(res) {
        $scope.munkatarsak= res.data;
        for (let i = 0; i < $scope.munkatarsak.length; i++) {
            $scope.db[i] = 1;
        }
    });
    $scope.userek=[];
    DB.selectAll('users').then(function(res) {
        $scope.userek= res.data;
        for (let i = 0; i < $scope.userek.length; i++) {
            $scope.db[i] = 1;
        }
    });
});
