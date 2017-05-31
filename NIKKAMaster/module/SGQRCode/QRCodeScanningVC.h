//
//  QRCodeScanningVC.h
//  SGQRCodeExample
//
//  Created by apple on 17/3/21.
//  Copyright © 2017年 JP_lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGQRCode.h"

@protocol QRCodeScanControllerDelegate <NSObject>

- (void)scanResultWithInfo:(NSString *)info;

@end

@interface QRCodeScanningVC : SGQRCodeScanningVC

@property (nonatomic,strong) id <QRCodeScanControllerDelegate> delegate;

@end
