var Remotes = require('../client');

// the socket io adapter
var SocketIOAdapter = require('../adapters/socket-io-adapter');

// connect to the server using socket io
var remotes = Remotes.connect('http://localhost:3000', SocketIOAdapter);

// invoke a remote method that returns a buffer
remotes.invoke('fs.readFile', {path: 'test.txt'}, function (err, data) {
  console.log(data.toString());
});

// invoke a method that calls back multiple times
remotes.invoke('ee.on', {event: 'foo'}, function (err, data) {
  console.log('foo event ran!', data); // logged multiple times
});