//
//  RCRemoteObject.h
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCRemoteObjects.h"
@class RCRemoteObjects;

@interface RCRemoteObject : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSDictionary *ctorArgs;
@property (nonatomic) RCRemoteObjects *remotes;

+(RCRemoteObject *) initWithName:(NSString *) name;
+(RCRemoteObject *) initWithName:(NSString *) name andCtorArgs:(NSDictionary *)args;

-(NSDictionary *) invokeMethod:(NSString *) methodName;
-(NSDictionary *) invokeMethod:(NSString *) methodName withArgs:(NSDictionary *)args;


@end
