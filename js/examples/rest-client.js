var Remotes = require('../client');
var contract = {
  routes: {
    'fs.readFile': {
      path: '/fs/readFile',
      verb: 'get'
    }
  }
};
var RestAdapter = require('../adapters/rest-adapter');
var remotes = Remotes.connect('http://localhost:3000', RestAdapter, contract);

remotes.invoke('fs.readFile', {path: 'test.txt'}, function (err, data) {
  console.log(data);
});