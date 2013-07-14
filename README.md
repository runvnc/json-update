This is a simple way to update (or load) a JSON file.  If the JSON file does not exist it will be created (along with a directory structure if those directories don't exist yet).

Uses underscore to extend existing JSON data with the object you specify, overwriting anything with an 
existing property and adding properties if they are new.

`npm install json-update`

Updating a JSON file:

```coffeescript
json = require 'json-update'

json.update 'data.json', { test: 'value x' }, (err) ->
  if err? then console.log "Error updating json: #{err.message}"

```

Loading a JSON file (note that in the case of loading a valid JSON file must already exist):

```coffeescript
json = require 'json-update'

json.load 'data.json', (err, obj) ->
  console.log "Loaded from json:"
  console.log obj
```




```

