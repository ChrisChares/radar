//
//  RADBeaconRegion.h
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//cs

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RDBeaconRegion : CLBeaconRegion

//beacon must be this close or closer to match the region
@property (nonatomic) CLProximity proximity;

+ (RDBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region;
+ (RDBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region
                                    withMajor:(NSNumber *)major
                                     andMinor:(NSNumber *)minor;

- (BOOL)isWithinRegion:(RDBeaconRegion *)region;
@end
