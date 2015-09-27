app = angular.module "TodoApp"


app.factory "Todo", ($resource) ->
  $resource '/todo/:id', {id: '@id'},
    update:
      method: 'PUT'
