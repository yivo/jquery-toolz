require('gulp-lazyload')
  gulp:       'gulp'
  connect:    'gulp-connect'
  concat:     'gulp-concat'
  coffee:     'gulp-coffee'
  preprocess: 'gulp-preprocess'
  iife:       'gulp-iife-wrap'
  uglify:     'gulp-uglify'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  gulp.src('source/jquery-tools.coffee')
  .pipe plumber()
  .pipe preprocess()
  .pipe iife(dependencies: {require: 'jquery', global: '$'})
  .pipe concat('jquery-tools.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('jquery-tools.js')
  .pipe gulp.dest('build')

gulp.task 'build-min', ['build'], ->
  gulp.src('build/jquery-tools.js')
  .pipe uglify()
  .pipe rename('jquery-tools.min.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']