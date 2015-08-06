dbURI    = 'mongodb://localhost/todo-testing'
should   = (require 'chai').should()
mongoose = require 'mongoose'

clearDB  = require('mocha-mongoose')(dbURI)
Todo     = require('../../models/todo')


describe "Tests for the Todo model", ->

  before (done) ->

    # Make a new mongoose connection if not exists
    done() if mongoose.connection.db?
    mongoose.connect dbURI, done

  before (done)->
    clearDB(done)


  it "can be saved", (done) ->
    todo = new Todo {text: "Blah"}
    todo.save (err, doc) ->

      Todo.find {}, (err, docs) ->
        (done err) if err?

        docs.length.should.equal 1
        done()