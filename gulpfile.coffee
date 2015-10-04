gulp           = require 'gulp'
coffee         = require 'gulp-coffee'
gls            = require 'gulp-live-server'
bower          = require 'gulp-bower'
mainBowerFiles = require 'main-bower-files'
mocha          = require 'gulp-mocha'
env            = require 'gulp-env'



# ************************ SERVER SIDE TASKS **********************************
# Start the express server in development mode
gulp.task 'server', ->
  # set environment variables
  env
    vars:
      NODE_ENV: 'development'


  server = gls.new 'server.js'
  server.start()

  # restart the sever on change of coffee-script files
  gulp.watch ["espress/**/*.coffee"], ['test-server'], ->
    console.log "running express server"
    server.start()



# ************************** CLIENT SIDE TASKS *********************************
# bower install
gulp.task 'bower', ->
  bower()

# Copy bower main files to libs folder
gulp.task 'libs', ['bower'], ->
  (gulp.src mainBowerFiles())
    .pipe gulp.dest('./build/js/libs')

  (gulp.src './bower_components/bootstrap/dist/**')
    .pipe gulp.dest('./build/bootstrap/dist')


# Compile client side coffee into js
gulp.task 'client-coffee', ->
  (gulp.src "angular/coffee/**/*.coffee")
    .pipe(coffee {bare: true})
    .pipe (gulp.dest './build/js')

# Copy html templates from the source folder to build folder
gulp.task 'client-templates', ->
  (gulp.src 'angular/coffee/**/*.html')
    .pipe (gulp.dest './build/js')

# bring all the client tasks under watch
gulp.task 'watch-client', ['client-coffee', 'client-templates'],  ->
  gulp.watch ['angular/coffee/**/*.coffee'], ['client-coffee']
  gulp.watch ['anuglar/coffee/**/*.html'], ['client-templates']


# **************************** TESTING TASKS *********************************
gulp.task 'test-server', ->

  # Set the system environment to testing
  env
    vars:
      NODE_ENV: 'testing'

  gulp.src 'express/tests/**/*.coffee', {read: false}
    .pipe (mocha {reporter: 'spec'})
    .once 'error', ->
      process.exit 1
    .once 'end', ->
      process.exit()

# for a one off test
gulp.task 'test', ['test-server']



gulp.task 'default', ['client-coffee', 'server', 'watch-client']
