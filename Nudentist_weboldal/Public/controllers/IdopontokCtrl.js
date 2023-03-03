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
        console.log($scope.idopont.id)
        if ( $scope.idopont.idopont==null||$scope.idopont.datum==null ||$scope.idopont.id==null) {
            alert('Nem adtál meg minden kötelező adatot!');
        } else {
                    
                    let data = {
                        
                        orvosID:$scope.idopont.id,
                        nev: $rootScope.loggedUser.nev,
                        email: $rootScope.loggedUser.email,
                        telefonszam: $rootScope.loggedUser.telefonszam,
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
