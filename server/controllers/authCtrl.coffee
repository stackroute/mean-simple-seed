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


router.get '/login', (request, response) ->
  response.render 'auth/login', {}

router.post '/login', passport.authenticate('local'), (req, resp) ->
  resp.redirect '/'

router.get '/logout', (req, res) ->
  req.logout()
  res.redirect '/login'

module.exports = router
