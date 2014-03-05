//
//  RCRemoteObject.m
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import "RCRemoteObject.h"

@implementation RCRemoteObject

+(RCRemoteObject *) initWithName:(NSString *)name
{
    RCRemoteObject *obj = [RCRemoteObject new];
    obj.name = name;
    return obj;
}

+(RCRemoteObject *) initWithName:(NSString *) name andCtorArgs:(NSDictionary *)args
{
    RCRemoteObject *obj = [RCRemoteObject initWithName:name];
    obj.ctorArgs = args;
    return obj;
}

-(NSDictionary *) invokeMethod:(NSString *) methodName
{
    return [self invokeMethod:methodName withArgs:nil];
}

-(NSDictionary *) invokeMethod:(NSString *) methodName withArgs:(NSDictionary *)args
{
    NSString *methodString = [NSString stringWithFormat:@"%@.prototype.%@", self.name, methodName];
    return [self.remotes invokeWithMethodString:methodString andCtorArgs:self.ctorArgs andArgs:args];
}

@end
