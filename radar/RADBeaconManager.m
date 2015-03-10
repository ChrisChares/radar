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
        self.currentlyOccupiedRegions = [NSMutableArray new];
    }
    return self;
}

- (void)startMonitoringForBeaconRegion:(RADBeaconRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:region];
}

- (void)stopMonitoringForBeaconRegion:(RADBeaconRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    NSArray *composite = _.array(beacons)
    .map( (id)^(CLBeacon *beacon) {
        NSMutableDictionary *d = [NSMutableDictionary new];
        d[@"beacon"] = beacon;
        d[@"region"] = [RADBeaconRegion regionFromCLBeaconRegion:region
                                                       withMajor:beacon.major
                                                        andMinor:beacon.minor];
        return d;
    }).unwrap;
    
    _.array(composite)
    .each(^(NSMutableDictionary *d) {
       
        if ( [self regionIsCurrentlyOccupied:d[@"region"]] ) {
            //we're already inside of this region
            if ( [self beacon:d[@"beacon"] isWithinRegion:d[@"region"]]) {
                //and we're still inside of this region
                //do nothing
            } else {
                //we are currently outside of the distance threshold for this region
                //remove from currently occupied regions
                [self.currentlyOccupiedRegions removeObject:d[@"region"]];
                //send a didExit update
                [self.delegate locationManager:self.locationManager didExitRegion:d[@"region"]];
            }
        } else {
            //we are not currently inside of this region
            if ( [self beacon:d[@"beacon"] isWithinRegion:d[@"region"]]) {
                //but we are now,
                //add to currently occupied regions
                [self.currentlyOccupiedRegions addObject:d[@"region"]];
                //send a didEnter update
                [self.delegate locationManager:self.locationManager didEnterRegion:d[@"region"]];
            } else {
                //although we are seeing this beacon, we're not close enough to be considered inside
                //do nothing
            }
        }
    });
    
    //iterate through any beacons the app was inside, but weren't mentioned
    //in this didRange request
    _.array(_.without(self.currentlyOccupiedRegions, _.arrayMap(composite, ^id (NSDictionary *d) {
        return d[@"region"];
    })))
    .each(^(RADBeaconRegion *regionNotRanged) {
        //we are no longer in this region
        [self.currentlyOccupiedRegions removeObject:regionNotRanged];
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
    return _.find(self.currentlyOccupiedRegions, ^BOOL (RADBeaconRegion *radRegion) {
        return [region.identifier isEqualToString:radRegion.identifier];
    }) != nil;
}

- (BOOL)beacon:(CLBeacon *)beacon isWithinRegion:(RADBeaconRegion *)region {
    return beacon.proximityUUID == CLProximityUnknown ? false : beacon.proximity <= region.proximity;
}

@end
