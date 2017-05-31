//
//  NIKKAArchiver.m
//  NIKKAMaster
//
//  Created by toby on 26/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NIKKAArchiver.h"

#import <objc/runtime.h>

@implementation NIKKAArchiver

#pragma mark - 公开方法
- (BOOL)archiver{
    NSString *path =  [NSHomeDirectory() stringByAppendingPathComponent:@"NIKKA.archiver"];
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if (success) {
        NSLog(@"NIKKaArchiver success");
    }
    
    return success;
}

+ (NIKKAArchiver *)unarchiver{
    NSString *path =  [NSHomeDirectory() stringByAppendingPathComponent:@"NIKKA.archiver"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


#pragma mark - SET GET

- (NSDictionary *)userCounts{
    if(!_userCounts){
        _userCounts =@{@"count":@"0",
                       @"time":@"2017.4.10"};
    }
    return _userCounts;
}

- (NSDictionary *)points{
    if(!_points){
        _points =@{@"count":@"0",
                       @"time":@"2017.4.10"};
    }
    return _points;
}
- (NSDictionary *)dayLogins{
    if(!_dayLogins){
        _dayLogins =@{@"count":@"0",
                       @"time":@"2017.4.10"};
    }
    return _dayLogins;
}

- (NSDictionary *)monthLogins{
     if(!_monthLogins){
        _monthLogins =@{@"count":@"0",
                       @"time":@"2017.4.10"};
    }
    return _monthLogins;
}

#pragma mark - lift cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
- (NSArray *) allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    
    return allNames;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.userCounts forKey:@"userCounts"];
    [aCoder encodeObject:self.points forKey:@"points"];
    [aCoder encodeObject:self.dayLogins forKey:@"dayLogins"];
    [aCoder encodeObject:self.monthLogins forKey:@"monthLogins"];
   
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil) {
        self.userCounts = [aDecoder decodeObjectForKey:@"userCounts"];
        self.points = [aDecoder decodeObjectForKey:@"points"];
        self.dayLogins = [aDecoder decodeObjectForKey:@"dayLogins"];
        self.monthLogins = [aDecoder decodeObjectForKey:@"monthLogins"];
    }
    return  self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"users: %@  points:%@  day:%@  month%@",
            self.userCounts,
            self.points,
            self.dayLogins,
            self.monthLogins];
}


@end







@implementation ArTest

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
//    [aCoder encodeObject:self.arTest forKey:ARTEST1];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil) {
        
//        self.arTest = [aDecoder decodeObjectForKey:ARTEST1];
    }
    
    return  self;
}

- (id)copyWithZone:(NSZone *)zone{
    ArTest *test = [super copyWithZone:zone];
    test.arTest = self.arTest;
    return test;
}

-(NSString *)description{
    NSString *str = [NSString stringWithFormat:@"artest:%@",self.arTest];
    return str;
}

@end

@implementation BaseArchiver

- (id)copyWithZone:(NSZone *)zone{
    BaseArchiver *archiver = [[[self class] alloc]init];
    return archiver;
}

@end
