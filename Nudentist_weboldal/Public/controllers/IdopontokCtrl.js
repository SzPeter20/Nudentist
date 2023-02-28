app.controller('IdopontokCtrl', function($scope, DB, $rootScope, $location) {
    $scope.idopont={};
    $scope.idopontok={};
    DB.selectAll('idopontok').then(function(res) {
        $scope.idopontok = res.data;
    });  

    $scope.foglalas=function() {
        if ($scope.idopont.nev == null || $scope.idopont.email == null) {
            alert('Nem adtál meg minden kötelező adatot!');
        } else {
            
                    let data = {
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
