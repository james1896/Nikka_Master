//
//  PayViewController.m
//  NIKKAMaster
//
//  Created by toby on 26/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "PayViewController.h"
#import "QRCodeScanningVC.h"
#import "SerialAlgorithm.h"
#import "TBToastView.h"
#import "OrderViewController.h"


#import "NIKKAMaster-Swift.h"
#import "NIKKAArchiver.h"
@interface PayViewController ()<QRCodeScanControllerDelegate>

@end

@implementation PayViewController
- (IBAction)Swiftbutton:(id)sender {
    Test *test = [[Test alloc]init];
    [test sayHello];
    
    Info *info = [[Info alloc] init];
    NSLog(@"%@",[info sayHolaWithTest:@"aa"]);
    
}

- (void)scanResultWithInfo:(NSString *)info{
    
    NSString *userID = [[SerialAlgorithm share] getUserIDWithSerial:info];
    if(info){
        [TBToastView showToastViewWithText:userID];
    }
    
    OrderViewController *order = [[OrderViewController alloc]initWithNibName:@"OrderViewController" bundle:nil];
    order.hidesBottomBarWhenPushed = YES;
    order.userID = userID;
    [self.navigationController pushViewController:order animated:YES];
    
}


//数据归档
//图标

- (IBAction)scan:(id)sender {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
                        //                        vc.delegate = self;
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            QRCodeScanningVC *vc = [[QRCodeScanningVC alloc] init];
            vc.delegate = self;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
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
