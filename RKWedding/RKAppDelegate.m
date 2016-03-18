//
//  RKAppDelegate.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKAppDelegate.h"
#import "RKGlobalDefine.h"
#import "RKUserGuideViewController.h"
#import "RKRootViewController.h"

#import <UMSocial.h>
//导入系统地图的库  在国内用的是高德地图
#import <MapKit/MapKit.h>
@interface RKAppDelegate () <CLLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) RKRootViewController *rootViewCOntroller; //!< 根视图控制器

@property (nonatomic, strong) CLLocationManager *locationManager;//!<地图管理器，用于定位


@end

@implementation RKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    

    
    // 判断是否为首次启动
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        // 是第一次启动
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        RKUserGuideViewController *userGuideViewController = [[RKUserGuideViewController alloc] init];
        [self writeDataFromSandBox];
        [self wrirePlistToSandBox];
        self.window.rootViewController = userGuideViewController;
    }
    else
    {
        //如果不是第一次启动的话,使用rootViewController作为根视图
        self.window.rootViewController = self.rootViewCOntroller;
        [RKLoginManager shareManager].islogin = NO;
        
    }
    self.window.backgroundColor = [UIColor whiteColor];
    //显示Window
    [self.window makeKeyAndVisible];

    
    return YES;
}
#pragma mark - Other

- (void)writeDataFromSandBox
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbFilePath = [doc stringByAppendingPathComponent:@"WDDataSql.sqlite"];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    if (!isExist) {
        //拷贝数据库
        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:@"WDDataSql" ofType:@"sqlite"];
        NSError *error = nil;
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:&error];
        if (cp) {
            NSLog(@"数据库拷贝成功");
        }else{
            NSLog(@"数据库拷贝失败： %@",[error localizedDescription]);
        }
    }
}
#pragma mark - other
- (void)wrirePlistToSandBox
{
    //1.获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [path stringByAppendingString:@"/user.plist"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL ret = [manager createFileAtPath:plistPath contents:nil attributes:nil];
    NSLog(@"%@",ret ? @"YES" :@"NO");
    
    NSMutableArray *arr = [NSMutableArray array];
   BOOL ret1 = [arr writeToFile:plistPath atomically:YES];
    NSLog(@"%@",ret1 ? @"写入成功" :@"写入失败");
    
}


#pragma mark - Setter & Getter;

- (RKRootViewController *)rootViewCOntroller
{
    if (_rootViewCOntroller == nil) {
        _rootViewCOntroller = [[RKRootViewController alloc] init];
    }
    return _rootViewCOntroller;
}




@end
