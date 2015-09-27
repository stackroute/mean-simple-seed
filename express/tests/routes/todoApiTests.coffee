request = require 'supertest'
should  = (require 'chai').should()

app = require '../../app'

describe 'GET /todo' , ->



  it 'respone with json', (done) ->
    (request app)
      .get '/todo'
      .set 'Accept', 'application/json'
      .expect 200
      .end (err, res) ->
        console.log res.body
        done()
