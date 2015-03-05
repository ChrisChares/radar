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
@property NSMutableArray *monitoredBeaconRegions;

- (void)startMonitoringForBeaconRegion:(RADBeaconRegion *)region;

//not yet supported
//- (void)stopMonitoringForBeaconRegion:(RADBeaconRegion *)region;


- (RADBeaconRegion *)radRegionForCLBeaconRegion:(CLBeaconRegion *)region;

@end
