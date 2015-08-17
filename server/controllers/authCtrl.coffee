express  = require 'express'
router   = express.Router()
passport = require 'passport'
User     = require '../models/user'


router.get '/register', (request, response) ->
  response.render 'auth/register', {}

router.post '/register', (request, response) ->

  User.register {username: request.body.username}, request.body.password, (err, user) ->
    return response.render 'auth/register', {user: user} if err
    passport.authenticate('local') request, response, () ->
      response.redirect '/'

module.exports = router
