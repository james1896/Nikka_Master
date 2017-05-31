//
//  NKAPPManager.h
//  NIKKAMaster
//
//  Created by toby on 26/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NIKKAArchiver.h"

@interface NKAPPManager : NSObject

@property (nonatomic,strong) NIKKAArchiver *archiver;

+ (instancetype)shareManager;

@end
