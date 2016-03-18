//
//  RKLoginViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLoginViewController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
#import "RKRegisterViewController.h"
#import "RKGetPasswordController.h"
#import "RKTexthtmlController.h"
#import "RKMyController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "Masonry.h"
#import "RKAppDelegate.h"
@interface RKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation RKLoginViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *backBBI = [UIBarButtonItem createArrowBackBarButtomItemWithTaget:self action:@selector(backBBIDidClick:) CGRect:CGRectMake(0, 0, 24, 13)];
        self.navigationItem.title = @"登录";
        
        self.navigationItem.leftBarButtonItem = backBBI;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBtn.layer.cornerRadius = 10.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)backBBIDidClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//跳转到注册界面
- (IBAction)registerUser:(id)sender {
    
    RKRegisterViewController *registerVC = [[RKRegisterViewController alloc] initWithNibName:@"RKRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//跳转到忘记密码界面
- (IBAction)forgetPassword:(id)sender {
    
    RKGetPasswordController *vc = [[RKGetPasswordController alloc] initWithNibName:@"RKGetPasswordController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//隐私按钮被点击  跳转到隐私政策
- (IBAction)privacyBtnDidClicked:(id)sender {
    
    RKTexthtmlController *vc = [[RKTexthtmlController alloc] initWithNibName:@"RKTexthtmlController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginDidCliced:(id)sender
{
    
    [self loginSuccessWithCompletion];

}

- (void)createMessageLabelWithView:(UIView *)view message:(NSString *)message
{
    UILabel *hintView = [UILabel creareLableViewWithMessage:message];
    [view addSubview:hintView];
    [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(30);
        
    }];
    [self.view bringSubviewToFront:hintView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hintView removeFromSuperview];
        
    });
}
- (void)loginSuccessWithCompletion
{
//    NSLog(@"%@",[RKUserManager shareManager].username);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{@"password": self.password.text,
                             @"mver":@"3",
                             @"username":self.phoneNumber.text,
                             };
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:LOGIN parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        
        NSError *error = nil;
        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            
            if ([dic[@"Message"][@"messageval"] isEqualToString:@"login_succeed"]) {
                
                [RKLoginManager shareManager].islogin = YES;
                NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
                [notification postNotificationName:@"loginsuccess" object:nil];
                [RKUserManager shareManager].username = dic[@"Variables"][@"member_username"];
                [RKUserManager shareManager].headImage = dic[@"Variables"][@"avatar"];
                [RKUserManager shareManager].formhash = dic[@"Variables"][@"formhash"];
//                dic = nil;
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                
                [self createMessageLabelWithView:self.view message:dic[@"Message"][@"messagestr"]];
            }
//            NSLog(@"%@",dic);
            
        }else{
            NSLog(@"数据错误%@",error);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"请求失败: %@", error);
        
    }];
}
@end
