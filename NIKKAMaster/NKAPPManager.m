//
//  NKAPPManager.m
//  NIKKAMaster
//
//  Created by toby on 26/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NKAPPManager.h"

@implementation NKAPPManager


- (NIKKAArchiver *)archiver{
    if(!_archiver){
        _archiver = [NIKKAArchiver unarchiver];
        if(!_archiver){
            _archiver = [[NIKKAArchiver alloc]init];
        }
    }
    
    return _archiver;
}

/*  ~~~~~~~~~~~~~~~~~~~~~~~     单例      ~~~~~~~~~~~~~~~~~~~~~~~~~~   */

#pragma mark lift cycle

+ (instancetype)shareManager{
    static dispatch_once_t onceToken ;
    static NKAPPManager* _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance ;
}


+ (id) allocWithZone:(struct _NSZone *)zone {
    return [NKAPPManager shareManager];
}

- (id) copyWithZone:(struct _NSZone *)zone {
    return [NKAPPManager shareManager] ;
}

@end
