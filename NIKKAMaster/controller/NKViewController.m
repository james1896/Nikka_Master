//
//  NKViewController.m
//  NIKKAMaster
//
//  Created by toby on 26/05/2017.
//  Copyright © 2017 toby. All rights reserved.
//

#import "NKViewController.h"

@interface NKViewController ()

@end

@implementation NKViewController

- (NKAPPManager *)appManager{
    return [NKAPPManager shareManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
