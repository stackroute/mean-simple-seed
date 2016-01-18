angular.module("App1", [])

.controller("Main1", function($scope) {

  $scope.name4 = "ksdjfksdjf skdjfskdf sdkjfksdfj";
  this.name5 = 'Jkdhfdjfhdj';

  $scope.click_event = function() {
    $scope.name4 = "changed";

    alert("in click event");
  }
})

.directive("myDir", function() {
  return {
    template: "Hello world"
  }
})
