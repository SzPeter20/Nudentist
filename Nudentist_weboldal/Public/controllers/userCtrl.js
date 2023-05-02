app.controller('userCtrl', function($scope, DB, $rootScope, $location,fileUpload) {
    $scope.uzenetek=[];
    $scope.doktorok=[];
    $scope.userek=[];
    $scope.sender=[];
    $scope.vanOlvasattlanUzenet=false;
    $scope.user={};

    if($rootScope.loggedUser!=null){
        DB.select('uzenetek','recipientID',$rootScope.loggedUser.ID).then(function(res){
            $scope.uzenetek=res.data;
            for(let i = 0; i < $scope.uzenetek.length; i++){
                if($scope.uzenetek[i].olvasottsag=='olvasatlan'){
                    $scope.vanOlvasattlanUzenet=true;
    
                }
            }
        })
        
        
    }
    
    
    $scope.deleteMessage=function(id){
        for(let i = 0; i < $scope.uzenetek.length; i++){
            if($scope.uzenetek[i].recipientID==$rootScope.loggedUser.ID&&$scope.uzenetek[i].ID==id){
                $scope.uzenetek.splice(i)
            }
        }
        DB.delete('uzenetek','ID',id).then(function(res){
            alert('Üzenet sikeresen törölve!');
        })

    }
    $scope.toMessageContent=function(id){
        for (let i = 0; i < $scope.uzenetek.length; i++){
            if($scope.uzenetek[i].ID==id){
                data={olvasottsag:'olvasott'}
                DB.update('uzenetek',id,data)
            }
        }
        $location.path('/uzenet/'+id)
        
    }
    
    DB.selectAll('orvosok').then(function(res){
        $scope.doktorok=res.data;
    })
    DB.selectAll('users').then(function(res){
        $scope.userek=res.data;
    })

    
    /*
    Vigh Ákos müve:
      55555555557777777777777777777777777777777777222222222222
      2

      2
      1
      1561461611
      131
      31
    */
    $scope.registration = function() {
        if ($scope.user.name == null || $scope.user.email == null || $scope.user.pass1 == null || $scope.user.pass2 == null) {
            alert('Nem adott meg(helyesen) minden kötelező adatot!');
        } else {
            if ($scope.user.pass1 != $scope.user.pass2) {
                alert('A megadott jelszavak nem egyeznek!');
            } else {
                var pwd_pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
                if (!$scope.user.pass1.match(pwd_pattern)) {
                    alert('A megadott jelszó nem felel meg a minimális biztonsági követelményeknek!');
                } else {
                    var email_pattern = /(?:[a-z0-9+!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/gi;
                    if (!$scope.user.email.match(email_pattern)) {
                        alert('Nem megfelelő email');    
                }else{
                    let data = {
                        nev: $scope.user.name,
                        email: $scope.user.email,
                        password: CryptoJS.SHA1($scope.user.pass1).toString(),
                        telefonszam: $scope.user.phone,
                        jogok: 'user'
                    }
                    DB.insert('users', data).then(function(res) {
                        if (res.data.affectedRows != 0) {
                            alert('A regisztráció sikeres! Beléphetsz az oldalra!');
                            $scope.user = {};
                        } else {
                            alert('Váratlan hiba történt az adatbázis művelet során!');
                        }
                    });
                }  
                }
            }
            
        }
    };
    $scope.mod = function() {
        let data={};
        

        if($rootScope.loggedUser.jogok=='doktor'){
            if($scope.user.nev==null&&$scope.user.email==null&&$scope.user.phone==null&&$scope.user.studies==null&&$scope.user.field==null&&$scope.user.desc==null){
                alert('Nem változtat meg semmilyen adatot.')
            }else{

            
            if($scope.user.nev!=null){
                data.nev=$scope.user.nev;
            }
            if($scope.user.email!=null){
                data.email=$scope.user.email;
            }
            if($scope.user.telefonszam!=null){
                data.telefonszam=$scope.user.telefonszam;
            }
            if($scope.user.szakterulet!=null){
                data.szakterulet=$scope.user.szakterulet;
            }
            if($scope.user.tanulmanyok!=null){
                data.tanulmanyok=$scope.user.tanulmanyok;
            }
            if($scope.user.bemutatkozas!=null){
                data.bemutatkozas=$scope.user.bemutatkozas;
            }
            if(file!=null){
            
                console.log(file.filename);
                let uploadUrl='http://localhost:3000/fileupload';
                fileUpload.uploadFile(file, uploadUrl).then(function(res) {
                    filename = res.data.filename;
                    //filename.substring(0, filename.lastIndexOf('.'));
                    data.kep=filename;
                    console.log(filename);
                    console.log(file.filename);
                    alert('aaaa')
                })
            }
            if(data!=null){
                DB.update('orvosok',$rootScope.loggedUser.ID, data).then(function(res) {
                    if (res.data.affectedRows != 0) {
                        alert('Adatok sikeresen megváltoztatva!');
                        $scope.user = {};
                    } else {
                        alert('Váratlan hiba történt az adatbázis művelet során!');
                    }
                })
            }
        }
        }else {
            if($scope.user.nev==null&&$scope.user.email==null&&$scope.user.phone==null){
                alert('Nem változtat meg semmilyen adatot.')
            }else{
                    if($scope.user.nev!=null){
                        data.nev=$scope.user.nev;
                    }
                    if($scope.user.email!=null){
                        data.email=$scope.user.email;
                    }
                    if($scope.user.telefonszam!=null){
                        data.telefonszam=$scope.user.telefonszam;
                    }
                    
                    if(data!=null){
                        console.log(data);
                        DB.update('users',$rootScope.loggedUser.ID, data).then(function(res) {
                            if (res.data.affectedRows != 0) {
                                alert('Adatok sikeresen megváltoztatva!');
                                $scope.user = {};
                            } else {
                                alert('Váratlan hiba történt az adatbázis művelet során!');
                                }
                            }
                        );
                    }
                }
        }
    
    };

    $scope.passwdmod=function(){
        var pwd_pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        if($scope.user.password1==null||$scope.user.password2==null||$scope.password1!=$scope.password2){
            alert('A megadott jelszavak nem egyeznek meg!')
        }else if($rootScope.loggedUser.password==$scope.user.password1){
            alert('Az új jelszó nem egyezhet a régi jelszóval!')
        }else if($scope.user.password1!=$scope.user.password2){
            alert('A megadott jelszavak nem egyeznek meg!')
        }else if(!$scope.user.password1.match(pwd_pattern)){
            alert('A megadott jelszó nem felel meg a minimális biztonsági követelményeknek!');
        }
        else{
            let data={
                password:CryptoJS.SHA1($scope.user.password1).toString()
            }
            DB.update('users',$rootScope.loggedUser.ID,data).then(function(res){
                if (res.data.affectedRows != 0) {
                    alert('Jelszó sikeresen megváltoztatva!');
                    $scope.user = {};
                } else {
                    alert('Váratlan hiba történt az adatbázis művelet során!');
                }
            })
        }
    };
    $scope.imageUpload = function() {
        let file=$scope.user.picture;
        let filename = '';
        if(file!=null){
            console.log(file);
            let uploadUrl='http://localhost:3000/fileupload';
            fileUpload.uploadFile(file, uploadUrl).then(function(res) {
                filename = res.data.filename;
                console.log(filename);
                filename= filename.substring(0, filename.lastIndexOf('.'))
                console.log(filename);
                DB.update('users', $rootScope.loggedUser.ID, { kep: filename }).then(function(res) {
                    if (res.data.affectedRows != 0) {
                        alert('Kép feltöltve!');
                    } else {
                        alert('Váratlan hiba történt az adatbázis művelet során!');
                    }
                });
            })
        }
    }

    $scope.tomail=function(){
        $location.path('/uzenetek')
    }
    $scope.tokedvencek=function(){
        $location.path('/kedvencek')
    }
    $scope.pictureupload=function(){
       if ($scope.user.picture==null) {
           alert('Hiba')
       } else {
        let data = {
            kep:$scope.user.picture
        }
           DB.update('users',$rootScope.loggedUser.ID,data).then(function(res){
            if (res.data.affectedRows != 0) {
                alert('Sikeres képfeltöltés');
            } else {
                alert('Sikertelen');
            }
           })
       }
    }
   

    $scope.login = function() {
        if ($scope.user.email == null || $scope.user.pass1 == null) {
            alert('Nem adott meg minden kötelező adatot!');
        } else {
            let data = {
                table: 'users',
                email: $scope.user.email,
                password: CryptoJS.SHA1($scope.user.pass1).toString()
            }
            let data2 = {
                table: 'orvosok',
                email: $scope.user.email,
                password: CryptoJS.SHA1($scope.user.pass1).toString()
            }

            DB.logincheck(data).then(function(res) {
                if (res.data.length == 0) {
                    DB.logincheck(data2).then(function(res) {
                        
                        if (res.data.length == 0) {
                            alert('Hibás belépési adatok!');
                        } else {
                            if (res.data[0].status == 0) {
                                alert('Tiltott felhasználó!');
                            } else {
        
                                res.data[0].last = moment(new Date()).format('YYYY-MM-DD H:m:s');
                                $rootScope.loggedUser = res.data[0];
                                let data2 = {
                                    last: res.data[0].last
                                }
                                DB.update('orvosok', res.data[0].ID, data2).then(function(res) {
                                    sessionStorage.setItem('NudentistAPP', angular.toJson($rootScope.loggedUser));
                                });
                            }
                        }
                    });
                } else {
                    if (res.data[0].status == 0) {
                        alert('Tiltott felhasználó!');
                    } else {

                        res.data[0].last = moment(new Date()).format('YYYY-MM-DD H:m:s');
                        $rootScope.loggedUser = res.data[0];
                        let data = {
                            last: res.data[0].last
                        }
                        DB.update('users', res.data[0].ID, data).then(function(res) {
                            sessionStorage.setItem('NudentistAPP', angular.toJson($rootScope.loggedUser));
                        });
                    }
                }
            });
            
        }
    }

    $scope.logout = function() {
        $rootScope.loggedUser = null;
        sessionStorage.removeItem('NudentistAPP');
        $location.path('/');
    }
});