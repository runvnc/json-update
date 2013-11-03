This is a simple way to update (or load) a JSON file.  If the JSON file does not exist it will be created (along with a directory structure if those directories don't exist yet).

Uses lodash to merge existing JSON data with the object you specify, merging anything with an 
existing property and adding properties if they are new.  See [lo-dash merge docs](http://lodash.com/docs#merge) for a detailed
explanation of the merging process, but basically simple properties like strings or numbers are replaced, and objects/arrays have the values
or key/values added into the array/object.

`npm install json-update`

Updating a JSON file (and return the new object):

```javascript
json = require('json-update')

json.update('data.json', { test: 'value x' }, function(err, obj) {
  if (typeof err !== "undefined" && err !== null) {
    console.log(Error updating json: " + err.message);
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
