//
//  RCRestAdapter.h
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import "RCAdapter.h"

@interface RCRestAdapter : RCAdapter

- (NSString *) buildUrlWithMethodString:(NSString *)methodString andArgs:(NSDictionary *)args;

@end
