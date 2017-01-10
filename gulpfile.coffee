gulp       = require 'gulp'
concat     = require 'gulp-concat'
coffee     = require 'gulp-coffee'
iife       = require 'gulp-iife-wrap'
plumber    = require 'gulp-plumber'
preprocess = require 'gulp-preprocess'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  dependencies = [{global: 'document', native:  true},
                  {global: 'window',   native:  true},
                  {global: 'RegExp',   native:  true},
                  {global: '$',        require: 'jquery'}]
  gulp.src('source/__manifest__.coffee')
    .pipe plumber()
    .pipe preprocess()
    .pipe iife({dependencies})
    .pipe concat('jquery-toolz.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe concat('jquery-toolz.js')
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
