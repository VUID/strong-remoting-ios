/**
 * Module Dependencies.
 */
 
var superagent = require('superagent');

module.exports = RestAdapter;

function RestAdapter(contract) {
  this.contract = contract || {};
  this.contract.routes = this.contract.routes || {};
}

RestAdapter.prototype.connect = function (url) {
  this.url = url;
}

RestAdapter.prototype.createRequest = function (methodString, ctorArgs, args, fn) {
  var self = this;
  var route = this.contract.routes[methodString];
  
  // create the request
  var req = superagent[route.verb || 'post'](this.buildUrl(methodString, args));
    
  // set the body
  if(ctorArgs) {
    req.send(ctorArgs);
  }
  
  // allow the response to buffer
  // TODO remove this and implement
  // content types correctly
  req.buffer();
  
  // TODO support streams
  // TODO support multipart (JSON / Binary)
  
  // execute the request
  req.end(function (err, res) {
    if(err) {
      fn(err);
    } else {
      var result;
      var body = res.body;
      
      if(body) {
        result = res.body.data || res.body;
        
        switch(body.type) {
          case 'base64':
            result = new Buffer(result, 'base64');
          break;
          case 'date':
            result = new Date(result);
          break;
        }
      }
      
      fn(null, result);
    }
  });
}

RestAdapter.prototype.buildUrl = function (methodString, args) {
  var base = this.url
  var route = this.contract.routes[methodString];
  var path = route.path;
  var pathParts = path.split('/');
  var finalPathParts = [];
  var argString = args ? ('?args=' + encodeURI(JSON.stringify(args))) : '';
  
  for (var i = 0; i < pathParts.length; i++) {
    var part = pathParts[i];
    var isKey = part[0] === ':';
    var val = isKey && args && args[part.replace(':', '')];
    
    if(!isKey) {
      finalPathParts.push(part);
    } else if(val) {
      finalPathParts.push(val);
    }
  }

  // build url
  return base + finalPathParts.join('/') + argString;
}

// TODO - data transform should be on the super Adapter