//
//  RDInterpreter.h
//  radar
//
//  Created by Chris Chares on 3/10/15.
//  Copyright (c) 2015 Eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDInterpretedResult

@property NSArray *enteredRegions;
@property NSArray *exitedREgions;

@end

@interface RDInterpreter : NSObject

- (RDInterpretedResult *)resultForBeacons:(NSArray *)beacons occupiedRegions:(NSArray *)occupiedRegions;

@end
