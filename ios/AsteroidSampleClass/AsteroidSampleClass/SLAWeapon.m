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

- (NSDictionary *)dictionary;

@end

@interface SLAWeaponPrototype()

- (SLAWeapon *)weaponWithDictionary:(NSDictionary *)dictionary;

@end

@implementation SLAWeapon

- (NSDictionary *)dictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    dictionary[@"name"] = self.name;
    dictionary[@"audibleRange"] = self.audibleRange;
    dictionary[@"effectiveRange"] = self.effectiveRange;
    dictionary[@"rounds"] = self.rounds;
    dictionary[@"extras"] = self.extras;
    dictionary[@"fireModes"] = self.fireModes;
    dictionary[@"id"] = self.id;
    dictionary[@"locationId"] = self.locationId;

    return dictionary;
}

- (void)save:(SLAWeaponSaveSuccessBlock)success
     failure:(SLFailureBlock)failure {
}

- (void)destroy:(SLAWeaponDestroySuccessBlock)success
        failure:(SLFailureBlock)failure {
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<SLAWeapon %@>", self.name];
}

@end

@implementation SLAWeaponPrototype

+ (instancetype)prototype {
    return [self prototypeWithName:@"weapons"];
}

- (SLAWeapon *)weaponWithDictionary:(NSDictionary *)dictionary {
    SLAWeapon *weapon = [SLAWeapon objectWithPrototype:self parameters:@{@"id": dictionary[@"id"]}];

    weapon.name = dictionary[@"name"];
    weapon.audibleRange = dictionary[@"audibleRange"];
    weapon.effectiveRange = dictionary[@"effectiveRange"];
    weapon.rounds = dictionary[@"rounds"];
    weapon.extras = dictionary[@"extras"];
    weapon.fireModes = dictionary[@"fireModes"];
    weapon.id = dictionary[@"id"];
    weapon.locationId = dictionary[@"locationId"];

    return weapon;
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
                         NSMutableArray *weapons = [NSMutableArray array];
                         
                         [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             [weapons addObject:[self weaponWithDictionary:obj]];
                         }];
                         
                         success(weapons);
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
                         success([@1 isEqualToNumber:value[@"data"]] ? YES : NO);
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
                         success([self weaponWithDictionary:value]);
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
                         NSMutableArray *weapons = [NSMutableArray array];
                         
                         [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             [weapons addObject:[self weaponWithDictionary:obj]];
                         }];
                         
                         success(weapons);
                     }
                     failure:failure];
}

@end
