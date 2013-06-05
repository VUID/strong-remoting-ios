//
//  SLRAdapter.m
//  SLRemoting
//
//  Created by Michael Schoonmaker on 6/5/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "SLAdapter.h"

NSString *SLAdapterNotConnectedErrorDescription = @"Adapter not connected.";

@interface SLAdapter()

@property (readwrite, nonatomic) BOOL connected;

@end

@implementation SLAdapter

+ (instancetype)adapter {
    return [self adapterWithURL:nil];
}

+ (instancetype)adapterWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

- (instancetype)init {
    return [self initWithURL:nil];
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    
    if (self) {
        self.connected = NO;
        
        if (url) {
            [self connectToURL:url];
        }
    }
    
    return self;
}

- (void)connectToURL:(NSURL *)url {
    NSAssert(NO, @"Invalid Adapter.");
}

- (void)invokeStaticMethod:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(SLSuccessBlock)success
                   failure:(SLFailureBlock)failure {
    NSAssert(NO, @"Invalid Adapter.");
}

- (void)invokeInstanceMethod:(NSString *)path
       constructorParameters:(NSDictionary *)constructorParameters
                  parameters:(NSDictionary *)parameters
                     success:(SLSuccessBlock)success
                     failure:(SLFailureBlock)failure {
    NSAssert(NO, @"Invalid Adapter.");
}

@end