app.controller('uzenetCtrl', function($scope, DB, $rootScope,$routeParams, $location){
    $scope.uzenet={};
    if($routeParams.id!=null){1
        DB.select('uzenetek','ID',$routeParams.id).then(function(res){
            $scope.uzenet = res.data[0]
        }
    )}
    $scope.message={};
    $scope.userek=[];
    $scope.cimzett;
    $scope.mail;
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
            if($scope.userek[i].nev==$scope.cimzett){
                $scope.cimzettid=$scope.userek.ID
            }
        }
            if($rootScope.loggedUser.jogok=='users'){
                let data = {
                    senderid: $rootScope.loggedUser.ID,
                    sendertype: $rootScope.loggedUser.jogok,
                    recipientID: $scope.message.user,
                    recipienttype: 'doktor',
                    title: $scope.cim,
                    tartalom: $scope.tartalom,
                    datum: moment(new Date()).format('YYYY-MM-DD')
                }
                DB.insert('uzenetek', data).then(function(res) {
                    if (res.data.affectedRows != 0) {
                        alert('Üzenet sikeresen elküldve!');
                        $scope.cimzett = '';
                        $scope.mail = '';
                    } else {
                        alert('Váratlan hiba történt az adatbázis művelet során!');
                    }
                });
            }else if($rootScope.loggedUser.jogok=='doktor'){
                let data = {
                    senderid: $rootScope.loggedUser.ID,
                    sendertype: $rootScope.loggedUser.jogok,
                    recipientID: $scope.message.user,
                    recipienttype: 'user',
                    title: $scope.mail.cim,
                    tartalom: $scope.mail.tartalom,
                    datum: moment(new Date()).format('YYYY-MM-DD')
                }
                DB.insert('uzenetek', data).then(function(res) {
                    if (res.data.affectedRows != 0) {
                        alert('Üzenet sikeresen elküldve!');
                        $scope.cimzett = '';
                        $scope.mail = '';
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