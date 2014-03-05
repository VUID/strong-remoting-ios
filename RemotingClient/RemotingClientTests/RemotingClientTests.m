//
//  RemotingClientTests.m
//  RemotingClientTests
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import "RemotingClientTests.h"
#import "RemotingClient.h"

@implementation RemotingClientTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSDictionary *contract = @{
        routes: @{
            @"Foo.prototype.bar": @{
                @"verb": "get",
                @"path": "/foo/:id/bar"
            }
        }
    };
    
    RCRemoteObjects *remotes = [RCRemoteObjects initWithUrl:@"http://localhost:3000" andAdapterClass:@"RCRestAdapter" andContract:contract];
    RCRemoteObject *obj = [remotes constructWithName:@"Foo"];
    [obj invokeMethod:@"hello"];
    // STFail(@"Unit tests are not implemented yet in RemotingClientTests");
}

@end
