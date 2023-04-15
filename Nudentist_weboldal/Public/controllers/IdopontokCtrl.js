app.controller('IdopontokCtrl', function($scope, DB, $rootScope, $location) {
    $scope.idopont={};
    $scope.idopontok=[];
    $scope.Munkatarsak = [];
    
    $scope.sajatIdopontok=[];
    $scope.dates={};

    $scope.dates.minDate=moment().add(1, 'days').calendar();
    $scope.dates.maxDate=moment().add(10, 'days').calendar();

    DB.selectAll('idopontok').then(function(res) {
        $scope.idopontok = res.data;
    });
    DB.select('idopontok','paciensID',$rootScope.loggedUser.ID).then(function(res){
        $scope.sajatIdopontok=res.data;
    });
    DB.selectAll('orvosok').then(function(res) {
        $scope.Munkatarsak = res.data;
    });  
    $scope.elfogad=function(id){
        for (let i = 0; i < $scope.idopontok.length; i++) {
            if( $scope.idopontok[i].ID==id){
                $scope.idopontok[i].status='Elfogadva'
                let values={
                    status:'Elfogadva'
                }
                DB.update('idopontok', id,values).then(function(res) {
                    
                })
            }
            
        }
    }

    $scope.elutasit=function(id){
        for (let i = 0; i < $scope.idopontok.length; i++) {
            if( $scope.idopontok[i].ID==id){
                $scope.idopontok[i].status='Elutasítva'
                let values={
                    status:'Elutasítva'
                }
                DB.update('idopontok', id,values).then(function(res) {
                    
                })
            }
            
        }
        
    }
    $scope.foglalas=function() {
        console.log($scope.idopont.id)
        if ( $scope.idopont.idopont==null||$scope.idopont.datum==null ||$scope.idopont.orvosid==null) {
            alert('Nem adott meg minden kötelező adatot!');
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
