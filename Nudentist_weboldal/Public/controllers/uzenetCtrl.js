app.controller('uzenetCtrl', function($scope, DB, $rootScope,$routeParams){
    $scope.uzenet={};
    if($routeParams.id!=null){1
        DB.select('uzenetek','ID',$routeParams.id).then(function(res){
            $scope.uzenet = res.data[0]
        }
    )}

    $scope.cimzett;
    $scope.mail;
    $scope.sendMessage=function(){
        if($rootScope.loggedUser.jogok==='users'){
            let data = {
                senderid: $rootScope.loggedUser.ID,
                sendertype: $rootScope.loggedUser.jogok,
                recipientid: $scope.cimzett,
                recipienttype: 'doktor',
                title: $scope.cim,
                tartalom: $scope.tartalom,
                datum: $scope.ma
            }
        }else if($rootScope.loggedUser.jogok==='doktor'){
            let data = {
                senderid: $rootScope.loggedUser.ID,
                sendertype: $rootScope.loggedUser.jogok,
                recipientid: $scope.cimzett,
                recipienttype: 'user',
                title: $scope.mail.cim,
                tartalom: $scope.mail.tartalom,
                datum: $scope.ma
            }
        }
        

        DB.insert('uzenetek', data).then(function(res) {
            if (res.data.affectedRows != 0) {
                alert('Üzenet sikeresen elküldve!');
                $scope.cimzett = {};
                $scope.mail = {};
            } else {
                alert('Váratlan hiba történt az adatbázis művelet során!');
            }
        });
    }
    
    $scope.cucc=function(){
        console.log($scope.uzenet)
    }
    }
)