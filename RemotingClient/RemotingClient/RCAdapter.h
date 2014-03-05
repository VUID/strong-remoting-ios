//
//  RCAdapter.h
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAdapter : NSObject

@property (nonatomic) NSString* url;
@property (nonatomic) NSDictionary* contract;

- (void) connect:(NSString *)url;
- (NSDictionary *) createRequestWithMethodString:(NSString *)methodString andCtorArgs:(NSDictionary *)ctorArgs andArgs:(NSDictionary *)args;

@end
