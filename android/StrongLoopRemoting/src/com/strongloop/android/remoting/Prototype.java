// Copyright (c) 2013 StrongLoop. All rights reserved.

package com.strongloop.android.remoting;

import java.util.Map;

import com.strongloop.android.remoting.adapters.Adapter;

/**
 * A local representative of classes ("prototypes" in JavaScript) defined and
 * made remotable on the server.
 */
public class Prototype {
    
    private String className;
    private Adapter adapter;
    
    /**
     * Creates a new Prototype, associating it with the named remote class.
     * @param className The remote class name.
     */
    public Prototype(String className) {
        if (className == null || className.length() == 0) {
            throw new IllegalArgumentException(
            		"Class name cannot be null or empty.");
        }
        this.className = className;
    }

    /** 
     * Gets the name given to this prototype on the server. 
     * @return the class name.
     */
    public String getClassName() {
        return className;
    }
    
    /**
     * Gets the {@link Adapter} that should be used for invoking methods, both 
     * for static methods on this prototype and all methods on all instances of 
     * this prototype.
     * @return the adapter.
     */
    public Adapter getAdapter() {
        return adapter;
    }

    /**
     * Sets the {@link Adapter} that should be used for invoking methods, both 
     * for static methods on this prototype and all methods on all instances of
     * this prototype.
     * @param adapter The adapter.
     */
    public void setAdapter(Adapter adapter) {
        this.adapter = adapter;
    }

    /**
     * Creates a new {@link VirtualObject} as a virtual instance of this remote 
     * class.
     * @param creationParameters The creation parameters of the new object.
     * @return A new {@link VirtualObject} based on this prototype.
     */
    public VirtualObject createObject(
    		Map<String, ? extends Object> creationParameters) {
        return new VirtualObject(this, creationParameters);
    }

    /**
     * Invokes a remotable method exposed statically within this class on the 
     * server.
     * @see Adapter#invokeStaticMethod(String, Map, 
     * com.strongloop.android.remoting.adapters.Adapter.Callback)
     * @param method The method to invoke (without the class name), e.g. 
     * <code>"doSomething"</code>.
     * @param parameters The parameters to invoke with.
     * @param callback The callback to invoke when the execution finishes.
     */
    public void invokeStaticMethod(String method, 
            Map<String, ? extends Object> parameters,
            Adapter.Callback callback) {
        if (adapter == null) {
            throw new IllegalArgumentException("No adapter set");
        }
        String path = className + "." + method;
        adapter.invokeStaticMethod(path, parameters, callback);
    }
}
