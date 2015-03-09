//
//  RADLocationManager.m
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import "RADBeaconManager.h"
#import <Underscore.h>
#define _ Underscore

@implementation RADBeaconManager

- (id)init {
    self = [super init];
    if ( self ) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.monitoredBeaconRegions = [NSMutableArray new];
    }
    return self;
}


- (void)startMonitoringForBeaconRegion:(RADBeaconRegion *)region {
    
    [self.monitoredBeaconRegions addObject:[RADBeaconRegion regionFromCLBeaconRegion:region]];
    [self.locationManager startRangingBeaconsInRegion:region];
}

- (void)stopMonitoringForBeaconRegion:(RADBeaconRegion *)region {
    
    [self.monitoredBeaconRegions removeObject:[RADBeaconRegion regionFromCLBeaconRegion:region]];
    [self.locationManager stopRangingBeaconsInRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    RADBeaconRegion *radRegion = [self radRegionForCLBeaconRegion:region];
    
    _.array(beacons)
    .filter(^BOOL (CLBeacon *beacon) {
        if ( beacon.proximityUUID == CLProximityUnknown ) {
            return false;
        } else {
            return beacon.proximity <= radRegion.proximity;
        }
    })
    .each(^(CLBeacon *beacon) {
        RADBeaconRegion *beaconSpecificRegion = [RADBeaconRegion regionFromCLBeaconRegion:region
                                                                                withMajor:beacon.major
                                                                                 andMinor:beacon.minor];
        [self.delegate locationManager:self.locationManager
                        didEnterRegion:beaconSpecificRegion];
    });
    
    if ( [self.delegate respondsToSelector:@selector
          (locationManager:didRangeBeacons:inRegion:)]) {
//        :TODO order correctly
        [self.delegate locationManager:self.locationManager didRangeBeacons:beacons inRegion:radRegion];
    }
}

- (RADBeaconRegion *)radRegionForCLBeaconRegion:(CLBeaconRegion *)region {
    
    return _.find(self.monitoredBeaconRegions, ^BOOL (RADBeaconRegion *radRegion) {
        return [region.identifier isEqualToString:radRegion.identifier];
    });
}



@end
