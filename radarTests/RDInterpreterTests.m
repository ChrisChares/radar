//
//  RDInterpreterTests.m
//  radar
//
//  Created by Chris Chares on 3/10/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "RDInterpreter.h"
#import "RDBeaconRegion.h"
#import <OCMock.h>

@interface RDInterpreterTests : XCTestCase
@property RDInterpreter *interpreter;
@property RDBeaconRegion *region;
@end

@implementation RDInterpreterTests

- (void)setUp {
    [super setUp];
    
    _interpreter = [RDInterpreter new];
    CLBeaconRegion *clRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"shit"];
    _region = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    _region.proximity = CLProximityNear;

}

- (void)testContains {
    CLBeaconRegion *clRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"shit"];
    RDBeaconRegion *region1 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    NSArray *array = @[region1];
    RDBeaconRegion *region2 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    expect([array containsObject:region2]).to.beTruthy();
}


- (void)testResultNotNil {
    RDInterpretedResult *result = [_interpreter resultForBeacons:nil inRegion:_region occupiedRegions:nil];
    expect(result).toNot.beNil();
}

- (void)testBeaconOutOfRange {
    //this beacon will be outside the distance threshold of the region
    id beacon = [self mockBeaconWithProximity:CLProximityFar];
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[beacon] inRegion:_region occupiedRegions:@[]];
    expect(result.enteredRegions.count).to.equal(0);
}

- (void)testSimpleEnterRegion {
    id beacon = [self mockBeaconWithProximity:CLProximityImmediate];
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[beacon] inRegion:_region occupiedRegions:@[]];
    expect(result.enteredRegions.count).to.equal(1);
    expect(result.exitedREgions.count).to.equal(0);

}

- (void)testMultipleEnterRegion {
    id beacon1 = [self mockBeaconWithProximity:CLProximityImmediate];
    id beacon2 = [self mockBeaconWithProximity:CLProximityNear];
    
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[beacon1, beacon2] inRegion:_region occupiedRegions:@[]];
    expect(result.enteredRegions.count).to.equal(2);
    expect(result.exitedREgions.count).to.equal(0);
}

- (void)testExitRegion {
    id beacon1 = [self mockBeaconWithProximity:CLProximityImmediate];

    RDBeaconRegion *existingRegion = [RDBeaconRegion regionFromCLBeaconRegion:_region withMajor:[beacon1 major] andMinor:[beacon1 minor]];
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[] inRegion:_region occupiedRegions:@[existingRegion]];
    
    expect(result.enteredRegions.count).to.equal(0);
    expect(result.exitedREgions.count).to.equal(1);
}


- (void)testStillInsideSameRegion {
    id beacon1 = [self mockBeaconWithProximity:CLProximityImmediate];
    
    RDBeaconRegion *existingRegion = [RDBeaconRegion regionFromCLBeaconRegion:_region withMajor:[beacon1 major] andMinor:[beacon1 minor]];
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[beacon1] inRegion:_region occupiedRegions:@[existingRegion]];
    
    expect(result.enteredRegions.count).to.equal(0);
    expect(result.exitedREgions.count).to.equal(0);
}

- (void)testEnterAndExitRegion {
    id beacon1 = [self mockBeaconWithProximity:CLProximityImmediate];
    id beacon2 = [self mockBeaconWithProximity:CLProximityNear];

    RDBeaconRegion *existingRegion = [RDBeaconRegion regionFromCLBeaconRegion:_region withMajor:[beacon1 major] andMinor:[beacon1 minor]];
    RDInterpretedResult *result = [_interpreter resultForBeacons:@[beacon2] inRegion:_region occupiedRegions:@[existingRegion]];
    
    expect(result.enteredRegions.count).to.equal(1);
    expect(result.exitedREgions.count).to.equal(1);
}



- (id)mockBeaconWithProximity:(CLProximity)proximity {
    
    int major = arc4random_uniform(255);
    int minor = arc4random_uniform(255);
    
    id beacon = [OCMockObject mockForClass:[CLBeacon class]];
    OCMStub([beacon major]).andReturn(@(major));
    OCMStub([beacon minor]).andReturn(@(minor));
    OCMStub([beacon proximityUUID]).andReturn(_region.proximityUUID);
    OCMStub([beacon proximity]).andReturn(proximity);
    
    return beacon;
}

@end
