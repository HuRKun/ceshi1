//
//  RKRootViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKRootViewController.h"
#import "RKChoseViewController.h"
#import "RKDiscoverViewController.h"
#import "RKWeddingViewController.h"
#import "RKParpareViewController.h"
#import "RKLoginViewController.h"
#import "RKLaunchViewController.h"
#import "LaunchViewController.h"
#import "RKNavigationController.h"
#import "RKMyController.h"
#import "RKAppDelegate.h"
#import "RKGlobalDefine.h"
#import "RKTransparentNavigationController.h"
#import "RKNomalNavigationController.h"

#import <MapKit/MapKit.h>
#import "UIViewController+RKViewController.h"

@interface RKRootViewController () <UITabBarControllerDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) RKLaunchViewController *launchViewController; //!< 加载页
@property (nonatomic, strong) UIViewController *mainViewController; //!< 主页面

@property (nonatomic, assign) NSInteger currentPage;//!< 当前在tabar的哪个界面

@property (nonatomic, strong) CLLocationManager *locationManager;//!< 定位管理器

@property (nonatomic, copy) NSString *city;//!< 当前定位到的城市

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation RKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 先显示加载页
    [self rk_addChildViewController:self.launchViewController];
    
    // 3秒后，再显示主页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 加上转场动画
        // 表示动画设置的开始
        [UIView beginAnimations:@"RootTransitionAnimation" context:nil];
        [UIView setAnimationDuration:1.0f]; // 时间
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO]; // 转场的样式

        // 加载主页面
        [self rk_addChildViewController:self.mainViewController];
        // 移除加载页
        [self rk_removeChildViewController:self.launchViewController];
    
        // 表示动画设置的结束
        [UIView commitAnimations];
    
        // 把加载页清空
        self.launchViewController = nil;
    });

    //    设备启动时开始定位
    
        [self location];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center  addObserver:self selector:@selector(recevieMessage) name:@"loginsuccess" object:nil];
    
}
#pragma mark - other
//收到信息  跳转到我的界面
- (void)recevieMessage
{
    self.tabBarController.selectedIndex = 4;
    
}

#pragma mark - Setter & Getter

- (UIViewController *)launchViewController
{
    if (_launchViewController == nil) {
        _launchViewController = [[RKLaunchViewController alloc] init];
    }
    
    return _launchViewController;
}

- (UIViewController *)mainViewController
{
    if (_mainViewController == nil) {
        
        NSMutableArray *navs = [[NSMutableArray alloc] init];
        RKChoseViewController *choseVC = [[RKChoseViewController alloc] initWithNibName:@"RKChoseViewController" bundle:nil];
        RKMyController *myVC = [[RKMyController alloc] initWithNibName:@"RKMyController" bundle:nil];
        NSArray *vc = @[choseVC,myVC];
        NSArray *normalImages = @[@"btn_tab_best_n",@"btn_tab_mine_n"];
        NSArray *seleImages = @[@"btn_tab_best_s",@"btn_tab_mine_s"];
        NSArray *ti= @[ @"精选", @"我的"];

        for ( int i=0; i<vc.count; i++) {
            
            RKTransparentNavigationController *nav = [[RKTransparentNavigationController alloc] initWithRootViewController:vc[i]];
            //添加标题
            nav.tabBarItem.title = ti[i];
            // 标题文字的样式设置
            UIColor *textColor = [UIColor colorWithRed:209/255.f green:51/255.f blue:109/255.f alpha:1];
            nav.tabBarItem.image = [[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:seleImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor} forState:UIControlStateSelected]; // 调整文字颜色
            [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal]; // 调整字体大小
            
            [navs addObject:nav];
        }
        RKDiscoverViewController *discoverVC = [[RKDiscoverViewController alloc] initWithNibName:@"RKDiscoverViewController" bundle:nil];
        
    
        RKWeddingViewController *weddingVC = [[RKWeddingViewController alloc] initWithNibName:@"RKWeddingViewController" bundle:nil];
        
        RKParpareViewController *parpareVC = [[RKParpareViewController alloc] initWithNibName:@"RKParpareViewController" bundle:nil];
        
        NSArray *vcs = @[discoverVC, weddingVC, parpareVC];
        NSArray *titles = @[ @"发现", @"结婚圈", @"筹备"];
        NSArray *iconNormal = @[@"btn_tab_found_n", @"btn_tab_bbs_n", @"btn_tab_prepare_n"];
        NSArray *iconSeleted = @[@"btn_tab_found_s", @"btn_tab_bbs_s", @"btn_tab_prepare_s"];
        
        
        for (int i=0; i<vcs.count; i++) {
            UIViewController *vc = vcs[i];
            // 加上导航控制器
            RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:vc];
             NSString *title = titles[i];
            // 加上Title
            nav.tabBarItem.title = title;
            // 标题文字的样式设置
            UIColor *textColor = [UIColor colorWithRed:209/255.f green:51/255.f blue:109/255.f alpha:1];
        
            [navs addObject:nav];
            
            NSString *normalName= iconNormal[i];
            NSString *selectedIconName = iconSeleted[i];
            nav.tabBarItem.image = [[UIImage imageNamed:normalName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedIconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor} forState:UIControlStateSelected]; // 调整文字颜色
            [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal]; // 调整字体大小
            }
        //改变控制器的位置
        [navs exchangeObjectAtIndex:4 withObjectAtIndex:1];

        self.tabBarController = [[UITabBarController alloc] init];
        
        self.tabBarController.delegate = self;
        
        self.tabBarController.viewControllers = navs;
        
        // 主页面是TabBar
        _mainViewController = self.tabBarController;
    }
    
    return _mainViewController;
}



// 当tabBarItem被点击的时候会调用该方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    RKLoginManager *manage = [RKLoginManager shareManager];
    
    //判断该用户是否登入
    if (manage.islogin == NO) {
        
        //判断跳转的控制器是哪个
        if ([[[(UINavigationController *)viewController viewControllers] firstObject] isKindOfClass:[RKMyController class]]) {
             UIViewController *vc = tabBarController.viewControllers[self.currentPage];
            RKLoginViewController *login = [[RKLoginViewController alloc] initWithNibName:@"RKLoginViewController" bundle:nil];
            RKNomalNavigationController *nav = [[RKNomalNavigationController alloc] initWithRootViewController:login];
         
            [vc presentViewController:nav animated:YES completion:nil];
            
            return NO;
        }
        self.currentPage = tabBarController.selectedIndex;
       
        return YES;
    }
    self.currentPage = tabBarController.selectedIndex;
  
    return YES;
}

- (void)location
{
    //创建定位管理器
    self.locationManager = [[CLLocationManager alloc] init];
    //设置代理，定位的结果是通过代理告诉我们的
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = 1000.f;
    
    //设置精确度   精确度越高越耗电
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
        
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    //开始定位
    [self.locationManager startUpdatingLocation];
    
}
#pragma mark - CLLocationManagerDelegate
// 定位成功之后的回调方法
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    [RKLocationCity shareManager].lon = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    [RKLocationCity shareManager].lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    RKLoginManager *manage = [RKLoginManager shareManager];
    [revGeo reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];

            //获取城市
            self.city = placemark.locality;
            if (!self.city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.city = placemark.administrativeArea;
                
            }
            manage.islocation = YES;
            
        }
        else if (error == nil && [array count] == 0)
        {
            manage.islocation = NO;
            
        }
        else if (error != nil)
        {
            manage.islocation = NO;
        }
    }];
    // 停止定位
    [self.locationManager stopUpdatingLocation];
    
}
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    alert.message = @"定位失败";
//    [alert addButtonWithTitle:@"知道了"];
//    [alert show];
//    
//}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //把当前的信息传给位置显示的界面 这边我们通过通知进行传递信息
        // 通知中心（单例）
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        //发送消息
        [center postNotificationName:@"CurrentLocationCity" object:self.city];
        
    }
    //并把定位到的城市 传到RKlocationController界面 修改数据源
    
}

@end