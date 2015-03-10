//
//  RADBeaconManagerTests.m
//  radar
//
//  Created by Chris Chares on 3/5/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Radar.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>

@interface RadarTests : XCTestCase
@property Radar *beaconManager;
@end

@implementation RadarTests

- (void)setUp {
    [super setUp];
    
    _beaconManager = [Radar new];
}

- (void)testAddRemoveRegion {
    
    RDBeaconRegion *region = [[RDBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
    
    [_beaconManager startMonitoringBeaconsInRegion:region];
//    expect(_beaconManager.locationManager.monitoredRegions.count).to.equal(1);
    expect(_beaconManager.currentlyOccupiedRegions[region.identifier]).toNot.beNil();
    
    [_beaconManager stopMonitoringBeaconsInRegion:region];
    
    expect(_beaconManager.locationManager.monitoredRegions.count).to.equal(0);
    expect(_beaconManager.currentlyOccupiedRegions[region.identifier]).to.beNil();

}


//- (void)testDidRangeBeaconsPassthrough {
//    
//    RDBeaconRegion *region = [[RDBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
//    NSArray *array;
//    
//    id delegate = [OCMockObject mockForProtocol:@protocol(CLLocationManagerDelegate)];
//    _beaconManager.delegate = delegate;
//    [[delegate expect] locationManager:_beaconManager.locationManager didRangeBeacons:array inRegion:region];
//    [_beaconManager locationManager:nil didRangeBeacons:array inRegion:region];
//}
//
//
//- (void)testDidEnter {
//    
//    RDBeaconRegion *region = [[RDBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
//    [_beaconManager startMonitoringBeaconsInRegion:region];
//    
//    
//    id beacon = [OCMockObject mockForClass:[CLBeacon class]];
//    OCMStub([beacon major]).andReturn(@5);
//    OCMStub([beacon minor]).andReturn(@3);
//    OCMStub([beacon proximityUUID]).andReturn(region.proximityUUID);
//    OCMStub([beacon proximity]).andReturn(CLProximityNear);
//    expect([beacon major]).to.equal(5);
//
//    NSArray *array = @[beacon];
//
//    id delegate = [OCMockObject mockForProtocol:@protocol(CLLocationManagerDelegate)];
//    _beaconManager.delegate = delegate;
//    [[delegate expect] locationManager:_beaconManager.locationManager didRangeBeacons:array inRegion:region];
//    [[delegate expect] locationManager:_beaconManager.locationManager didEnterRegion:region];
//    
//    [_beaconManager locationManager:nil didRangeBeacons:array inRegion:region];
//    
//    
//}



@end
