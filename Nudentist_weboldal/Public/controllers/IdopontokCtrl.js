app.controller('IdopontokCtrl', function($scope, DB, $rootScope, $location) {
    $scope.idopont={};
    $scope.idopontok={};
    $scope.Munkatarsak = [];
    $scope.Munkatars = {};
    DB.selectAll('idopontok').then(function(res) {
        $scope.idopontok = res.data;
    });
    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });  

    $scope.foglalas=function() {
        if ($scope.idopont.nev == null || $scope.idopont.email == null || $scope.idopont.orvos==null) {
            alert('Nem adtál meg minden kötelező adatot!');
        } else {
                    let idx=$scope.Munkatarsak.findIndex(item => (item.orvosID == $scope.idopont.orvos));
                    let data = {
                        
                        orvosID:$scope.Munkatarsak[idx].ID,
                        nev: $scope.idopont.nev,
                        email: $scope.idopont.email,
                        telefonszam: $scope.idopont.phone,
                        datum:moment(new Date($scope.idopont.datum)).format('YYYY-MM-DD'),
                        idopont:$scope.idopont.idopont,
                        paciensID:$rootScope.loggedUser.ID
                        
                    }

                    DB.insert('idopontok', data).then(function(res) {
                        if (res.data.affectedRows != 0) {
                            alert('Sikeres időpont foglalás');
                            $scope.idopont = {};
                        } else {
                            alert('Váratlan hiba történt!');
                        }
                }
            );
        }
    };
}

);
