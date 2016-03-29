#This is actually ToffeeScript https://github.com/jiangmiao/toffee-script

fs = require 'fs-extra'
lockfile= require 'lockfile'
und = require 'underscore'
deepExtend = require 'deep-extend'
pify = require 'pify'

opts =
  wait: 2000
  stale: 30000
  retries: 2
  retryWait: 100

cfg =
  deep: false

exports.config = (conf) ->
  cfg = und.extend cfg, conf  

fixempty = (cb) ->
  if not cb?
    return ( -> )
  else
    return cb

doload = (filename, unlock, cb) ->
  cb = fixempty cb
  er = lockfile.lock! "#{filename}.lock", opts
  if er?
    return cb er
  else
    err, data = fs.readFile! filename, 'utf8'
    if unlock then lockfile.unlock! "#{filename}.lock"
    if err? then return cb new Error("Error reading JSON file #{filename}: #{err?.message}")
    try
      return cb null, JSON.parse data
    catch e
      return cb new Error("Error parsing JSON in #{filename}. Data is #{data}. Error was #{e.message}")

load = (filename, cb) ->
  doload filename, true, cb
    
update = (filename, obj, cb) ->
  cb = fixempty cb
  loaded = (data) ->
    if not cfg.deep
      data = und.extend data, obj
    else
      deepExtend data, obj
      
    err = fs.outputJson! filename, data
    lockfile.unlock! "#{filename}.lock"
    if err? then return cb new Error("Problem saving JSON file: #{err?.message}")
    return cb null, data

  if not fs.exists!(filename)
    loaded {}, false
  else
    err, filedata = doload! filename, false
    loaded filedata, false

exports.load = pify load
exports.update = pify update

