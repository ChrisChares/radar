//
//  RADBeaconRegion.m
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import "RADBeaconRegion.h"

@implementation RADBeaconRegion
+ (RADBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region {
    return [[RADBeaconRegion alloc] initWithProximityUUID:region.proximityUUID major:region.major.shortValue minor:region.minor.shortValue identifier:region.identifier];
}
@end
