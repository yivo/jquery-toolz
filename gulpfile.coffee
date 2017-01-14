gulp       = require 'gulp'
concat     = require 'gulp-concat'
coffee     = require 'gulp-coffee'
umd        = require 'gulp-umd-wrap'
plumber    = require 'gulp-plumber'
preprocess = require 'gulp-preprocess'
fs         = require 'fs'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  dependencies = [{global: 'document', native:  true},
                  {global: 'window',   native:  true},
                  {global: 'RegExp',   native:  true},
                  {global: '$',        require: 'jquery'}]
  header = fs.readFileSync('source/__license__.coffee')
  gulp.src('source/__manifest__.coffee')
    .pipe plumber()
    .pipe preprocess()
    .pipe umd({dependencies, header})
    .pipe concat('jquery-toolz.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe concat('jquery-toolz.js')
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
