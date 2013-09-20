package com.strongloop.android.remoting.test;

import java.util.HashMap;
import java.util.Map;

import com.strongloop.android.remoting.Prototype;
import com.strongloop.android.remoting.VirtualObject;
import com.strongloop.android.remoting.adapters.RestAdapter;
import com.strongloop.android.remoting.adapters.RestContract;
import com.strongloop.android.remoting.adapters.RestContractItem;

public class RestContractTest extends AsyncTestCase {
    
    /**
     * Convenience method to create a single-entry Map.
     */
    public static <T> Map<String, T> param(String name, T value) {
        Map<String, T> params = new HashMap<String, T>();
        params.put(name, value);
        return params;
    }
    
    private RestAdapter adapter;
    private Prototype testClass;

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        // NOTE: "10.0.2.2" is the "localhost" of the Android emulator's
        // host computer.
        adapter = new RestAdapter(getActivity(), "http://10.0.2.2:3001");
        
        adapter.getContract().addItem(
                new RestContractItem("/contract/customizedGetSecret", "GET"), 
                "contract.getSecret");
        adapter.getContract().addItem(
                new RestContractItem("/contract/customizedTransform", "GET"), 
                "contract.transform");
        adapter.getContract().addItem(
                new RestContractItem("/ContractClass/:name/getName", "POST"), 
                "ContractClass.prototype.getName");
        adapter.getContract().addItem(
                new RestContractItem("/ContractClass/:name/greet", "POST"), 
                "ContractClass.prototype.greet");
        
        testClass = new Prototype("ContractClass");
        testClass.setAdapter(adapter);        
    }
    
    public void testAddItemsFromContract() {
        RestContract parent = new RestContract();
        RestContract child = new RestContract();
        
        parent.addItem(new RestContractItem("/wrong/route", "OOPS"), 
                "test.route");
        child.addItem(new RestContractItem("/test/route", "GET"), 
                "test.route");
        child.addItem(new RestContractItem("/new/route", "POST"), 
                "new.route");

        parent.addItemsFromContract(child);

        assertEquals("Wrong URL", "/test/route", 
                parent.getUrlForMethod("test.route", null));
        assertEquals("Wrong verb", "GET",
                parent.getVerbForMethod("test.route"));
        assertEquals("Wrong URL", "/new/route",
                parent.getUrlForMethod("new.route", null));
        assertEquals("Wrong verb", "POST",
                parent.getVerbForMethod("new.route"));
    }
    
    public void testGet() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                adapter.invokeStaticMethod("contract.getSecret", null, 
                        expectJsonResponse("shhh!"));
            }
        });
    }
    
    public void testTransform() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                adapter.invokeStaticMethod("contract.transform", 
                        param("str", "somevalue"), 
                        expectJsonResponse("transformed: somevalue"));
            }
        });
    }
    
    
    public void testTestClassGet() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                adapter.invokeInstanceMethod("ContractClass.prototype.getName",
                        param("name", "somename"), null, 
                        expectJsonResponse("somename"));
            }
        });
    }
    
    public void testTestClassTransform() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                adapter.invokeInstanceMethod("ContractClass.prototype.greet", 
                        param("name", "somename"), 
                        param("other", "othername"), 
                        expectJsonResponse("Hi, othername!"));
            }
        });
    }
    
    public void testPrototypeStatic() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                testClass.invokeStaticMethod("getFavoritePerson", null, 
                        expectJsonResponse("You"));
            }
        });
    }
    
    public void testPrototypeGet() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                VirtualObject test = testClass.createObject(
                        param("name", "somename"));
                test.invokeMethod("getName", null, 
                        expectJsonResponse("somename"));
            }
        });
    }
    
    public void testPrototypeTransform() throws Throwable {
        doAsyncTest(new AsyncTest() {

            @Override
            public void run() {
                VirtualObject test = testClass.createObject(
                        param("name", "somename"));
                test.invokeMethod("greet", 
                        param("other", "othername"), 
                        expectJsonResponse("Hi, othername!"));
            }
        });
    }
}
