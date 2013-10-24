fs = require 'fs-extra'
dash = require 'lodash'

exports.load = (filename, cb) ->
  fs.readFile filename, 'utf8', (err, data) ->
    if err? then return cb new Error("Error reading JSON file #{filename}: #{err?.message}")

    try
      return cb null, JSON.parse data
    catch e
      return cb new Error("Error parsing JSON in #{filename}. Data is #{data}. Error was #{e.message}")
    
exports.update = (filename, obj, cb) ->
  loaded = (data) ->
    if err? then return cb new Error("Could not load JSON for update: #{err?.message}")

    data = dash.merge data, obj

    fs.outputJson filename, data, (err) ->
      if err? then return cb new Error("Problem saving JSON file: #{err?.message}")
      return cb null, data

  fs.exists filename, (exists) ->
    if not exists
      loaded {}
    else
      exports.load filename, (err, filedata) ->
        loaded filedata
