//
//  RADLocationManager.h
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RDBeaconRegion.h"

@interface Radar : NSObject <CLLocationManagerDelegate>

@property id<CLLocationManagerDelegate> delegate;
@property CLLocationManager *locationManager;
@property NSMutableDictionary *currentlyOccupiedRegions;

- (void)startMonitoringBeaconsInRegion:(RDBeaconRegion *)region;
- (void)stopMonitoringBeaconsInRegion:(RDBeaconRegion *)region;

@end
