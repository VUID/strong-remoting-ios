// Copyright (c) 2013 StrongLoop. All rights reserved.

package com.strongloop.android.remoting;

import java.util.Map;

import com.strongloop.android.remoting.adapters.Adapter;

/**
 * A local representative of a single virtual object. The behavior of this
 * object is defined through a prototype defined on the server, and the identity
 * of this instance is defined through its `creationParameters`.
 */
public class VirtualObject {

    private Prototype prototype;
    private Map<String, ? extends Object> creationParameters;

    /**
     * Creates a new object from the given prototype and parameters.
     * @param prototype The prototype this object should inherit from.
     * @param creationParameters The creationParameters of the new object.
     */
    public VirtualObject(Prototype prototype, 
    		Map<String, ? extends Object> creationParameters) {
        setPrototype(prototype);
        setCreationParameters(creationParameters);
    }
    
    /**
     * Gets the {@link Prototype} this object was created from.
     * @return the {@link Prototype}.
     */
    public Prototype getPrototype() {
        return prototype;
    }
    
    /**
     * Sets the {@link Prototype} this object was created from.
     * @param prototype The {@link Prototype}.
     */
    public void setPrototype(Prototype prototype) {
        this.prototype = prototype;
    }

    /**
     * Gets the creation parameters this object was created from.
     * @return the creation parameters.
     */
    public Map<String, ? extends Object> getCreationParameters() {
        return creationParameters;
    }

    /**
     * Sets the creation parameters this object was created from.
     * @param creationParameters The creation parameters.
     */
    public void setCreationParameters(
    		Map<String, ? extends Object> creationParameters) {
        this.creationParameters = creationParameters;
    }

    /**
     * Invokes a remotable method exposed within instances of this class on the 
     * server.
     * @param method The method to invoke (without the prototype), e.g. 
     * <code>"doSomething"</code>.
     * @param parameters The parameters to invoke with.
     * @param callback The callback to invoke when the execution finishes.
     */
    public void invokeMethod(String method, 
            Map<String, ? extends Object> parameters,
            Adapter.Callback callback) {
        Adapter adapter = prototype.getAdapter();
        if (adapter == null) {
            throw new IllegalArgumentException(
            		"Prototype adapter cannot be null");
        }
        String path = prototype.getClassName() + ".prototype." + method;
        adapter.invokeInstanceMethod(path, creationParameters, parameters, 
        		callback);
    }
}
