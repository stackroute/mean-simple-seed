config   = require 'config'
dbURI    = config.get 'db.dbURI'
should   = (require 'chai').should()
mongoose = require 'mongoose'

clearDB  = (require 'mocha-mongoose')(dbURI)
User     = require '../../models/user'


describe 'User Model', ->

  before (done) ->
    clearDB done


  it "can be saved", (done) ->
    user = new User {username: "john", password: "password"}
    user.save (err, doc) ->
      should.equal err, null
      doc._id.should.not.equal null
      done()


  it "can be queried", (done) ->
    user = new User {username: "john", password: "password"}
    user.save (err, doc) ->
      (done err) if err?

      User.find {}, (err, docs) ->
        should.equal err, null
        docs.length.should.equal 1

        dbUser = docs[0]
        dbUser.username.should.equal "john"
        dbUser.password.should.equal "password"
        done()
