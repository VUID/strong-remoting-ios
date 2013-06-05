//
//  SLRESTAdapterTests.m
//  SLRemoting
//
//  Created by Michael Schoonmaker on 6/3/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "SLRESTAdapterTests.h"

#import "SLRESTAdapter.h"
#import "SLObject.h"

typedef void (^SuccessBlock)(id value);
typedef void (^FailureBlock)(NSError *error);

@interface SLRESTAdapterTests() {
    SLRESTAdapter *adapter;
    SLPrototype *TestClass;
    
    FailureBlock failureBlock;
}

@end

@implementation SLRESTAdapterTests

- (void)setUp {
    [super setUp];
    
    adapter = [SLRESTAdapter adapterWithURL:[NSURL URLWithString:@"http://localhost:3001"]];
    TestClass = [SLPrototype prototypeWithName:@"TestClass"];
    TestClass.adapter = adapter;
    
    failureBlock = ^(NSError *error) {
        STFail(error.description);
    };
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGet {
    ASYNC_TEST_START
    [adapter invokeStaticMethod:@"test.getSecret"
                     parameters:nil
                        success:^(id value) {
                            STAssertNotNil(value, @"No value returned.");
                            STAssertTrue([@"shhh!" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                            ASYNC_TEST_SIGNAL
                        }
                        failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testTransform {
    ASYNC_TEST_START
    [adapter invokeStaticMethod:@"test.transform"
                     parameters:@{ @"str": @"somevalue" }
                        success:^(id value) {
                            STAssertNotNil(value, @"No value returned.");
                            STAssertTrue([@"transformed: somevalue" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                            ASYNC_TEST_SIGNAL
                        }
                        failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testTestClassGet {
    ASYNC_TEST_START
    [adapter invokeInstanceMethod:@"TestClass.prototype.getName"
            constructorParameters:@{ @"name": @"somename" }
                       parameters:nil
                          success:^(id value) {
                              STAssertNotNil(value, @"No value returned.");
                              STAssertTrue([@"somename" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                              ASYNC_TEST_SIGNAL
                          }
                          failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testTestClassTransform {
    ASYNC_TEST_START
    [adapter invokeInstanceMethod:@"TestClass.prototype.greet"
            constructorParameters:@{ @"name": @"somename" }
                       parameters:@{ @"other": @"othername" }
                          success:^(id value) {
                              STAssertNotNil(value, @"No value returned.");
                              STAssertTrue([@"Hi, othername!" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                              ASYNC_TEST_SIGNAL
                          }
                          failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testPrototypeStatic {
    ASYNC_TEST_START
    [TestClass invokeStaticMethod:@"getFavoritePerson"
                       parameters:nil
                          success:^(id value) {
                              STAssertNotNil(value, @"No value returned.");
                              STAssertTrue([@"You" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                              ASYNC_TEST_SIGNAL
                          }
                          failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testPrototypeGet {
    ASYNC_TEST_START
    SLObject *test = [TestClass objectWithParameters:@{ @"name": @"somename" }];
    
    [test invokeMethod:@"getName"
            parameters:nil
               success:^(id value) {
                   STAssertNotNil(value, @"No value returned.");
                   STAssertTrue([@"somename" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                   ASYNC_TEST_SIGNAL
               }
               failure:failureBlock];
    ASYNC_TEST_END
}

- (void)testPrototypeTransform {
    ASYNC_TEST_START
    SLObject *test = [TestClass objectWithParameters:@{ @"name": @{ @"somekey": @"somevalue" }}];
    
    [test invokeMethod:@"greet"
            parameters:@{ @"other": @"othername" }
               success:^(id value) {
                   STAssertNotNil(value, @"No value returned.");
                   STAssertTrue([@"Hi, othername!" isEqualToString:value[@"data"]], @"Incorrect value returned.");
                   ASYNC_TEST_SIGNAL
               }
               failure:failureBlock];
    ASYNC_TEST_END
}

@end
