app.controller('uzenetCtrl', function($scope, DB, $rootScope,$routeParams, $location){
    $scope.uzenet={};
    if($routeParams.id!=null){1
        DB.select('uzenetek','ID',$routeParams.id).then(function(res){
            $scope.uzenet = res.data[0]
        }
    )}
    $scope.message={};
    $scope.userek=[];
    $scope.cimzettid;

    if($rootScope.loggedUser.jogok=='user'){
        DB.selectAll('orvosok').then(function(res) {
            $scope.userek= res.data;
            
        });
    }else{
        DB.selectAll('users').then(function(res) {
            $scope.userek= res.data;
            
        });
    }
    
    
    $scope.backToMessages=function(){
        $location.path('/uzenetek')
    }

    $scope.sendMessage=function(){
        
            for (let i = 0; i < $scope.userek.length; i++){
                if($scope.userek[i].nev==$scope.message.user){
                    $scope.cimzettid=$scope.userek[i].ID
                }
            }
    
                if($rootScope.loggedUser.jogok=='user'){
                    let data = {
                        senderid: $rootScope.loggedUser.ID,
                        sendertype: $rootScope.loggedUser.jogok,
                        recipientID: $scope.cimzettid,
                        recipienttype: 'doktor',
                        title: $scope.message.cim,
                        tartalom: $scope.message.tartalom,
                        datum: moment(new Date()).format('YYYY-MM-DD')
                    }
                    DB.insert('uzenetek', data).then(function(res) {
                        if (res.data.affectedRows != 0) {
                            alert('Üzenet sikeresen elküldve!');
                            $scope.cimzettid = '';
                            $scope.message = '';
                        } else {
                            alert('Váratlan hiba történt az adatbázis művelet során!');
                        }
                    });
                }else if($rootScope.loggedUser.jogok=='doktor'){
                    let data = {
                        senderid: $rootScope.loggedUser.ID,
                        sendertype: $rootScope.loggedUser.jogok,
                        recipientID: $scope.cimzettid,
                        recipienttype: 'user',
                        title: $scope.message.cim,
                        tartalom: $scope.message.tartalom,
                        datum: moment(new Date()).format('YYYY-MM-DD')
                    }
                    DB.insert('uzenetek', data).then(function(res) {
                        if (res.data.affectedRows != 0) {
                            alert('Üzenet sikeresen elküldve!');
                            $scope.cimzettid = '';
                            $scope.message = '';
                        } else {
                            alert('Váratlan hiba történt az adatbázis művelet során!');
                        }
                    });
                    
                }
        }
    
    
    $scope.cucc=function(){
        console.log($scope.uzenet)
    }
    }
)