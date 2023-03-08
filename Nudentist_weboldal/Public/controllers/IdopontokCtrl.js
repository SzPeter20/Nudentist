app.controller('IdopontokCtrl', function($scope, DB, $rootScope, $location) {
    $scope.idopont={};
    $scope.idopontok={};
    $scope.Munkatarsak = [];
    
    DB.selectAll('idopontok').then(function(res) {
        $scope.idopontok = res.data;
    });
    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });  
    $scope.elfogad=function(id){
    
    }

    $scope.elutasit=function(id){
        
        
    }
    $scope.foglalas=function() {
        console.log($scope.idopont.id)
        if ( $scope.idopont.idopont==null||$scope.idopont.datum==null ||$scope.idopont.orvosid==null) {
            alert('Nem adtál meg minden kötelező adatot!');
        } else {
                    
                    let data = {
                        
                        orvosID:$scope.idopont.orvosid,
                        nev: $rootScope.loggedUser.nev,
                        email: $rootScope.loggedUser.email,
                        telefonszam: $rootScope.loggedUser.telefonszam,
                        datum:moment(new Date($scope.idopont.datum)).format('YYYY-MM-DD'),
                        idopont:$scope.idopont.idopont,
                        paciensID:$rootScope.loggedUser.ID,
                        status:'Elfogadásra vár'
                    }
                    console.log(data);
                    
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
