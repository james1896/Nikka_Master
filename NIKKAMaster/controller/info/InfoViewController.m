//
//  InforViewController.m
//  NIKKAMaster
//
//  Created by toby on 26/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoTableViewCell.h"
#import "TBRequestOnAdmin.h"

#import "NIKKAArchiver.h"

#import "NIKKAMaster-Swift.h"
@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabView;

@property (nonatomic,strong) NSArray<NSString *> *cellArray;
@property (nonatomic,strong) NSMutableArray<NSDictionary *> *dataArray;
@property (nonatomic,strong) NIKKAArchiver *archiver;

@end

@implementation InfoViewController

- (NIKKAArchiver *)archiver{
    if(!_archiver){
        _archiver = self.appManager.archiver;
    }
    return _archiver;
}

- (NSArray *)cellArray{
    return @[@"用户总数",@"剩余积分总数",@"当天用户登录数量",@"当前月用户登录数量"];
}

- (NSArray *)dataArray{
    if(!_dataArray){
        
        _dataArray =  [[NSMutableArray alloc] initWithArray:@[self.archiver.userCounts,
                                                              self.archiver.points,
                                                              self.archiver.dayLogins,
                                                              self.archiver.monthLogins]];
    }
    return _dataArray;
    
}

- (UITableView *)tabView{
    if(!_tabView){
        _tabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tabView.delegate =self;
        _tabView.dataSource = self;
    }
    return _tabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabView];
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InfoTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell"  owner:self options:nil] lastObject];

    cell.title.text = self.cellArray[indexPath.row];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.content.text = [NSString stringWithFormat:@"%@",dict[@"count"]];
    cell.time.text = [NSString stringWithFormat:@"更新数据日期: %@",dict[@"time"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    1. 获取当前系统的准确事件(+8小时)
    
//    NSDate *date = [NSDate date]; // 获得时间对象
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    switch (indexPath.row) {
        case 0:{
            //用户总数
            
            [TBRequestOnAdmin userCountAtSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            
                NSDate *date = [NSDate date];
                NSString *dateStr = [forMatter stringFromDate:date];
                
                NSDictionary *dict = @{@"count":responseObject[@"count"],
                                       @"time":dateStr};
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dict];
            
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                self.archiver.userCounts = dict;
                
                NSLog(@"arch change:%@",self.archiver.userCounts);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
           break;
        }
            
        case 1:{
            //剩余积分总数
            
            [TBRequestOnAdmin allPointsWithUUID:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
                
                NSDate *date = [NSDate date];
                NSString *dateStr = [forMatter stringFromDate:date];
                NSDictionary *dict = @{@"count":responseObject[@"count"],
                                       @"time":dateStr};
                
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dict];
                 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                self.archiver.points = dict;
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            break;
        }
        case 2:
        case 3:{
            //查询当天用户登录信息
             //查询当前月份用户登录信息
            
            [TBRequestOnAdmin getUsersAtDate:0 success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *day = responseObject[@"day"];
                NSString *month = responseObject[@"month"];
                
                
                NSDate *date = [NSDate date];
                NSString *dateStr = [forMatter stringFromDate:date];
                NSDictionary *dayDict = @{@"count":day,@"time":dateStr};
                NSDictionary *monthDict = @{@"count":month,@"time":dateStr};
                
                [self.dataArray replaceObjectAtIndex:2 withObject:dayDict];
                [self.dataArray replaceObjectAtIndex:3 withObject:monthDict];
                
                [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0],
                                                    [NSIndexPath indexPathForRow:3 inSection:0]]
                                 withRowAnimation:UITableViewRowAnimationNone];
                
                
                self.archiver.dayLogins = dayDict;
                self.archiver.monthLogins = monthDict;
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            break;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

- (void)dealloc{
    
    NSLog(@"infoViewController - dealloc");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



