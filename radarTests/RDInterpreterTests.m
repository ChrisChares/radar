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

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testContains {
    
    CLBeaconRegion *clRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[NSUUID UUID] identifier:@"shit"];
    RDBeaconRegion *region1 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    NSArray *array = @[region1];
    RDBeaconRegion *region2 = [RDBeaconRegion regionFromCLBeaconRegion:clRegion];
    
    expect([array containsObject:region2]).to.beTruthy();
}


- (void)testInterpreter {
    
    RDInterpretedResult *result = [_interpreter resultForBeacons:nil inRegion:_region occupiedRegions:nil];
    
    expect(result).toNot.beNil();
}

@end
