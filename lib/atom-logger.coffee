"use strict"

# * atom-logger
# * https://github.com/Glavin001/atom-logger
# *
# * Copyright (c) 2014 Glavin Wiechert
# * Licensed under the MIT license.


winston = require("winston")
temp = require('temp')

# Logger class.
class Logger

  #
  _configObservers: {}

  # Constructor
  constructor: (@config, @namespace, @name = "Logger") ->
    # Verify arguments.
    throw new Error 'Missing Config argument.' if not @config?
    if not @namespace?
      throw new Error 'Missing Namespace (Package name) argument.'

    # Continue
    @_setup()
    @_config()

  # Cleans up Logger for deletion.
  destroy: ->
    @_unobserveConfigs()

  # Setup the logger.
  _setup: ->
    @logFilePath = @_getLogFilePath()
    # Setup
    @logger = new (winston.Logger)({
      transports: [
        new (winston.transports.File)(filename: @logFilePath)
      ]
      })
    @logger

  #
  _getLogFilePath: () ->
    if @logFilePath?
      return @logFilePath
    else
      p = @config.get("#{@namespace}.#{@name}_filePath")
      if (p?)
        return p
      else
        # Generate the log file path
        return temp.path({suffix: '.log'})

  # Set Config
  _config: () ->
    #
    keyPath = (key) =>
      return "#{@namespace}.#{@name}_#{key}"

    # Set Config
    @config.set keyPath('filePath'), @logFilePath

    # Reset the Logger File Path if it is set.
    # It is effectively READ-Only
    @_observeConfig(@config, keyPath('filePath'), {},
    (newValue, previousValue) =>
      # console.log "filePath changed:", newValue
      if newValue isnt @logFilePath
        # console.log newValue," is not ",@logFilePath
        @config.set keyPath('filePath'), @logFilePath
      )

  # Observe the Atom Package's configuration
  _observeConfig: (config, keyPath, options, callback) ->
    @_configObservers[keyPath] = config.observe(keyPath, options, callback)

  # Unobserve all observed configs.
  _unobserveConfigs: () ->
    @_unobserveConfig keyPath for keyPath in @_configObservers

  # Unobserve configuration with keyPath.
  _unobserveConfig: (keyPath) ->
    @_configObservers[keyPath].off()
    delete @_configObservers[keyPath]

  ## Winston Methods
  # Log
  log: () ->
    @logger.log.apply(@logger, arguments)
  # Info
  info: () ->
    @logger.info.apply(@logger, arguments)
  # Warn
  warn: () ->
    @logger.warn.apply(@logger, arguments)
  # Error
  error: () ->
    @logger.error.apply(@logger, arguments)

# Make public
exports = module.exports = Logger
