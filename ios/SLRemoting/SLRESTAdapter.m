//
//  SLRESTAdapter.m
//  SLRemoting
//
//  Created by Michael Schoonmaker on 6/3/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "SLRESTAdapter.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const DEFAULT_DEV_BASE_URL = @"http://localhost:3001";
NSString *SLRESTAdapterDefaultVerb = @"POST";

@interface SLRESTAdapter() {
    AFHTTPClient *client;
}

@property (readwrite, nonatomic) BOOL connected;

- (void)requestPath:(NSString *)path
               verb:(NSString *)verb
         parameters:(NSDictionary *)parameters
            success:(SLSuccessBlock)success
            failure:(SLFailureBlock)failure;

@end

@implementation SLRESTAdapter
SINGLETON_IMPLEMENTATION(SLRESTAdapter, defaultAdapter);

- (void)connectToURL:(NSURL *)url {
    client = [AFHTTPClient clientWithBaseURL:url];

    self.connected = YES;

    client.parameterEncoding = AFJSONParameterEncoding;
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
}

- (void)invokeStaticMethod:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(SLSuccessBlock)success
                   failure:(SLFailureBlock)failure {
    path = [path stringByReplacingOccurrencesOfString:@"." withString:@"/"];
    
    // TODO(schoon) - Custom contract for verb.
    
    [self requestPath:path
                 verb:SLRESTAdapterDefaultVerb
           parameters:parameters
              success:success
              failure:failure];
}

- (void)invokeInstanceMethod:(NSString *)path
       constructorParameters:(NSDictionary *)constructorParameters
                  parameters:(NSDictionary *)parameters
                     success:(SLSuccessBlock)success
                     failure:(SLFailureBlock)failure {
    // TODO(schoon) - Custom contract for method string -> path mapping.
    
    path = [path stringByReplacingOccurrencesOfString:@"." withString:@"/"];
    
    NSMutableDictionary *combinedParameters = [NSMutableDictionary dictionary];
    [combinedParameters addEntriesFromDictionary:constructorParameters];
    [combinedParameters addEntriesFromDictionary:parameters];
    
    [self requestPath:path
                 verb:SLRESTAdapterDefaultVerb
           parameters:combinedParameters
              success:success
              failure:failure];
}

- (void)requestPath:(NSString *)path
               verb:(NSString *)verb
         parameters:(NSDictionary *)parameters
            success:(SLSuccessBlock)success
            failure:(SLFailureBlock)failure {
    NSAssert(self.connected, SLAdapterNotConnectedErrorDescription);

	NSURLRequest *request = [client requestWithMethod:verb path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [client enqueueHTTPRequestOperation:operation];
}

@end
