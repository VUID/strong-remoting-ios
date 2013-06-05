var Remotes = require('../client');

// define rest routes
var contract = {
  routes: {
    'fs.readFile': {
      path: '/fs/readFile',
      verb: 'get'
    },
    'ee.on': {
      path: '/ee/on',
      verb: 'get'
    }
  }
};

// the rest adapter
var RestAdapter = require('../adapters/rest-adapter');

// connect using rest
var remotes = Remotes.connect('http://localhost:3000', RestAdapter, contract);

// invoke a remote method
remotes.invoke('fs.readFile', {path: 'test.txt'}, function (err, data) {
  console.log('Buffer.isBuffer(data)', Buffer.isBuffer(data));
  console.log(data.toString());
});