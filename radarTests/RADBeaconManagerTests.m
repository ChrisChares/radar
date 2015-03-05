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

@interface RADBeaconManagerTests : XCTestCase
@property RADBeaconManager *beaconManager;
@end

@implementation RADBeaconManagerTests

- (void)setUp {
    [super setUp];
    
    _beaconManager = [RADBeaconManager new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRADBeaconForRegion {
    
    RADBeaconRegion *uuidRegion = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"uuidRegion"];
    
    CLBeaconRegion *blandUUIDRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"uuidRegion"];
    
    RADBeaconRegion *majorRegion = [[RADBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] major:15 identifier:@"majorRegion"];
    
    CLBeaconRegion *blandMajorRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] major:15 identifier:@"majorRegion"];
    
    [_beaconManager.monitoredBeaconRegions addObjectsFromArray:@[uuidRegion, majorRegion]];
    
    
    expect([_beaconManager radRegionForCLBeaconRegion:blandUUIDRegion]).to.equal(uuidRegion);
    
    expect([_beaconManager radRegionForCLBeaconRegion:blandMajorRegion]).to.equal(majorRegion);
    
    
    
}

@end
