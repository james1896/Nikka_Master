//
//  SerialAlgorithm.m
//  NIKKAMaster
//
//  Created by toby on 27/04/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "SerialAlgorithm.h"

@interface SerialAlgorithm()

@property (nonatomic,copy) NSString *first;
@property (nonatomic,copy) NSString *second;
@property (nonatomic,copy) NSString *third;
@property (nonatomic,copy) NSString * end;

@property (nonatomic,copy) NSString *first_1;
@property (nonatomic,copy) NSString *first_2;
@property (nonatomic,copy) NSString *first_3;
@property (nonatomic,copy) NSString *second_1;
@property (nonatomic,copy) NSString *second_2;
@property (nonatomic,copy) NSString *second_3;
@property (nonatomic,copy) NSString *third_1;
@property (nonatomic,copy) NSString *third_2;
@property (nonatomic,copy) NSString *third_3;

@property (nonatomic,copy) NSString *time_1;
@property (nonatomic,copy) NSString *time_2;
@property (nonatomic,copy) NSString *time_3;
@property (nonatomic,copy) NSString *flog;

@end

@implementation SerialAlgorithm

+ (SerialAlgorithm *)share{
    return [SerialAlgorithm new];
}

- (NSString *)getUserIDWithSerial:(NSString *)serial{
    
    
    if(serial.length != 18){
        return @"0";
    }
    
    NSString *userID = @"";
    
    self.first = @"";
    self.second = @"";
    self.third = @"";
    
    NSString *fragmentTime_2 = [serial substringWithRange:NSMakeRange(serial.length-8, 2)];
    
    NSString *fragmentTime_3 = [serial substringWithRange:NSMakeRange(serial.length-3, 1)];//倒数第三位
    
    self.time_1 = fragmentTime_3; //倒数第三位
    self.time_2 = [fragmentTime_2 substringWithRange:NSMakeRange(fragmentTime_2.length-2, 1)]; //倒数第二位
    self.time_3 = [fragmentTime_2 substringWithRange:NSMakeRange(fragmentTime_2.length-1, 1)]; //倒数第一位
        if(![self isEffectiveTime:fragmentTime_2 and:fragmentTime_3]){
            return @"0";
        }
    
    
    
    switch ( [self getWeekday]) {
        case 1:{
            
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        case 2:{
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
            
        case 3:{
            
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        case 4:{
            
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        case 5:{
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        case 6:{
            
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        case 7:{
            
            self.first= [serial substringWithRange:NSMakeRange(serial.length-6-5-5, 3)];
            self.second = [serial substringWithRange:NSMakeRange(serial.length-6-5, 3)];
            self.third = [serial substringWithRange:NSMakeRange(serial.length-6, 3)];
            //            NSLog(@"first:%@ second:%@ third:%@",first,second,third);
            
            break;
        }
        default:
            break;
    }
    
    
    
    self.first_1 = [NSString stringWithFormat:@"%@",[self.first substringWithRange:NSMakeRange(0, 1)]];
    self.first_2 = [NSString stringWithFormat:@"%@",[self.first substringWithRange:NSMakeRange(1, 1)]];
    self.first_3 = [NSString stringWithFormat:@"%@",[self.first substringWithRange:NSMakeRange(2, 1)]];
    
    self.second_1 = [NSString stringWithFormat:@"%@",[self.second substringWithRange:NSMakeRange(0, 1)]];
    self.second_2 = [NSString stringWithFormat:@"%@",[self.second substringWithRange:NSMakeRange(1, 1)]];
    self.second_3 = [NSString stringWithFormat:@"%@",[self.second substringWithRange:NSMakeRange(2, 1)]];
    
    self.third_1 = [NSString stringWithFormat:@"%@",[self.third substringWithRange:NSMakeRange(0, 1)]];
    self.third_2 = [NSString stringWithFormat:@"%@",[self.third substringWithRange:NSMakeRange(1, 1)]];
    self.third_3 = [NSString stringWithFormat:@"%@",[self.third substringWithRange:NSMakeRange(2, 1)]];
    self.end = [serial substringWithRange:NSMakeRange(serial.length-13, 1)];
    self.flog = [serial substringWithRange:NSMakeRange(serial.length-2, 1)];
    
    [self sortWithTime:[self.flog integerValue]];
    
    userID = [NSString stringWithFormat:@"%@%@%@%@",self.first,self.second,self.third,self.end];
    NSLog(@"userID:%@",userID);
    return userID;
}

- (BOOL)isEffectiveTime:(NSString *)t_2  and:(NSString *)t_3{
    //100秒以内 为正常
    BOOL effective = NO;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    NSString * timeStr = [NSString stringWithFormat:@"%lld",date];
    NSString *fragmentTime_2 = [timeStr substringFromIndex:timeStr.length-2];//时间倒数2位
    NSString *fragmentTime_3 = [timeStr substringWithRange:NSMakeRange(timeStr.length-3, 1)];//时间倒数第3位
    
    NSInteger delta = [fragmentTime_3 integerValue] - [t_3 integerValue];//倒数第三位  时间差
    
    if( delta == 0){
        
        if([fragmentTime_2 integerValue] > [t_2 integerValue]){
            effective = YES;
        }else{
            NSLog(@"(1)算法可能已经泄露,非法的时间");
        }
        
    }else if (delta == 1){
        if([fragmentTime_2 integerValue] < [t_2 integerValue]){
            effective = YES;
        }else{
            NSLog(@"(2) 算法可能已经泄露,非法的时间");
        }
    }else if (delta > 1){
        NSLog(@" 时间差大于100秒 ");
    }else if (delta == -9){
        effective = YES;
    }
    else{
        NSLog(@"(3)算法可能已经泄露,非法的时间");
    }
    NSLog(@"%@%@ > %@%@",fragmentTime_3,fragmentTime_2,t_3,t_2);
    return effective;
    
}

- (NSInteger)getWeekday{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    //    NSLog(@"-----------weekday is %ld",(long)[comps weekday]);//在这里需要注意的是：星期日是数字1，星期一时数字2，以此类推。。。
    return [comps weekday];
}

- (void)sortWithTime:(NSInteger)random{
    NSInteger i = random;
  
    NSString *tmpFirst = [self.first copy];
    NSString *tmpSecond = [self.second copy];
    NSString *tmpThird = [self.third copy];
    
    if(i > 6){
        self.first = [NSString stringWithFormat:@"%@%@",[tmpFirst substringWithRange:NSMakeRange(1, 2)],[tmpFirst substringToIndex:1]];
        
        self.second = [NSString stringWithFormat:@"%@%@%@",[tmpSecond substringWithRange:NSMakeRange(0, 1)],[tmpSecond substringWithRange:NSMakeRange(2, 1)],[tmpSecond substringWithRange:NSMakeRange(1, 1)]];
        
        self.third = [NSString stringWithFormat:@"%@%@%@",[tmpThird substringWithRange:NSMakeRange(2, 1)],[tmpThird substringWithRange:NSMakeRange(0, 1)],[tmpThird substringWithRange:NSMakeRange(1, 1)]];
    }else if (i == 0){
        self.first = [NSString stringWithFormat:@"%@%@%@",self.second_3,self.third_2,self.second_1];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.first_3,self.third_1,self.second_2];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.third_3,self.first_1,self.first_2];
    }else if (i == 1){
        
        //        1和9位 互换
        //        3和7位 互换
        self.first = [NSString stringWithFormat:@"%@%@%@",self.third_3,self.first_2,self.third_1];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.second_1,self.second_2,self.second_3];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.first_3,self.third_2,self.first_1];
    }else if (i == 2){
        //        3 5
        //        6 7
        //        2 9
        self.first = [NSString stringWithFormat:@"%@%@%@",self.first_1,self.third_3,self.second_2];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.second_1,self.first_3,self.third_1];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.second_3,self.third_2,self.first_2];
        
    }else if (i == 3){
//        fdsafdafdadfdasfdsafdsafdsafdsafdsa
        self.first = [NSString stringWithFormat:@"%@%@%@",self.second_2,self.third_3,self.first_1];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.second_1,self.first_2,self.third_1];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.second_3,self.third_2,self.first_3];
        
    }else if (i == 4){
        
        self.first = [NSString stringWithFormat:@"%@%@%@",self.third_2,self.second_1,self.second_2];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.third_3,self.first_2,self.third_1];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.second_3,self.first_1,self.first_3];
        
    }else if (i == 5){
        self.first = [NSString stringWithFormat:@"%@%@%@",self.third_2,self.second_1,self.second_3];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.first_2,self.third_1,self.second_2];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.third_3,self.first_1,self.first_3];
    }else if (i == 6){
        self.first = [NSString stringWithFormat:@"%@%@%@",self.third_2,self.second_1,self.second_3];
        self.second = [NSString stringWithFormat:@"%@%@%@",self.first_2,self.third_1,self.first_1];
        self.third = [NSString stringWithFormat:@"%@%@%@",self.third_3,self.second_2,self.first_3];
    }
    NSLog(@"random:%ld",i);
//    8 ,7,
}
@end
