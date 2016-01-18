angular.module( "X", []);

var a = angular.module("MyApp", []);

a.controller("Multiply", function($scope, $http) {
  $scope.m1 = "this is a message";

  $scope.aClick = function() {
    $scope.m1 = "Message changed";
    alert("aClick");
  }
});

a.directive("myDir", function() {
  return {
    template: "Hello world"
  }
})
