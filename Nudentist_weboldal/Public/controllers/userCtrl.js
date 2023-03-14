app.controller('userCtrl', function($scope, DB, $rootScope, $location) {
    $scope.uzenetek=[];
    $scope.doktorok=[];
    $scope.userek=[];
    $scope.sender=[];
    $scope.vanOlvasattlanUzenet=false;

    for (let i = 0; i < $scope.uzenetek.length; i++){
        if($scope.uzenetek[i].olvasottsag=='olvasatlan'){
            $scope.vanOlvasattlanUzenet=true;
        }
    }



    if($rootScope.loggedUser!=null){
        DB.selectAll('uzenetek').then(function(res){
            $scope.uzenetek=res.data;
        })
    }
    $scope.message=function(){
        console.log($scope.uzenetek[0])
    }
    $scope.toMessageContent=function(id){
        for (let i = 0; i < $scope.uzenetek.length; i++){
            if($scope.uzenetek[i].ID===id){
                $scope.uzenetek[i].olvasottsag='olvasott'
            }
        }
        $location.path('/uzenet/' + id)
    }
    
    DB.selectAll('orvosok').then(function(res){
        $scope.doktorok=res.data;
    })
    DB.selectAll('users').then(function(res){
        $scope.userek=res.data;
    })

    for (let i = 0; i < $scope.uzenetek.length; i++) {
        for (let j = 0; j < $scope.doktorok.length; j++) {
            if($scope.uzenetek[i].senderType==='doktor'){
                if($scope.doktorok[i].ID===$scope.uzenetek[j].senderID){
                    $scope.sender.push($scope.doktorok[i].nev)
                }
            }else{
                if($scope.userek[i].ID===$scope.uzenetek[j].senderID){
                    $scope.sender.push($scope.userek[i].nev)
                }
            }
            
        }
    }
    /*
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
            alert('Nem adtál meg(helyesen) minden kötelező adatot!');
        } else {
            if ($scope.user.pass1 != $scope.user.pass2) {
                alert('A megadott jelszavak nem egyeznek!');
            } else {
                var pwd_pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
                if (!$scope.user.pass1.match(pwd_pattern)) {
                    alert('A megadott jelszó nem felel meg a minimális biztonsági követelményeknek!');
                } else {
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
    };
    $scope.mod = function() {
        console.log($rootScope.loggedUser)
        if ($scope.user.name == null || $scope.user.email == null) {
            alert('Nem adtál meg minden kötelező adatot!');
        }else if($rootScope.loggedUser.jogok==='doktor')
        {
            let data = {
                nev: $scope.user.name,
                email: $scope.user.email,
                telefonszam: $scope.user.phone,
                szakterulet:$scope.user.field,
                tanulmanyok:$scope.user.studies,
                bemutatkozas:$scope.user.desc
            }
            DB.update('orvosok',$rootScope.loggedUser.ID, data).then(function(res) {
                if (res.data.affectedRows != 0) {
                    alert('Adatok sikeresen megváltoztatva!');
                    $scope.user = {};
                } else {
                    alert('Váratlan hiba történt az adatbázis művelet során!');
                }
        })
        }
         else {
                    let data = {
                        nev: $scope.user.name,
                        email: $scope.user.email,
                        telefonszam: $scope.user.phone
                    }

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
    }
    $scope.tomail=function(){
        $location.path('/uzenetek')
    }

   

    $scope.login = function() {
        if ($scope.user.email == null || $scope.user.pass1 == null) {
            alert('Nem adtál meg minden kötelező adatot!');
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
                console.log(res.data);
                if (res.data.length == 0) {
                    DB.logincheck(data2).then(function(res) {
                        console.log(res.data);
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