//
//  RADBeaconManagerTests.m
//  radar
//
//  Created by Chris Chares on 3/5/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RADBeaconManager.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Expecta+OCMock.h>
#import <Specta/Specta.h>

@interface RADBeaconManagerTests : XCTestCase
@property RADBeaconManager *beaconManager;
@end

@implementation RADBeaconManagerTests

- (void)setUp {
    [super setUp];
    
    _beaconManager = [RADBeaconManager new];
}



- (void)testMock {

}


- (void)testAddRemoveRegion {
    
    RADBeaconRegion *region = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
    
    [_beaconManager startMonitoringBeaconsInRegion:region];
//    expect(_beaconManager.locationManager.monitoredRegions.count).to.equal(1);
    expect(_beaconManager.currentlyOccupiedRegions[region.identifier]).toNot.beNil();
    
    [_beaconManager stopMonitoringBeaconsInRegion:region];
    
    expect(_beaconManager.locationManager.monitoredRegions.count).to.equal(0);
    expect(_beaconManager.currentlyOccupiedRegions[region.identifier]).to.beNil();

}


@end
