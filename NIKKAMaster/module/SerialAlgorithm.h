//
//  SerialAlgorithm.h
//  NIKKAMaster
//
//  Created by toby on 27/04/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SerialAlgorithm : NSObject
+ (SerialAlgorithm *)share;

- (NSString *)getUserIDWithSerial:(NSString *)serial;
@end
