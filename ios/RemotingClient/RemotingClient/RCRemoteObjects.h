//
//  RemotingClient.h
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAdapter.h"
#import "RCRemoteObject.h"
@class RCRemoteObject;

@interface RCRemoteObjects : NSObject

@property (nonatomic) RCAdapter* adapter;
@property (nonatomic) NSString* url;
@property Class adapterClass;

+ (RCRemoteObjects*) initWithUrl:(NSString *)url andAdapter: (RCAdapter*) adapter;
+ (RCRemoteObjects*) initWithUrl:(NSString *)url andAdapterClass: (NSString *)adapterClass;
+ (RCRemoteObjects*) initWithUrl:(NSString *)url andAdapterClass: (NSString *)adapterClass andContract:(NSDictionary *)contract;

- (NSDictionary *) invokeWithMethodString:(NSString *)methodString;
- (NSDictionary *) invokeWithMethodString:(NSString *)methodString andCtorArgs:(NSDictionary *)ctorArgs;
- (NSDictionary *) invokeWithMethodString:(NSString *)methodString andCtorArgs:(NSDictionary *)ctorArgs andArgs:(NSDictionary *)args;
- (NSDictionary *) invokeWithMethodString:(NSString *)methodString andArgs:(NSDictionary *)args;

- (RCRemoteObject *) constructWithName:(NSString *)name;
- (RCRemoteObject *) constructWithName:(NSString *)name andCtorArgs:(NSDictionary *)args;

@end
