//
//  SLAWeapon.m
//  AsteroidSampleClass
//
//  Created by Michael Schoonmaker on 6/7/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "SLAWeapon.h"

@interface SLAWeapon()

@property (readwrite, nonatomic) NSNumber *id;
@property (readwrite, nonatomic) NSNumber *locationId;

@end

@implementation SLAWeapon

- (void)save:(SLAWeaponSaveSuccessBlock)success
     failure:(SLFailureBlock)failure {
}

- (void)destroy:(SLAWeaponDestroySuccessBlock)success
        failure:(SLFailureBlock)failure {
}

@end

@implementation SLAWeaponPrototype

+ (instancetype)prototype {
    return [self prototypeWithName:@"weapons"];
}

- (void)nearbyWithLatitude:(NSNumber *)latitude
                 longitude:(NSNumber *)longitude
                   success:(SLAWeaponNearbySuccessBlock)success
                   failure:(SLFailureBlock)failure {
    [self invokeStaticMethod:@"nearby"
                  parameters:@{
     @"lat": latitude,
     @"long": longitude
     }
                     success:^(id value) {
                         NSLog(@"%s success: %@", __FUNCTION__, value);
                     }
                     failure:failure];
}

- (void)existsWithId:(NSNumber *)_id
success:(SLAWeaponExistsSuccessBlock)success
failure:(SLFailureBlock)failure {
    [self invokeStaticMethod:@"exists"
                  parameters:@{
     @"id": _id
     }
                     success:^(id value) {
                         NSLog(@"%s success: %@", __FUNCTION__, value);
                     }
                     failure:failure];
}

- (void)findWithId:(NSNumber *)_id
success:(SLAWeaponFindSuccessBlock)success
failure:(SLFailureBlock)failure {
    [self invokeStaticMethod:@"find"
                  parameters:@{
     @"id": _id
     }
                     success:^(id value) {
                         NSLog(@"%s success: %@", __FUNCTION__, value);
                     }
                     failure:failure];
}

- (void)findAll:(SLAWeaponAllSuccessBlock)success
        failure:(SLFailureBlock)failure {
    [self invokeStaticMethod:@"all"
                  parameters:@{
                      @"filter": @{}
     }
                     success:^(id value) {
                         NSLog(@"%s success: %@", __FUNCTION__, value);
                     }
                     failure:failure];
}

@end
