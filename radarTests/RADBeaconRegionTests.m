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

#import "RADBeaconRegion.h"

@interface RADBeaconRegionTests : XCTestCase

@end

@implementation RADBeaconRegionTests

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
    
    RADBeaconRegion *region1 = [RADBeaconRegion regionFromCLBeaconRegion:clRegion];
    RADBeaconRegion *region2 = [RADBeaconRegion regionFromCLBeaconRegion:clRegion];
    expect([region1 isEqual:region2]).to.beTruthy();
    
}

@end
