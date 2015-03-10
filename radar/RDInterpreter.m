//
//  RDInterpreter.m
//  radar
//
//  Created by Chris Chares on 3/10/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import "RDInterpreter.h"
#import "RDBeaconRegion.h"
#import <CoreLocation/CoreLocation.h>
#import <Underscore.h>
#define _ Underscore

@implementation RDInterpreter

- (RDInterpretedResult *)resultForBeacons:(NSArray *)beacons inRegion:(RDBeaconRegion *)region occupiedRegions:(NSArray *)occupiedRegions {
    
    NSMutableArray *enteredRegions = [NSMutableArray new];
    NSMutableArray *exitedRegions = [NSMutableArray new];
    
    NSArray *regions = _.array(beacons)
    .map( (id)^(CLBeacon *beacon) {
        RDBeaconRegion *radRegion = [RDBeaconRegion regionFromCLBeaconRegion:region withMajor:beacon.major andMinor:beacon.minor];
        radRegion.proximity = beacon.proximity;
        return radRegion;
    }).unwrap;

    _.array(regions)
    .each(^(RDBeaconRegion *rad) {
    
        if ( [occupiedRegions containsObject:rad] ) {
            //we're already inside of this region
            if ( [rad isWithinRegion:region]) {
                //and we're still inside of this region
                //do nothing
            } else {
                //we are currently outside of the distance threshold for this region
                //remove from currently occupied regions
                [exitedRegions addObject:rad];
                
            }
        } else {
            //we are not currently inside of this region
            if ( [rad isWithinRegion:region]) {
                //but we are now,
                //add to currently occupied regions
                [enteredRegions addObject:rad];
                
            } else {
                //although we are seeing this beacon, we're not close enough to be considered inside
                //do nothing
            }
        }
    });
    
//    iterate through any beacons the app was inside, but weren't mentioned
//    in this didRange request
    _.array(_.without(occupiedRegions, regions))
    .each(^(RDBeaconRegion *regionNotRanged) {
        //we are no longer in this region
        [exitedRegions addObject:regionNotRanged];
    });
    
    
    RDInterpretedResult *result = [RDInterpretedResult new];
    result.enteredRegions = enteredRegions;
    result.exitedREgions = exitedRegions;
    return result;
}

@end
@implementation RDInterpretedResult
@end


