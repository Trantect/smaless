app = angular.module('saslessDemo',[])



app.controller('menuCtl',['$scope',($scope)->


  $scope.showSubMenu = ()->

    if $scope.showSubMenuFlag
      $scope.showSubMenuFlag = false
    else
      $scope.showSubMenuFlag = true

])