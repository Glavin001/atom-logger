"use strict"
Logger = require '../lib/atom-logger'
Config = require './fake_config'
fs = require 'fs'

#
#  ======== A Handy Little Nodeunit Reference ========
#  https://github.com/caolan/nodeunit
#
#  Test methods:
#    test.expect(numAssertions)
#    test.done()
#  Test assertions:
#    test.ok(value, [message])
#    test.equal(actual, expected, [message])
#    test.notEqual(actual, expected, [message])
#    test.deepEqual(actual, expected, [message])
#    test.notDeepEqual(actual, expected, [message])
#    test.strictEqual(actual, expected, [message])
#    test.notStrictEqual(actual, expected, [message])
#    test.throws(block, [error], [message])
#    test.doesNotThrow(block, [error], [message])
#    test.ifError(value)
#
exports.atomLogger =
  setUp: (done) ->
    # setup here
    @config = new Config()
    @logger = new Logger(@config, 'Test')
    done()

  tearDown: (done) ->
    # console.log JSON.stringify @config.settings

    # Delete the temp log file
    fs.unlink @logger.logFilePath, (err) ->
      # console.log err if err?
      done()

  "missing Config": (test) ->
    test.throws(() ->
      new Logger()
    , Error, 'Missing Config argument.')
    test.done()

  "missing Package Namespace": (test) ->
    test.throws(() ->
      new Logger(@config)
    , Error, 'Missing Namespace (Package name) argument.')
    test.done()

  "logFilePath": (test) ->
    test.expect 1
    test.ok(@logger.logFilePath, 'should be a path')
    test.done()

  "log": (test) ->

    @logger.log('info', "This is a test!", {}, () =>
      fs.readFile(@logger.logFilePath, {encoding: 'utf-8'}, (err, data) ->
        # console.log(err, data)
        j = JSON.parse(data)

        test.equal j.level, "info", "should be info"
        test.equal j.message, "This is a test!", "should be the same message"
        test.done()
        )
    )
