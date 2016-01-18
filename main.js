angular.module("Application", [])

.controller("MyController", function($scope) {
  $scope.text = "Some random text";

  $scope.appendText = function() {
    $scope.text += " ~More~ ";
  };
})

.directive("myDirective", function() {
  return {
    template: "<p>My directive goes here</p>"
  }
});
