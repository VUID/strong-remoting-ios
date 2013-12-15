var remotes = require('strong-remoting').create();

remotes.exports = {
  simple: require('./simple'),
  contract: require('./contract'),
  SimpleClass: require('./simple-class'),
  ContractClass: require('./contract-class'),
  nonroot: require('./nonroot')
};

var server = require('http')
  .createServer(remotes.handler('rest'))
  .listen(3001);

// remotes.handler('socket-io', server);
