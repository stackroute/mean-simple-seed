express = require 'express'
router  = express.Router()

Todo    = require '../models/todo'


# get all records
router.get '/', (req, res) ->
  Todo.find (err, todos) ->
    res.send err if err?
    res.json todos


# Add a new record to the db
router.post '/', (req, res) ->
  todo = new Todo()
  todo.text = req.body.text

  todo.save (err) ->
    res.send err if err?
    res.send {message: "todo_saved"}


# Get a single todo by ID
router.get '/:todo_id', (req, res) ->
  Todo.findById req.params.todo_id, (err, todo) ->
    res.send err if err?
    res.json todo


# Update a todo
router.put '/:todo_id', (req, res) ->
  Todo.findById req.params.todo_id, (err, todo) ->
    res.send err if err?

    todo.text = req.body.text
    todo.save (err) ->
      res.send err if err?
      res.json {message: "successfully_updated"}


# Delete a todo by id
router.delete '/:todo_id', (req, res) ->
  Todo.remove {_id: req.params.todo_id}, (err, todo) ->
    res.send err if err?
    res.json {message: "successfully_deleted"}


module.exports = router
