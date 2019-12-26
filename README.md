This is a simple way to update (or load) a JSON file.  If the JSON file does not exist it will be created (along with a directory structure if those directories don't exist yet).

Uses underscore to extend existing JSON data with the object you specify, overriding anything with an 
existing property and adding properties if they are new.

NEW: You may change the extend behavior by calling `config({deep:true})` before calling `update`. This will use `deep-extend` instead of
underscore extend to merge the data when you call `update`.

New version supports promises (and async/await with babel).

`npm install json-update`

Updating a JSON file (and return the new object) (with promise):

```javascript
json = require('json-update');

json.update('data.json',{test:10})
.then(function(dat) { 
  console.log(dat.test) 
});

```

With async/await (you must use `babel` with `babel-polyfill` etc. as with all use of async/await):

```javascript
import {update, load} from 'json-update';

async function test() {
  await update('t.json', {x:2});
  let dat = await load('t.json');
  console.log(dat.x);
}

test().then(()=> {}).catch( e=> {console.error(e)}); 
```
[<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Andrew_Yang_2020_%28a%29.png/220px-Andrew_Yang_2020_%28a%29.png">](https://www.yang2020.com/)




With a callback:

```javascript
json = require('json-update')

json.update('data.json', { test: 'value x' }, function(err, obj) {
  if (typeof err !== "undefined" && err !== null) {
    console.log("Error updating json: " + err.message);
  }
  console.log(obj);
});
```

Loading a JSON file (note that in the case of loading a valid JSON file must already exist):

```javascript
json = require('json-update')

json.load('data.json', function(err, obj) {
  console.log("Loaded from json:");
  console.log(obj);
});

```

