//
//  RCRestAdapter.m
//  RemotingClient
//
//  Created by Ritchie Martori on 5/28/13.
//  Copyright (c) 2013 Ritchie Martori. All rights reserved.
//

#import "RCRestAdapter.h"

@implementation RCRestAdapter

- (NSDictionary *) createRequestWithMethodString:(NSString *)methodString andCtorArgs:(NSDictionary *)ctorArgs andArgs:(NSDictionary *)args
{
    NSDictionary *result = nil;
    
    NSLog(@"calling method %@", methodString);
    
    return result;
}


- (NSString *) buildUrlWithMethodString:(NSString *)methodString andArgs:(NSDictionary *)args
{
    NSMutableString *url = [NSMutableString stringWithString:self.url];
    NSString *base = self.url;
    NSObject *routes = [self.contract valueForKey:@"routes"];
    NSString *path = [routes valueForKey:methodString];
    NSArray *pathParts = [path componentsSeparatedByString:@"/"];
    NSMutableArray *finalPathParts = [NSMutableArray array];
    NSString *argString;
    
    if(args) {
        NSError *error;
        NSData *argData = [NSJSONSerialization dataWithJSONObject:args
                                                options:0
                                                error:&error];
        
        if (!argData) {
            NSLog(@"Got an error: %@", error);
        } else {
            argString = [[NSString alloc] initWithData:argData encoding:NSUTF8StringEncoding];
        }
    }
    
    for (int i = 0; i < [pathParts count]; i++) {
        NSString *part = [pathParts objectAtIndex:i];
        BOOL isKey = [part hasPrefix:@":"];
        id val;
        
        if(isKey && args) {
            NSString *key = [part substringFromIndex:1];
            val = [args valueForKey:key];
        }
        
        if(!isKey) {
            [finalPathParts addObject:part];
        } else if(val) {
            [finalPathParts addObject:val];
        }
    }
    
    [url appendString:[finalPathParts componentsJoinedByString:@"/"]];
    if(argString) {
        [url appendString:@"?args="];
        [url appendString:argString];
    }
    
    return url;
}

@end
