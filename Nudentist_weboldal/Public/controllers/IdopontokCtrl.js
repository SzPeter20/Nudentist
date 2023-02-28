app.controller('IdopontCtrl', function($scope, DB, $rootScope, $location) {
    $scope.idopont={};
    $scope.idopontok={};
    DB.selectAll('idopontok').then(function(res) {
        $scope.idopontok = res.data;
    });  

    $scope.foglalas=function() {
        if ($scope.user.name == null || $scope.user.email == null) {
            alert('Nem adtál meg minden kötelező adatot!');
        } else {
                    let data = {
                        nev: $scope.user.name,
                        email: $scope.user.email,
                        telefonszam: $scope.user.phone,
                        datum:$scope.user.datum,
                        idopont:$scope.user.idopont,
                        paciensID:$rootScope.loggedUser.ID,
                        
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
