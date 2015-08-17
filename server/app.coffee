express        = require 'express'
mongoose       = require 'mongoose'
bodyParser     = require 'body-parser'
passport       = require 'passport'
expressSession = require 'express-session'
LocalStrategy  = (require 'passport-local').Strategy


# create a app
app        = express()

# configure bodyParser into my app
app.use (bodyParser.urlencoded { extended: true })
app.use bodyParser.json()

app.set 'views', (__dirname + '/views')
app.set 'view engine', 'jade'


# setup the mongo connection with mongoose
mongoose.connect 'mongodb://localhost:27017/todo2'

# Configure passport auth middleware
app.use expressSession
    secret: "Random string here"
    proxy: true
    resave: true
    saveUninitialized: true

app.use passport.initialize()
app.use passport.session()

# Configure passport-local
User = require './models/user'
passport.use (new LocalStrategy User.authenticate())
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()


# Register routes
homeCtrl = require './controllers/homeCtrl'
app.use '/', homeCtrl

todoCtrl = require './controllers/todoCtrl'
app.use '/todo', todoCtrl

authCtrl = require './controllers/authCtrl'
app.use '/', authCtrl

# App static for development
app.use '/static', (express.static (__dirname + '/../build'))

app.listen 3000, ->
  console.log "Running server"
