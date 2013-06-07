//
//  SLAWeapon.h
//  AsteroidSampleClass
//
//  Created by Michael Schoonmaker on 6/7/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SLRemoting.h"

@interface SLAWeapon : SLObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *audibleRange;
@property (nonatomic) NSNumber *effectiveRange;
@property (nonatomic) NSNumber *rounds;
@property (nonatomic) NSString *extras;
@property (nonatomic) NSString *fireModes;
@property (readonly, nonatomic) NSNumber *id;
@property (readonly, nonatomic) NSNumber *locationId;

typedef void (^SLAWeaponSaveSuccessBlock)();
- (void)save:(SLAWeaponSaveSuccessBlock)success
     failure:(SLFailureBlock)failure;

typedef void (^SLAWeaponDestroySuccessBlock)();
- (void)destroy:(SLAWeaponDestroySuccessBlock)success
        failure:(SLFailureBlock)failure;

@end

@interface SLAWeaponPrototype : SLPrototype

+ (instancetype)prototype;

typedef void (^SLAWeaponNearbySuccessBlock)(NSArray *weapons);
- (void)nearbyWithLatitude:(NSNumber *)latitude
                 longitude:(NSNumber *)longitude
                   success:(SLAWeaponNearbySuccessBlock)success
                   failure:(SLFailureBlock)failure;

typedef void (^SLAWeaponExistsSuccessBlock)(BOOL exists);
- (void)existsWithId:(NSNumber *)_id
             success:(SLAWeaponExistsSuccessBlock)success
             failure:(SLFailureBlock)failure;

typedef void (^SLAWeaponFindSuccessBlock)(SLAWeapon *weapon);
- (void)findWithId:(NSNumber *)_id
           success:(SLAWeaponFindSuccessBlock)success
           failure:(SLFailureBlock)failure;

typedef void (^SLAWeaponAllSuccessBlock)(NSArray *weapons);
- (void)findAll:(SLAWeaponAllSuccessBlock)success
        failure:(SLFailureBlock)failure;

@end

