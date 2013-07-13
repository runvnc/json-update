assert = require 'assert'
fs = require 'fs'
json = require '../lib/json-update.js'

describe 'json-update', ->
  describe '#load()', ->
    it 'should read a JSON file into an object', ->      
      json.load 'test.json', (err, obj) ->
        assert.equal obj.test1, 'hello'
        assert.equal obj.test2, 2

  describe 'update non-existing', ->
    it 'should create a subdirectory and JSON file with data', (done) ->
      if fs.existsSync 'sub'
        fs.unlinkSync 'sub/test2.json'
        fs.rmdirSync 'sub'
      json.update 'sub/test2.json', { test: 'val' }, (err) ->
        assert.equal err, null
        fs.exists 'sub/test2.json', (exists) ->
          assert.equal exists, true
          fs.readFile 'sub/test2.json', 'utf8', (err, str) ->
            assert.equal null, err
            dat = JSON.parse str
            assert.equal dat.test, 'val'
            done()

  describe 'update existing', ->
    it 'should update existing JSON file with data', ->
      json.update 'sub/test2.json', { test: 'new' }, (err) ->
        assert.equal err, null
        fs.readFile 'sub/test2.json', 'utf8', (err, str) ->
          assert.equal str, '{ "test": "new" }'