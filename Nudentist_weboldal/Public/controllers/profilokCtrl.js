
app.controller('profilokCtrl', function($scope, DB, $rootScope,){

    $scope.uzenetek;
    $scope.comms;
    $scope.stringrating;
    $scope.pointrating;
    $scope.message;
    $scope.csillagok;

    DB.selectAll("uzenetek").then(function(res){
        $scope.uzenetek=res.data;
    })

    $scope.rate= function(){
        if($scope.stringrating.length>500){
            alert("Kérjük értékelése tartalmazzon maximum 500 karaktert")
        }else{
                DB.update("uzenetek")

            if(false){
                DB.insert("ertekelesek",$scope.comms).then(function(res){
                
                })
            }
            }
    }
    $scope.message= function(){
        if($scope.message.length>500){
            alert("Kérjük üzenete tartalmazzon maximum 500 karaktert")
        }else{
            DB.insert("uzenetek",$scope.comms).then(function(res){

            })
        }
    }
    $scope.pointrate= function(){
        
    }
});
