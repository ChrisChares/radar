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
        self.currentlyOccupiedRegions = [NSMutableDictionary new];
    }
    return self;
}

- (void)startMonitoringBeaconsInRegion:(RADBeaconRegion *)region {
    self.currentlyOccupiedRegions[region.identifier] = [NSMutableArray new];
    [self.locationManager startRangingBeaconsInRegion:region];
    
}

- (void)stopMonitoringBeaconsInRegion:(RADBeaconRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:region];
    [self.currentlyOccupiedRegions removeObjectForKey:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(RADBeaconRegion *)region {
    
    NSArray *regions = _.array(beacons)
    .map( (id)^(CLBeacon *beacon) {
        RADBeaconRegion *radRegion = [RADBeaconRegion regionFromCLBeaconRegion:region
                                                       withMajor:beacon.major
                                                        andMinor:beacon.minor];
        radRegion.proximity = beacon.proximity;
        return radRegion;
    }).unwrap;
    
    _.array(regions)
    .each(^(RADBeaconRegion *rad) {
       
        if ( [self regionIsCurrentlyOccupied:rad] ) {
            //we're already inside of this region
            if ( [rad isWithinRegion:region]) {
                //and we're still inside of this region
                //do nothing
            } else {
                //we are currently outside of the distance threshold for this region
                //remove from currently occupied regions
                [self.currentlyOccupiedRegions[region.identifier] removeObject:rad];
                //send a didExit update
                [self.delegate locationManager:self.locationManager didExitRegion:rad];
            }
        } else {
            //we are not currently inside of this region
            if ( [rad isWithinRegion:region]) {
                //but we are now,
                //add to currently occupied regions
                [self.currentlyOccupiedRegions[region.identifier] addObject:rad];
                //send a didEnter update
                [self.delegate locationManager:self.locationManager didEnterRegion:rad];
            } else {
                //although we are seeing this beacon, we're not close enough to be considered inside
                //do nothing
            }
        }
    });
    
    //iterate through any beacons the app was inside, but weren't mentioned
    //in this didRange request
    _.array(_.without(self.currentlyOccupiedRegions[region.identifier], regions))
    .each(^(RADBeaconRegion *regionNotRanged) {
        //we are no longer in this region
        [self.currentlyOccupiedRegions[region.identifier] removeObject:regionNotRanged];
        [self.delegate locationManager:self.locationManager didExitRegion:regionNotRanged];
    });
    
    //delegate still receives the didRangeBeacons call
    if ( [self.delegate respondsToSelector:@selector
          (locationManager:didRangeBeacons:inRegion:)]) {
//        :TODO order correctly
        [self.delegate locationManager:self.locationManager didRangeBeacons:beacons inRegion:region];
    }
}

- (BOOL)regionIsCurrentlyOccupied:(RADBeaconRegion *)region {
    return _.find(self.currentlyOccupiedRegions[region.identifier], ^BOOL (RADBeaconRegion *radRegion) {
        return [region.identifier isEqualToString:radRegion.identifier];
    }) != nil;
}

@end
