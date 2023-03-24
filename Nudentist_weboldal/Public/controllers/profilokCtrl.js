
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
    $scope.favourite=function(id){
        if($rootScope.loggedUser.kedvencekID==$scope.doktor.ID){
            document.getElementById('heart').classList.remove('bi-heart-fill')
            document.getElementById('heart').classList.add('bi-heart')
            let data={
                kedvencekID:null
            }
            DB.update('users',$rootScope.loggedUser.ID,data).then(function(res){
                if (res.data.affectedRows != 0) {
                    alert('Kedvenc orvos sikeresen eltávolítva!');
                    
                } else {
                    alert('Váratlan hiba történt az adatbázis művelet során!');
            }})
            $rootScope.loggedUser.kedvencekID=0;
        }else{
            document.getElementById('heart').classList.remove('bi-heart')
            document.getElementById('heart').classList.add('bi-heart-fill')
            $rootScope.loggedUser.kedvencekID=id;
            let data={
                kedvencekID:id
            }
            DB.update('users',$rootScope.loggedUser.ID,data).then(function(res){
                if (res.data.affectedRows != 0) {
                    alert('Kedvenc orvos sikeresen felvéve!');
                    
                } else {
                    alert('Váratlan hiba történt az adatbázis művelet során!');
                }
            })
        }
        
    }

    $scope.rate= function(){
        $scope.alreadyRated=true;
        for (let i = 0; i < $scope.ertekelesek.length; i++){
            if($scope.ertekelesek[i].orvosID==$scope.doktor.ID&&$scope.ertekelesek[i].paciensID==$rootScope.loggedUser.ID){
                $scope.modositandoID=$scope.ertekelesek[i].ID
                $scope.alreadyRated=false;
            }
        }


        if($scope.comms.rating_text.length>500){
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
        if($scope.comms.message_text==null||$scope.comms.title==null){
            alert('Nem adott meg minden szükséges adatot!')
        }
        else{
            if($scope.comms.message_text.length>500){
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
        
    }
    $scope.pointrate= function(starnum){
            $scope.pointrating=starnum;
    }
    $scope.heartHover=function(){
        document.getElementById('heart').classList.remove('bi-heart')
        document.getElementById('heart').classList.add('bi-heart-fill')
    }
    $scope.heartLeave=function(){
        document.getElementById('heart').classList.add('bi-heart')
        document.getElementById('heart').classList.remove('bi-heart-fill')
    }
    $scope.starHover = function(num) {
        switch(num)
        {
            case 1:
                document.getElementById('star_1').classList.remove('bi-star')
                document.getElementById('star_1').classList.add('bi-star-fill')
                break;
            case 2:
                document.getElementById('star_1').classList.remove('bi-star')
                document.getElementById('star_1').classList.add('bi-star-fill')
                document.getElementById('star_2').classList.remove('bi-star')
                document.getElementById('star_2').classList.add('bi-star-fill')
                break;
            case 3:
                document.getElementById('star_1').classList.remove('bi-star')
                document.getElementById('star_1').classList.add('bi-star-fill')
                document.getElementById('star_2').classList.remove('bi-star')
                document.getElementById('star_2').classList.add('bi-star-fill')
                document.getElementById('star_3').classList.remove('bi-star')
                document.getElementById('star_3').classList.add('bi-star-fill')
                break;
            case 4:
                document.getElementById('star_1').classList.remove('bi-star')
                document.getElementById('star_1').classList.add('bi-star-fill')
                document.getElementById('star_2').classList.remove('bi-star')
                document.getElementById('star_2').classList.add('bi-star-fill')
                document.getElementById('star_3').classList.remove('bi-star')
                document.getElementById('star_3').classList.add('bi-star-fill')
                document.getElementById('star_4').classList.remove('bi-star')
                document.getElementById('star_4').classList.add('bi-star-fill')

                break;
            case 5:
                document.getElementById('star_1').classList.remove('bi-star')
                document.getElementById('star_1').classList.add('bi-star-fill')
                document.getElementById('star_2').classList.remove('bi-star')
                document.getElementById('star_2').classList.add('bi-star-fill')
                document.getElementById('star_3').classList.remove('bi-star')
                document.getElementById('star_3').classList.add('bi-star-fill')
                document.getElementById('star_4').classList.remove('bi-star')
                document.getElementById('star_4').classList.add('bi-star-fill')
                document.getElementById('star_5').classList.remove('bi-star')
                document.getElementById('star_5').classList.add('bi-star-fill')
                break;
        }
        
    }

    $scope.starLeave = function(num) {
        switch(num)
        {
            case 1:
                document.getElementById('star_1').classList.remove('bi-star-fill')
                document.getElementById('star_1').classList.add('bi-star')
                break;
            case 2:
                document.getElementById('star_1').classList.remove('bi-star-fill')
                document.getElementById('star_1').classList.add('bi-star')
                document.getElementById('star_2').classList.remove('bi-star-fill')
                document.getElementById('star_2').classList.add('bi-star')
                break;
            case 3:
                document.getElementById('star_1').classList.remove('bi-star-fill')
                document.getElementById('star_1').classList.add('bi-star')
                document.getElementById('star_2').classList.remove('bi-star-fill')
                document.getElementById('star_2').classList.add('bi-star')
                document.getElementById('star_3').classList.remove('bi-star-fill')
                document.getElementById('star_3').classList.add('bi-star')
                break;
            case 4:
                document.getElementById('star_1').classList.remove('bi-star-fill')
                document.getElementById('star_1').classList.add('bi-star')
                document.getElementById('star_2').classList.remove('bi-star-fill')
                document.getElementById('star_2').classList.add('bi-star')
                document.getElementById('star_3').classList.remove('bi-star-fill')
                document.getElementById('star_3').classList.add('bi-star')
                document.getElementById('star_4').classList.remove('bi-star-fill')
                document.getElementById('star_4').classList.add('bi-star')
                break;
            case 5:
                document.getElementById('star_1').classList.remove('bi-star-fill')
                document.getElementById('star_1').classList.add('bi-star')
                document.getElementById('star_2').classList.remove('bi-star-fill')
                document.getElementById('star_2').classList.add('bi-star')
                document.getElementById('star_3').classList.remove('bi-star-fill')
                document.getElementById('star_3').classList.add('bi-star')
                document.getElementById('star_4').classList.remove('bi-star-fill')
                document.getElementById('star_4').classList.add('bi-star')
                document.getElementById('star_5').classList.remove('bi-star-fill')
                document.getElementById('star_5').classList.add('bi-star')
                break;
        }
        
    }
});
