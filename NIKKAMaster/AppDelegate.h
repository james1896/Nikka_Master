//
//  AppDelegate.h
//  NIKKAMaster
//
//  Created by toby on 15/03/2017.
//  Copyright © 2017 toby. All rights reserved.
//



//iOS横竖屏切换是一个很纠结的问题，之前项目中用到了，花了长时间查阅资料以及研究，才找到了一个相对靠谱的解决方案，该方案可以处理IOS9系统以上的屏幕翻转，至于IOS9一下的系统，还没有测试过。
//
//为了过程的讲解，我先给出一个应用的需求：整个界面就显示一个按钮，当点击这个按钮的时候，界面能从竖屏切换到横屏，当再次点击的时候，又能从横屏切换到竖屏，之后点击循环往复。为了达到这样的需求，我们首先新建一个IOS工程。
//
//在工程创建之后，需要设置应用支持的屏幕旋转方向。默认情况下，IOS支持四个方向的旋转，即Portrait、UpsideDown、LandscapeLeft、LandscapeRight。
//
//可以在工程配置的General下面可以看到，也可以在info.plist里面进行配置
//
//
//
//info.plist
//
//
//配置好应用支持的屏幕旋转类型之后，接下来就需要在代码中配置横竖屏的情况。
//
//这里很关键的一点是一定要配置rootViewController的横竖屏情况，特别是当rootViewController是NavigationViewController的时候，所以一定要对作为rootViewController的controller进行重写。下面给出的代码是对NavigationViewController的重写。
//
//[objc] view plain copy
////
////  RotateNavigationController.h
////  RotateScreen
////
////  Created by obo on 16/1/28.
////  Copyright © 2016年 obo. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//@interface RotateNavigationController : UINavigationController
//
//@property (nonatomic)UIInterfaceOrientation interfaceOrientation;
//@property (nonatomic)UIInterfaceOrientationMask interfaceOrientationMask;
//
//@end
//
//[objc] view plain copy
////
////  RotateNavigationController.m
////  RotateScreen
////
////  Created by obo on 16/1/28.
////  Copyright © 2016年 obo. All rights reserved.
////
//
//#import "RotateNavigationController.h"
//
//@implementation RotateNavigationController
//
//
//- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
//
//    self = [super initWithRootViewController:rootViewController];
//
//    if (self) {
//        self.interfaceOrientation = UIInterfaceOrientationPortrait;
//        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
//    }
//
//    return self;
//}
//
////设置是否允许自动旋转
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
////设置支持的屏幕旋转方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.interfaceOrientationMask ;
//}
//
////设置presentation方式展示的屏幕方向
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.interfaceOrientation ;
//}
//
//
//@end
//
//重写实现NavigationViewController的shouldAutorate和supportedInterfaceOrientations这两个关键的方法，网上大部分建议都是让shouldAutorate返回NO，但实际上，返回NO的话，则会导致同一个界面的不能进行翻转，所以这里还是需要返回YES的。需要注意的是，interfaceOrientationMask和interfaceOrientation的初始值需要在controller初始化的时候进行赋值的，取值按照应用刚启动的时候屏幕翻转方向来设定。
//
//之后，将这个NavigationViewController作为应用启动的rootViewController，在AppDelegate中的调用如下：
//
//[objc] view plain copy
////
////  AppDelegate.m
////  RotateScreen
////
////  Created by obo on 16/1/28.
////  Copyright © 2016年 obo. All rights reserved.
////
//
//#import "AppDelegate.h"
//#import "RotateNavigationController.h"
//#import "ViewController.h"
//
//@interface AppDelegate ()
//
//@end
//
//@implementation AppDelegate
//
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//
//    RotateNavigationController *rotateNavigationController = [[RotateNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
//    [rotateNavigationController setNavigationBarHidden:YES];
//    self.window.rootViewController = rotateNavigationController;
//
//    return YES;
//}
//
//
//@end
//
//其中，ViewController是要显示的第一个界面，其内容的代码如下：
//[objc] view plain copy
////
////  ViewController.m
////  RotateScreen
////
////  Created by obo on 16/1/28.
////  Copyright © 2016年 obo. All rights reserved.
////
//
//#import "ViewController.h"
//#import "RotateNavigationController.h"
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self initViews];
//}
//
//- (void)initViews {
//
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 80)];
//    [button setTitle:@"切换横竖屏" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(clickToRotate) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//}
//
//- (void)clickToRotate {
//
//    RotateNavigationController *navigationController = (RotateNavigationController *)self.navigationController;
//    //切换rootViewController的旋转方向
//    if (navigationController.interfaceOrientation == UIInterfaceOrientationPortrait) {
//        navigationController.interfaceOrientation = UIInterfaceOrientationLandscapeRight;
//        navigationController.interfaceOrientationMask = UIInterfaceOrientationMaskLandscapeRight;
//        //设置屏幕的转向为横屏
//        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
//    }
//    else {
//        navigationController.interfaceOrientation = UIInterfaceOrientationPortrait;
//        navigationController.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
//        //设置屏幕的转向为竖屏
//        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//    }
//    //刷新
//    [UIViewController attemptRotationToDeviceOrientation];
//}
//
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait ;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//
//@end
//
//这个界面很简单，就一个按钮，每当点击的时候，设置一下RotateNavigationController的两个参数的值，并且切换一下屏幕的方向，同时，再刷新一下。这里的关键的方法是：
//[objc] view plain copy
//[[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
//这个方法能改变设备实际的旋转方向。
//完成以上的几块内容，实际上就可以控制屏幕的横竖屏切换了。
//
//本工程的例子已上传至github：IOS-Screenrotation-Control
//




#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

