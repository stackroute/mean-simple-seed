express        = require 'express'
mongoose       = require 'mongoose'
bodyParser     = require 'body-parser'
expressSession = require 'express-session'
config         = require 'config'



# create a app
app        = express()

# configure bodyParser middleware for resquest processing
app.use (bodyParser.urlencoded { extended: true })
app.use bodyParser.json()

app.set 'views', (__dirname + '/views')
app.set 'view engine', 'jade'


# Setup logging for this project
# app.use (morgan (config.get "logging.format"))
logging = (require './init/logging')(app)

# mongoose db connecction.
mongoose.connect (config.get "db.dbURI", config.get "db.dbOpts")


# Setup the session middleware express
app.use expressSession
    secret: "Random string here"
    proxy: true
    resave: true
    saveUninitialized: true

passport = (require './init/passport')(app)

# Register routes
homeCtrl = require './controllers/homeCtrl'
app.use '/', homeCtrl

todoCtrl = require './controllers/todoCtrl'
app.use '/todo', todoCtrl

authCtrl = require './controllers/authCtrl'
app.use '/', authCtrl

# App static for development
app.use '/static', (express.static (__dirname + '/../build')) if process.env.NODE_ENV == 'development'

app.listen 3000, ->
  console.log "Running server"


module.exports = app