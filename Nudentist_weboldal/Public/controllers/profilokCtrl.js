
app.controller('profilokCtrl', function($scope, DB, $rootScope,$routeParams){
    $scope.alreadyRated;
    $scope.doktor={};
    $scope.uzenetek=[];
    $scope.orvosok=[];
    $scope.userek=[];
    $scope.comms={};
    $scope.pointrating;
    $scope.assignedpoints=false;
    $scope.sajatErtekeles=[];
    $scope.message;
    $scope.csillagok;
    $scope.ertekelesek=[];
    $scope.modositandoID;
    $scope.wasRated=false;
    $scope.kedvencek=[];


    if($rootScope.loggedUser){
        DB.select('kedvencek','userID',$rootScope.loggedUser.ID).then(function(res){
            $scope.kedvencek=res.data;
        })
    }
    
    DB.selectAll('ertekelesek').then(function(res) {
        $scope.ertekelesek = res.data;
    });
    DB.selectAll('orvosok').then(function(res) {
        $scope.orvosok = res.data;
    });
    DB.selectAll('users').then(function(res) {
        $scope.userek = res.data;
    });

    if($routeParams.id!=null){
        DB.select('orvosok','ID',$routeParams.id).then(function(res){
            $scope.doktor=res.data[0];
            $scope.setup(res.data[0].ID);
        })
        
    }

    $scope.setup=function(id){
        if($rootScope.loggedUser){
            for(let i = 0; i < $scope.ertekelesek.length; i++){
                for(let i = 0; i < $scope.kedvencek.length; i++){
                    if( $scope.kedvencek[i].orvosID==id){
                        if(!document.getElementById('heart').classList.contains('bi-heart-fill')){
                            document.getElementById('heart').classList.replace('bi-heart','bi-heart-fill')
                        }
                    }
                }
                if(id==$scope.ertekelesek[i].orvosID&&$rootScope.loggedUser.ID==$scope.ertekelesek[i].paciensID){
                    $scope.loaduserdata($scope.ertekelesek[i].csillagok,id);
                    break;
                }
            }
        }
        
    }
    $scope.loaduserdata=function(csillagok,ID){
        
        switch(csillagok){
            case 1:
                    if(document.getElementById('star_1').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 2:
                    if(document.getElementById('star_2').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 3:
                    if(document.getElementById('star_3').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 4:
                    if(document.getElementById('star_4').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_4').classList.replace('bi-star','bi-star-fill')
                    }
                    break;
                case 5:
                    if(document.getElementById('star_5').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_4').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_5').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
        }
    }
    
    DB.selectAll('uzenetek').then(function(res){
        $scope.uzenetek=res.data;
    })
    DB.select('ertekelesek','orvosID',$routeParams.id).then(function(res){
        $scope.sajatErtekeles=res.data;
        if($scope.sajatErtekeles.length>0){
            $scope.wasRated=true;
        }
    })
    $scope.favourite=function(id){
        let notfav=true;
        let helperid;
        for (let i = 0; i < $scope.kedvencek.length; i++){
            if($scope.kedvencek[i].orvosID==id){
                helperid=$scope.kedvencek[i].ID;
                document.getElementById('heart').classList.replace('bi-heart-fill','bi-heart')
                $scope.kedvencek.splice(i,1)
                DB.delete('kedvencek','ID',helperid).then(function(res){
                    alert('Sikeresen eltávolítva a kedvencek közül!');
                })
                notfav=false;
                break;
            }
        }
        if($scope.kedvencek.length>2){
            alert('Maximum 3 kedvenc orvos lehet.')
        }else if(notfav&&$scope.kedvencek.length>0){
            for(let i = 0; i < $scope.kedvencek.length; i++){
                if(notfav&&$scope.kedvencek[i].orvosID!=id){
                    data={
                        'userID':$rootScope.loggedUser.ID,
                        'orvosID':id
                        }
                    DB.insert('kedvencek',data).then(function(res){
                        alert('Kedvenc orvos felvéve.')
                            
                        document.getElementById('heart').classList.replace('bi-heart','bi-heart-fill')
                    })
                    
                }
            }
        }else if(notfav){
            data={
                'userID':$rootScope.loggedUser.ID,
                'orvosID':id
                }
            DB.insert('kedvencek',data).then(function(res){
                alert('Kedvenc orvos felvéve.')
                    
                document.getElementById('heart').classList.replace('bi-heart','bi-heart-fill')
            })
        }
        
    }

    $scope.rate= function(){
        $scope.alreadyRated=true;
        if($scope.pointrating==null&&$scope.comms.rating_text==null){
            alert('Nem adott meg semmiféle értékelést!')
        }else{
            if($scope.comms.rating_text==null){
                let data={
                        orvosID:$scope.doktor.ID,
                        paciensID:$rootScope.loggedUser.ID,
                        szoveges:'',
                        csillagok:$scope.pointrating
                }
                if(!$scope.alreadyRated){
    
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
                else{
    
                
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
        if($scope.assignedpoints==false){
            $scope.assignedpoints=true;
            switch(starnum){
                case 1:
                    if(document.getElementById('star_1').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 2:
                    if(document.getElementById('star_2').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 3:
                    if(document.getElementById('star_3').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
                case 4:
                    if(document.getElementById('star_4').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_4').classList.replace('bi-star','bi-star-fill')
                    }
                    break;
                case 5:
                    if(document.getElementById('star_5').classList.contains('bi-star')){
                        document.getElementById('star_1').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_2').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_3').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_4').classList.replace('bi-star','bi-star-fill')
                        document.getElementById('star_5').classList.replace('bi-star','bi-star-fill')
                    }
                    
                    break;
            }
        }else if($scope.assignedpoints)
        {
            $scope.assignedpoints=false;
            switch(starnum){
                case 1:
                    if(document.getElementById('star_1').classList.contains('bi-star-fill')&&!document.getElementById('star_5').classList.contains('bi-star-fill')&&!document.getElementById('star_4').classList.contains('bi-star-fill')&&!document.getElementById('star_3').classList.contains('bi-star-fill')){
                        document.getElementById('star_1').classList.replace('bi-star-fill','bi-star')
                    }
                    
                    document.getElementById('star_2').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_3').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_4').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_5').classList.replace('bi-star-fill','bi-star')
                    break;
                case 2:
                    if(document.getElementById('star_2').classList.contains('bi-star-fill')&&!document.getElementById('star_5').classList.contains('bi-star-fill')&&!document.getElementById('star_4').classList.contains('bi-star-fill')&&!document.getElementById('star_3').classList.contains('bi-star-fill')){
                        document.getElementById('star_1').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_2').classList.replace('bi-star-fill','bi-star')
                    }
                    document.getElementById('star_3').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_4').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_5').classList.replace('bi-star-fill','bi-star')
                    break;
                case 3:
                    if(document.getElementById('star_3').classList.contains('bi-star-fill')&&!document.getElementById('star_5').classList.contains('bi-star-fill')&&!document.getElementById('star_4').classList.contains('bi-star-fill')){
                        document.getElementById('star_1').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_2').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_3').classList.replace('bi-star-fill','bi-star')
                    }
                    document.getElementById('star_4').classList.replace('bi-star-fill','bi-star')
                    document.getElementById('star_5').classList.replace('bi-star-fill','bi-star')
                    break;
                case 4:
                    if(document.getElementById('star_4').classList.contains('bi-star-fill')&&!document.getElementById('star_5').classList.contains('bi-star-fill')){
                        document.getElementById('star_1').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_2').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_3').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_4').classList.replace('bi-star-fill','bi-star')
                    }
                    document.getElementById('star_5').classList.replace('bi-star-fill','bi-star')
    
                    break;
                case 5:
                    if(document.getElementById('star_5').classList.contains('bi-star-fill')){
                        document.getElementById('star_1').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_2').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_3').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_4').classList.replace('bi-star-fill','bi-star')
                        document.getElementById('star_5').classList.replace('bi-star-fill','bi-star')
                    }
                    
                    break;
            }

        }
        
        $scope.pointrating=starnum;
    }
    
});
