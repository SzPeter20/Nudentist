app.controller('kezelesCtrl', function($scope, DB, $rootScope,$routeParams){
    $scope.kezeles={};
    if($routeParams.id!=null){
        DB.select('kezelesek','ID',$routeParams.id).then(function(res){
            $scope.kezeles = res.data[0]
        }
)}









    }
)