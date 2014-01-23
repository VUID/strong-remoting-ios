/**
 * @file SLRESTAdapter.m
 *
 * @author Michael Schoonmaker
 * @copyright (c) 2013 StrongLoop. All rights reserved.
 */

#import "SLRESTAdapter.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const DEFAULT_DEV_BASE_URL = @"http://localhost:3001";

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

- (instancetype)initWithURL:(NSURL *)url {
    self = [super initWithURL:url];

    if (self) {
        self.contract = [SLRESTContract contract];
    }

    return self;
}

- (void)connectToURL:(NSURL *)url {
    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@"/"];
    }

    client = [AFHTTPClient clientWithBaseURL:url];

    self.connected = YES;

    client.parameterEncoding = AFJSONParameterEncoding;
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
}

- (void)invokeStaticMethod:(NSString *)method
                parameters:(NSDictionary *)parameters
                   success:(SLSuccessBlock)success
                   failure:(SLFailureBlock)failure {
    NSAssert(self.contract, @"Invalid contract.");

    NSString *verb = [self.contract verbForMethod:method];
    NSString *path = [self.contract urlForMethod:method parameters:parameters];

    [self requestPath:path
                 verb:verb
           parameters:parameters
              success:success
              failure:failure];
}

- (void)invokeInstanceMethod:(NSString *)method
       constructorParameters:(NSDictionary *)constructorParameters
                  parameters:(NSDictionary *)parameters
                     success:(SLSuccessBlock)success
                     failure:(SLFailureBlock)failure {
    // TODO(schoon) - Break out and document error description.
    NSAssert(self.contract, @"Invalid contract.");

    NSMutableDictionary *combinedParameters = [NSMutableDictionary dictionary];
    [combinedParameters addEntriesFromDictionary:constructorParameters];
    [combinedParameters addEntriesFromDictionary:parameters];

    NSString *verb = [self.contract verbForMethod:method];
    NSString *path = [self.contract urlForMethod:method parameters:combinedParameters];

    [self requestPath:path
                 verb:verb
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

    if ([[verb uppercaseString] isEqualToString:@"GET"]) {
        client.parameterEncoding = AFFormURLParameterEncoding;
    } else {
        client.parameterEncoding = AFJSONParameterEncoding;
    }

    // Remove the leading / so that the path is treated as relative to the baseURL
    if(path && [path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    
	NSURLRequest *request = [client requestWithMethod:verb path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [client enqueueHTTPRequestOperation:operation];
}

- (NSString*)accessToken
{
    return [client defaultValueForHeader:@"Authorization"];
}

- (void)setAccessToken:(NSString *)accessToken
{
    [client setDefaultHeader:@"Authorization" value:accessToken];
}

@end
