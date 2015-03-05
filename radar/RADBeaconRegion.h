//
//  RADBeaconRegion.h
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//cs

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RADBeaconRegion : CLBeaconRegion

@property CLProximity proximity;


+ (RADBeaconRegion *)regionFromCLBeaconRegion:(CLBeaconRegion *)region;
@end
