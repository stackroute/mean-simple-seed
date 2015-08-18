config         = require 'config'
morgan         = require 'morgan'
fs             = require 'fs'


module.exports = (app) ->

	logFormat = config.get 'logging.format'


	logger = if process.env.NODE_ENV == 'production'
		logDir = config.get 'logging.logDir'
		accessLogStream = fs.createWriteStream logDir + '/access.log', {flags: 'a'}
		morgan logFormat, stream: accessLogStream 
	else
		morgan logFormat

	app.use logger


