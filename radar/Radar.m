//
//  RADLocationManager.m
//  radar
//
//  Created by Chris Chares on 3/4/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import "Radar.h"
#import <Underscore.h>
#define _ Underscore
#import "RDInterpreter.h"

@implementation Radar

- (id)init {
    self = [super init];
    if ( self ) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.currentlyOccupiedRegions = [NSMutableDictionary new];
    }
    return self;
}

- (void)startMonitoringBeaconsInRegion:(RDBeaconRegion *)region {
    self.currentlyOccupiedRegions[region.identifier] = [NSMutableArray new];
    [self.locationManager startRangingBeaconsInRegion:region];
}

- (void)stopMonitoringBeaconsInRegion:(RDBeaconRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:region];
    [self.currentlyOccupiedRegions removeObjectForKey:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(RDBeaconRegion *)region {
    
    RDInterpreter *interpreter = [RDInterpreter new];
    RDInterpretedResult *result = [interpreter resultForBeacons:beacons inRegion:region occupiedRegions:self.currentlyOccupiedRegions[region.identifier]];
    
    _.arrayEach(result.enteredRegions, ^(RDBeaconRegion *enteredRegion) {
        
        [self.currentlyOccupiedRegions[region.identifier] addObject:enteredRegion];
        //send a didEnter update
        [self.delegate locationManager:self.locationManager didEnterRegion:enteredRegion];
    });
    
    _.arrayEach(result.exitedREgions, ^(RDBeaconRegion *exitedRegion) {
        
        [self.currentlyOccupiedRegions[region.identifier] removeObject:exitedRegion];
        //send a didExit update
        [self.delegate locationManager:self.locationManager didExitRegion:exitedRegion];
    });
    
    //delegate still receives the didRangeBeacons call
    if ( [self.delegate respondsToSelector:@selector
          (locationManager:didRangeBeacons:inRegion:)]) {
//        :TODO order correctly
        [self.delegate locationManager:self.locationManager didRangeBeacons:beacons inRegion:region];
    }
}

@end
