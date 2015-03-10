//
//  RADBeaconRegion.m
//  radar
//
//  Created by Chris Chares on 3/9/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "RDBeaconRegion.h"

@interface RDBeaconRegionTests : XCTestCase

@end

@implementation RDBeaconRegionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsEqual {
    CLBeaconRegion *clRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"shit"];
    RDBeaconRegion *region1 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    RDBeaconRegion *region2 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    expect([region1 isEqual:region2]).to.beTruthy();
}


- (void)testWithin {
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"hue"];
    
    RDBeaconRegion *immediate = [RDBeaconRegion regionFromCLBeaconRegion:region];
    immediate.proximity = CLProximityImmediate;
    
    RDBeaconRegion *near = [RDBeaconRegion regionFromCLBeaconRegion:region];
    near.proximity = CLProximityNear;

    RDBeaconRegion *far = [RDBeaconRegion regionFromCLBeaconRegion:region];
    far.proximity = CLProximityFar;
    
    RDBeaconRegion *unknown = [RDBeaconRegion regionFromCLBeaconRegion:region];
    unknown.proximity = CLProximityUnknown;
    
    expect([immediate isWithinRegion:near]).to.beTruthy();
    expect([near isWithinRegion:immediate]).to.beFalsy();
    expect([near isWithinRegion:far]).to.beTruthy();
    expect([far isWithinRegion:unknown]).to.beTruthy();
    expect([unknown isWithinRegion:far]).to.beFalsy();
}

@end
