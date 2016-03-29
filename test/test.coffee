assert = require 'assert'
fs = require 'fs'
json = require '../lib/json-update.js'

describe 'json-update', ->
  describe '#load()', ->
    it 'should read a JSON file into an object', (done) ->      
      json.load 'test.json', (err, obj) ->
        console.log err
        assert.equal obj.test1, 'hello'
        assert.equal obj.test2, 2
        done()

  describe 'update non-existing', ->
    it 'should create a subdirectory and JSON file with data', (done) ->
      if fs.existsSync 'sub'
        fs.unlinkSync 'sub/test2.json'
        fs.rmdirSync 'sub'
      json.update 'sub/test2.json', { test: 'val', nest: { a: 10 } }, (err) ->
        assert.equal err, null
        fs.exists 'sub/test2.json', (exists) ->
          assert.equal exists, true
          fs.readFile 'sub/test2.json', 'utf8', (err, str) ->
            assert.equal null, err
            dat = JSON.parse str
            assert.equal dat.test, 'val'
            done()

  describe 'update existing', ->
    it 'should update existing JSON file with data ..', (done) ->
      json.update 'sub/test2.json', { test: 'new' }, (err, data) ->
        assert.equal err, null
        assert.equal data.test, 'new'
        fs.readFile 'sub/test2.json', 'utf8', (err, str) ->
          read = JSON.parse str
          assert.equal read.test, 'new'
          done()

  describe 'update deep existing', ->
    it 'should deep extend existing JSON file with data ..', (done) ->
      json.config {deep:true}
      json.update 'sub/test2.json', { nest: {b:20} }, (err, data) ->
        assert.equal err, null
        assert.equal data.test, 'new'
        assert.equal data.nest.a, 10
        assert.equal data.nest.b, 20

        fs.readFile 'sub/test2.json', 'utf8', (err, str) ->
          read = JSON.parse str
          assert.equal read.test, 'new'
          assert.equal data.nest.b, 20
          done()

  describe 'try with promise', ->
    it 'should work with a promise', (done) ->
      json.update('sub/test2.json', { promise: true })
          .then (data) ->
            assert.equal(data.promise, true);
            done();


