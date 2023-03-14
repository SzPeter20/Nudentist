
app.controller('profilokCtrl', function($scope, DB, $rootScope,$routeParams){
    $scope.alreadyRated;
    $scope.doktor={};
    $scope.uzenetek=[];
    $scope.comms={};
    $scope.pointrating;
    $scope.message;
    $scope.csillagok;
    $scope.ertekelesek;
    $scope.modositandoID;

    DB.selectAll('ertekelesek').then(function(res) {
        $scope.ertekelesek = res.data;
    });

    if($routeParams.id!=null){
        DB.select('orvosok','ID',$routeParams.id).then(function(res){
            $scope.doktor=res.data[0];
        })
    }

    
    DB.selectAll('uzenetek').then(function(res){
        $scope.uzenetek=res.data;
    })

    $scope.rate= function(){
        $scope.alreadyRated=true;
        for (let i = 0; i < $scope.ertekelesek.length; i++){
            if($scope.ertekelesek[i].orvosID==$scope.doktor.ID&&$scope.ertekelesek[i].paciensID==$rootScope.loggedUser.ID){
                $scope.modositandoID=$scope.ertekelesek[i].ID
                $scope.alreadyRated=false;
            }
        }


        if(false){
            alert("Kérjük értékelése tartalmazzon maximum 500 karaktert")
        }else{
            let data={
                orvosID:$scope.doktor.ID,
                paciensID:$rootScope.loggedUser.ID,
                szoveges:$scope.comms.rating_text,
                csillagok:$scope.pointrating
            }
            if($scope.alreadyRated){
                DB.insert("ertekelesek",data).then(function(res){
                    if (res.data.affectedRows != 0) {
                        alert('Sikeres értékelés!');
                        $scope.comms.rating_text='';
                        $scope.stringrating = '';
                        $scope.pointrating = 1;
                    } else {
                        alert('Váratlan hiba történt!');
                    }
                })
            }else{
                DB.update("ertekelesek",$scope.modositandoID,data).then(function(res){
                    if (res.data.affectedRows != 0) {
                        alert('Értékelés sikeresen megváltoztatva!');
                        $scope.comms.rating_text='';
                        $scope.stringrating = '';
                        $scope.pointrating = 1;
                    } else {
                        alert('Váratlan hiba történt az adatbázis művelet során!');
                    }
                })
            }
            
            }
    }
    $scope.message= function(){
        if($scope.message.length>500){
            alert("Kérjük üzenete tartalmazzon maximum 500 karaktert")
        }else{
            let data={
                senderID:$rootScope.loggedUser.ID,
                senderType:$rootScope.loggedUser.jogok,
                recipientID:$scope.doktor.ID,
                recipientType:$scope.doktor.jogok,
                title:$scope.comms.title,
                tartalom:$scope.comms.message_text,
                datum:moment(new Date()).format('YYYY-MM-DD'),
                olvasottsag:'olvasatlan'
            }

            DB.insert("uzenetek",data).then(function(res){
                if (res.data.affectedRows != 0) {
                    alert('Sikeres üzenet küldés!');
                    $scope.comms = {};
                } else {
                    alert('Váratlan hiba történt!');
                }
            })
        }
    }
    $scope.pointrate= function(starnum){
        switch(starnum)
        {
            case 1:
                $scope.pointrating=1;
            break;
            case 2:
                $scope.pointrating=2;
            break;

            case 3:
                $scope.pointrating=3;
            break;

            case 4:
                $scope.pointrating=4;
            break;

            case 5:
                $scope.pointrating=5;
            break;
        }
        console.log($scope.pointrating)
    }
    
});
