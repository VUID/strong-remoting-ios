/**
 * Returns a secret message.
 */
function getMsg(callback) {
  callback(null, 'Hello');
}
getMsg.shared = true;
getMsg.accepts = [];
getMsg.returns = [{ arg: 'data', type: 'string' }];
getMsg.http = {path: '/api/getMsg'};

/**
 * Takes a string and returns an updated string.
 */
function toUpperCase(str, callback) {
  callback(null, 'UPPERCASE: ' + str.toUpperCase());
}
toUpperCase.shared = true;
toUpperCase.accepts = [{ arg: 'str', type: 'string' }];
toUpperCase.returns = [{ arg: 'data', type: 'string' }];
toUpperCase.http = {path: '/api/toUpperCase'};

module.exports = {
  getMsg: getMsg,
  toUpperCase: toUpperCase
};
