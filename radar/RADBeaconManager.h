//
//  RADLocationManager.h
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RADBeaconRegion.h"

@interface RADBeaconManager : NSObject <CLLocationManagerDelegate>

@property id<CLLocationManagerDelegate> delegate;

@property CLLocationManager *locationManager;

@property NSMutableDictionary *currentlyOccupiedRegions;

- (void)startMonitoringForBeaconRegion:(RADBeaconRegion *)region;
- (void)stopMonitoringForBeaconRegion:(RADBeaconRegion *)region;



@end
