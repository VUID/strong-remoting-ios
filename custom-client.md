# Custom Remoting Clients

There are two ways to extend remoting clients. This guide covers both from a language agnostic perspective.

## Client

The remoting client implements a protocol and transport agnostic mechanism for constructing remote classes and invoke remote methods.

The API the client provides should be language specific. The following is the general suggested structure.

**RemotingClient.connect(url, Adapter, [contract])**

Connect to a remoting server exposed at the given URL. Returns a connected client instance.

**client.construct(name, args)**

Build a RemoteObject for referencing remote objects.

**client.invoke(methodString, [ctorArgs], [args], callback)**

Invoke a method by method string name.

**methodString**

Reference to a remote method. May reference static methods on constructors, instance methods, etc.

Examples:

    MyClass.staticMethod
    MyClass.prototype.instanceMethod
    obj.myMethod
    
**RemoteObject(name, ctorArgs)**

A reference to a remote object to be constructed on the server once invoke is called.

**remoteObject.invoke(methodName, args, callback)**

 - args - a RemotingDataObject

Invoke a method on the constructed instance by name with the given args.

**RemotingDataObject(dictionary)**

A serializable data object that supports JSON and Binary.

**remotingDataObject.transport()**

Return a list of capable transports based on data. Eg. if an object includes binary data the first transport may be REST.

## Adapter

Each client implementation for each language (Java, JS, Objective-C, etc) must define an interface for adapters. The following is the basic language agnostic interface for adapters.

**adapter.connect(url)**

Connect to the remoting server.

**adapter.createRequest(methodString, ctorArgs, args, callback)**

Create an invocation request in the supported transport. The adapter should callback with a RemotingDataObject representing the result.