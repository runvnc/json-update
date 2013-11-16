#This is actually ToffeeScript https://github.com/jiangmiao/toffee-script

fs = require 'fs-extra'
lockfile= require 'lockfile'
dash = require 'lodash'

opts =
  wait: 2000
  stale: 30000
  retries: 2
  retryWait: 100

exports.load = (filename, cb) ->
  er = lockfile.lock! "#{filename}.lock", opts
  if er?
    return cb er
  else
    err, data = fs.readFile! filename, 'utf8'
    lockfile.unlock! "#{filename}.lock"
    if err? then return cb new Error("Error reading JSON file #{filename}: #{err?.message}")
    try
      return cb null, JSON.parse data
    catch e
      return cb new Error("Error parsing JSON in #{filename}. Data is #{data}. Error was #{e.message}")
    
exports.update = (filename, obj, cb) ->
  loaded = (data, dolock) ->
    data = dash.merge data, obj
    
    if dolock
      er1 = lockfile.lock! "#{filename}.lock"
    else
      er1 = null

    if er1?
      return cb er1
    else
      err = fs.outputJson! filename, data
      lockfile.unlock! "#{filename}.lock"
      if err? then return cb new Error("Problem saving JSON file: #{err?.message}")
      return cb null, data

  if not fs.exists!(filename)
    loaded {}, false
  else
    err, filedata = exports.load! filename
    loaded filedata, true

