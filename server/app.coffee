express    = require 'express'
mongoose   = require 'mongoose'
bodyParser = require 'body-parser'

# create a app
app        = express()

# configure bodyParser into my app
app.use (bodyParser.urlencoded { extended: true })
app.use bodyParser.json()

app.set 'views', (__dirname + '/views')
app.set 'view engine', 'jade'


# setup the mongo connection with mongoose
mongoose.connect 'mongodb://localhost:27017/todo2'

homeCtrl = require './controllers/homeCtrl'
app.use '/', homeCtrl

todoCtrl = require './controllers/todoCtrl'
app.use '/todo', todoCtrl

# App static for development
app.use '/static', (express.static (__dirname + '/../build'))

app.listen 3000, ->
  console.log "Running server"
