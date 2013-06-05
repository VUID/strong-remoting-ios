var remotes = require('sl-remoting').create();

remotes.exports.test = {};

remotes.exports.test.transform = transform;
function transform(str, callback) {
  callback(null, 'transformed: ' + str);
}
transform.shared = true;
transform.accepts = [{ arg: 'str', type: 'string' }];
transform.returns = [{ arg: 'data', type: 'string' }];

remotes.exports.test.getSecret = getSecret;
function getSecret(callback) {
  callback(null, 'shhh!');
}
getSecret.shared = true;
getSecret.accepts = [];
getSecret.returns = [{ arg: 'data', type: 'string' }];

remotes.exports.TestClass = TestClass;
function TestClass(name) {
  this.name = name;
}

TestClass.sharedCtor = function (name, callback) {
  callback(null, new TestClass(name));
};
TestClass.shared = true;
TestClass.sharedCtor.accepts = [{ arg: 'name', type: 'string' }];

TestClass.prototype.getName = function(callback) {
  callback(null, this.name);
};
TestClass.prototype.getName.shared = true;
TestClass.prototype.getName.accepts = [];
TestClass.prototype.getName.returns = [{ arg: 'data', type: 'string' }];

TestClass.prototype.greet = function(other, callback) {
  callback(null, 'Hi, ' + other + '!');
};
TestClass.prototype.greet.shared = true;
TestClass.prototype.greet.accepts = [{ arg: 'other', type: 'string' }];
TestClass.prototype.greet.returns = [{ arg: 'data', type: 'string' }];

TestClass.getFavoritePerson = function(callback) {
  callback(null, 'You');
};
TestClass.getFavoritePerson.shared = true;
TestClass.getFavoritePerson.accepts = [];
TestClass.getFavoritePerson.returns = [{ arg: 'data', type: 'string' }];

var server = require('http')
  .createServer(remotes.handler('rest'))
  .listen(3001);

remotes.handler('socket-io', server);
