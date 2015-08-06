gulp           = require 'gulp'
coffee         = require 'gulp-coffee'
gls            = require 'gulp-live-server'
bower          = require 'gulp-bower'
mainBowerFiles = require 'main-bower-files'
mocha          = require 'gulp-mocha'


# bower install
gulp.task 'bower', ->
  bower()

# Copy bower main files to libs folder
gulp.task 'libs', ['bower'], ->
  (gulp.src mainBowerFiles())
    .pipe gulp.dest('./build/js/libs')

  (gulp.src './bower_components/bootstrap/dist/**')
    .pipe gulp.dest('./build/bootstrap/dist')

# Start the express server in development mode
gulp.task 'server', ->
  server = gls.new 'server.js'
  server.start()

  # restart the sever on change of coffee-script files
  gulp.watch ["server/**/*.coffee"], ->
    server.start()


# ************************** CLIENT SIDE TASKS *********************************
# Compile client side coffee into js
gulp.task 'client-coffee', ->
  (gulp.src "browser/coffee/**/*.coffee")
    .pipe(coffee {bare: true})
    .pipe (gulp.dest './build/js')

# Copy html templates from the source folder to build folder
gulp.task 'client-templates', ->
  (gulp.src 'browser/coffee/**/*.html')
    .pipe (gulp.dest './build/js')

# bring all the client tasks under watch
gulp.task 'watch-client', ['client-coffee', 'client-templates'],  ->
  gulp.watch ['browser/coffee/**/*.coffee'], ['client-coffee']
  gulp.watch ['browser/coffee/**/*.html'], ['client-templates']


# test the application ---------------------------------------------------------
gulp.task 'test-models', ->
  gulp.src 'server/tests/models/**/*.coffee', {read: false}
    .pipe (mocha {reporter: 'spec'})
    .once 'error', ->
      process.exit 1
    .once 'end', ->
      process.exit()


gulp.task 'test', ['test-models']


gulp.task 'default', ['client-coffee', 'server', 'watch-client']
