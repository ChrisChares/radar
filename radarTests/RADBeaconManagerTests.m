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
    
////    id mock = [OCMockObject mockForProtocol:@protocol(CLLocationManagerDelegate)];
//    id mock = self;
//    @mockify(mock);
//    
}

- (void)testRADBeaconForRegion {
    
//    RADBeaconRegion *uuidRegion = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"uuidRegion"];
//    
//    CLBeaconRegion *blandUUIDRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"uuidRegion"];
//    
//    RADBeaconRegion *majorRegion = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] major:15 identifier:@"majorRegion"];
//    
//    CLBeaconRegion *blandMajorRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] major:15 identifier:@"majorRegion"];
//    
//    [_beaconManager.monitoredBeaconRegions addObjectsFromArray:@[uuidRegion, majorRegion]];
//    
//    
//    expect([_beaconManager radRegionForCLBeaconRegion:blandUUIDRegion]).to.equal(uuidRegion);
//    
//    expect([_beaconManager radRegionForCLBeaconRegion:blandMajorRegion]).to.equal(majorRegion);
}

- (void)testAddRemoveRegion {
    
    RADBeaconRegion *region = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
    
    [_beaconManager startMonitoringForBeaconRegion:region];
    [_beaconManager stopMonitoringForBeaconRegion:region];
    
    expect(_beaconManager.monitoredBeaconRegions.count).to.equal(0);
}


@end
