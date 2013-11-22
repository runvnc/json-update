This is a simple way to update (or load) a JSON file.  If the JSON file does not exist it will be created (along with a directory structure if those directories don't exist yet).

Uses underscore to extend existing JSON data with the object you specify, overriding anything with an 
existing property and adding properties if they are new.

`npm install json-update`

Updating a JSON file (and return the new object):

```javascript
json = require('json-update')

json.update('data.json', { test: 'value x' }, function(err, obj) {
  if (typeof err !== "undefined" && err !== null) {
    console.log("Error updating json: " + err.message);
  }
  console.log(obj);
)};
```

Loading a JSON file (note that in the case of loading a valid JSON file must already exist):

```javascript
json = require('json-update')

json.load('data.json', function(err, obj) {
  console.log("Loaded from json:");
  console.log(obj);
});

```

