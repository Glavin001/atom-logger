class Config

  settings: {}

  constructor: (@settings = {}) ->

  observe: (keyPath, options, callback) ->
    @get(keyPath, callback) if callback?
    return {
      off: ->
        return true
    }

  set: (keyPath, value) ->
    @settings[keyPath] = value

  get: (keyPath, callback) ->
    return callback?(@settings[keyPath])

exports = module.exports = Config
