/**
 * @file SLObject.m
 *
 * @author Michael Schoonmaker
 * @copyright (c) 2013 StrongLoop. All rights reserved.
 */

#import "SLObject.h"

@interface SLObject()

@property (readwrite, nonatomic, weak) SLPrototype *prototype;
@property (readwrite, nonatomic, strong) NSDictionary *creationParameters;

@end

@interface SLPrototype()

@property (readwrite, nonatomic, copy) NSString *className;

@end

@implementation SLObject

NSString *SLObjectInvalidPrototypeDescription = @"Invalid prototype.";

+ (instancetype)objectWithPrototype:(SLPrototype *)prototype
                         parameters:(NSDictionary *)parameters {
    return [[self alloc] initWithPrototype:prototype parameters:parameters];
}

- (instancetype)initWithPrototype:(SLPrototype *)prototype
                       parameters:(NSDictionary *)parameters {
    self = [super init];

    if (self) {
        self.prototype = prototype;
        self.creationParameters = parameters;
    }

    return self;
}

- (void)invokeMethod:(NSString *)name
          parameters:(NSDictionary *)parameters
             success:(SLSuccessBlock)success
             failure:(SLFailureBlock)failure {
    NSAssert(self.prototype, SLObjectInvalidPrototypeDescription);

    NSString *path = [NSString stringWithFormat:@"%@.prototype.%@",
                      self.prototype.className,
                      name];

    [self.prototype.adapter invokeInstanceMethod:path
                           constructorParameters:self.creationParameters
                                      parameters:parameters
                                         success:success
                                         failure:failure];
}

@end

@implementation SLPrototype

+ (instancetype)prototypeWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];

    if (self) {
        self.className = name;
    }

    return self;
}

- (SLObject *)objectWithParameters:(NSDictionary *)parameters {
    return [SLObject objectWithPrototype:self parameters:parameters];
}

- (void)invokeStaticMethod:(NSString *)name
                parameters:(NSDictionary *)parameters
                   success:(SLSuccessBlock)success
                   failure:(SLFailureBlock)failure {
    NSString *path = [NSString stringWithFormat:@"%@.%@", self.className, name];
    [self.adapter invokeStaticMethod:path
                          parameters:parameters
                             success:success
                             failure:failure];
}

@end
