"use strict"
module.exports = (grunt) ->

  # Show elapsed time at the end
  require("time-grunt") grunt

  # Load all grunt tasks
  require("load-grunt-tasks") grunt

  # Project configuration.
  grunt.initConfig
    pkg: require('./package.json')
    release: {}

    nodeunit:
      files: ["test/**/*_test.coffee"]

    watch:
      lib:
        files: ['lib/**/*.coffee']
        tasks: ["nodeunit"]

      test:
        files: "<%= nodeunit.files %>"
        tasks: ["nodeunit"]
    changelog:
      options: {}

  # Default task.
  grunt.registerTask "default", ["nodeunit"]
  
  return
