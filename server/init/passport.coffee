passport       = require 'passport'
User           = require '../models/user'
LocalStrategy  = (require 'passport-local').Strategy


module.exports = (app) ->
  # Configure passport for authentication
  app.use passport.initialize()
  app.use passport.session()

  User = require '../models/user'
  passport.use (new LocalStrategy User.authenticate())
  passport.serializeUser User.serializeUser()
  passport.deserializeUser User.deserializeUser()

  # Make the user object avaliable to templates
  app.use (req, res, next) ->
    res.locals.user = req.user
    next()

  passport
