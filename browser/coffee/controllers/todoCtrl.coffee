app = angular.module "TodoApp"


app.controller "todoCtrl", ($scope, Todo) ->

  # Load all todos from the server
  Todo.query (todos) ->
    $scope.todos = todos

  # Save a todo on the server and update in current scope
  $scope.save = (todo) ->
    todoObj = new Todo text: todo.text
    todoObj.$save().then (data, newTodo) ->
      Todo.query (todos) ->
        $scope.todos = todos
    , (error) ->
      console.log error

  # delete todos
  $scope.delete = (todo) ->
    Todo.delete {id: todo._id}, ->
      console.log "deleted todo with di #{todo._id}"
      $scope.todos = $scope.todos.filter (td) -> td isnt todo
