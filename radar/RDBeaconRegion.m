//
//  RADBeaconRegion.m
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import "RDBeaconRegion.h"

@implementation RDBeaconRegion

+ (RDBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region {
    return [[RDBeaconRegion alloc] initWithProximityUUID:region.proximityUUID
                                                    major:region.major.shortValue
                                                    minor:region.minor.shortValue
                                               identifier:region.identifier];
}

+ (RDBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region
                                    withMajor:(NSNumber *)major
                                     andMinor:(NSNumber *)minor {
    
    return [[RDBeaconRegion alloc] initWithProximityUUID:region.proximityUUID
                                                    major:major.shortValue
                                                    minor:minor.shortValue
                                               identifier:region.identifier];
}

- (BOOL)isWithinRegion:(RDBeaconRegion *)region {
    if ( region.proximity == CLProximityUnknown ) {
        //accept everything
        return YES;
    }
    if ( self.proximity == CLProximityUnknown ) {
        //beacon is unknown distance away
        return NO;
    }
    return self.proximity <= region.proximity;
}

@end
