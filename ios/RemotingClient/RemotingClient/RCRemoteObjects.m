//
//  RemotingClient.m
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import "RCRemoteObjects.h"

@implementation RCRemoteObjects

+ (RCRemoteObjects*) initWithUrl:(NSString *)url andAdapter: (RCAdapter*) adapter
{
    RCRemoteObjects *objs = [RCRemoteObjects new];
    objs.adapter = adapter;
    objs.url = url;
    
    // connect the adapter
    [adapter connect:url];
    
    return objs;
}

+ (RCRemoteObjects *)initWithUrl:(NSString *)url andAdapterClass: (NSString *)adapterClass
{
    id adapter = [[NSClassFromString(adapterClass) alloc] init];
    return [RCRemoteObjects initWithUrl:url andAdapter:adapter];
}

+ (RCRemoteObjects *)initWithUrl:(NSString *)url andAdapterClass: (NSString *)adapterClass andContract:(NSDictionary *)contract
{
    id adapter = [[NSClassFromString(adapterClass) alloc] init];
    [adapter setProperty:contract forKey:@"contract"];
    return [RCRemoteObjects initWithUrl:url andAdapter:adapter];
}

- (NSDictionary *)invokeWithMethodString:(NSString*)methodString {
    return [self.adapter createRequestWithMethodString:methodString andCtorArgs:nil andArgs:nil];
}

-(NSDictionary *)invokeWithMethodString:(NSString*)methodString andCtorArgs:(NSDictionary *)ctorArgs
{
    return [self.adapter createRequestWithMethodString:methodString andCtorArgs:ctorArgs andArgs:nil];
}

- (NSDictionary *) invokeWithMethodString:(NSString*)methodString andCtorArgs:(NSDictionary *)ctorArgs andArgs:(NSDictionary *)args
{
    return [self.adapter createRequestWithMethodString:methodString andCtorArgs:ctorArgs andArgs:args];
}

- (NSDictionary *) invokeWithMethodString:(NSString*)methodString andArgs:(NSDictionary *)args
{
    return [self.adapter createRequestWithMethodString:methodString andCtorArgs:nil andArgs:args];
}

- (RCRemoteObject *) constructWithName:(NSString *)name
{
    RCRemoteObject *ro = [RCRemoteObject initWithName:name andCtorArgs:nil];
    ro.remotes = self;
    return ro;
}

- (RCRemoteObject *) constructWithName:(NSString *)name andCtorArgs:args
{
    RCRemoteObject *ro = [RCRemoteObject initWithName:name andCtorArgs:args];
    ro.remotes = self;
    return ro;
}

@end
