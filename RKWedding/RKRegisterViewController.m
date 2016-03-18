//
//  RKRegisterViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKRegisterViewController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "Masonry/Masonry.h"
#import "RKRegisterContentController.h"
@interface RKRegisterViewController () <RKRegisterContentControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextPassBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (nonatomic, copy) NSString *message;//!<注册提示信息

@property (nonatomic, copy) NSString *messageval;//!<服务器返回数据
@end

@implementation RKRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editNavigationItem];
    
//    [self judgePhoneNumberWithExist];
    
}
- (void)editNavigationItem
{
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backBBI = [UIBarButtonItem createArrowBackBarButtomItemWithTaget:self action:@selector(backBBIDidClick:) CGRect:CGRectMake(0, 0, 24, 13)];
    self.navigationItem.title = @"注册";
    
    self.navigationItem.leftBarButtonItem = backBBI;
    self.nextPassBtn.layer.cornerRadius = 10.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBBIDidClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击下一步
// 1. 判断该数字是不是电话号码
- (IBAction)nextPassBtnDidClicked:(id)sender {
    
    
    //判断内容是不是电话号码
   BOOL ret = [self judgeTextFieldCurrentContent];

    //判断手机号是否已经注册
    if (ret){
        
       [self judgePhoneNumberWithExist];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.messageval isEqualToString:@"do_success"]) {
                //跳转下一界面 设置密码
                RKRegisterContentController *vc = [[RKRegisterContentController alloc] initWithNibName:@"RKRegisterContentController" bundle:nil];
                vc.delegate = self;
                vc.phoneNum = [self.phoneNumber.text integerValue];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            else{
                [self.phoneNumber isFirstResponder];
                UILabel *hintView = [self creareLableViewWithMessage:self.message];
                [self.view addSubview:hintView];
                [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerY.mas_equalTo(self.view);
                    make.centerX.mas_equalTo(self.view);
                    make.height.mas_equalTo(30);
                    
                }];
                [self.view bringSubviewToFront:hintView];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    self.message = @"手机格式不对,请重新输入";
                    [hintView removeFromSuperview];
                    
                });
            }
        });
       
    }
    
    
    
    
}

//判断电话号码是否注册
- (void)judgePhoneNumberWithExist
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置AFNetworking的请求解析器，它会自动把参数拼成JSON的格式，包括把在请求头添加Content-Type字段为application/json
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSDictionary *params = @{@"phone": self.phoneNumber.text,
                             @"mver": @"4",@"type":@"0"};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:CODE parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",jsonObj);
        self.message = jsonObj[@"Message"][@"messagestr"];
        self.messageval = jsonObj[@"Message"][@"messageval"];
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"请求失败: %@", error);
        self.message = nil;
    }];
    
    
    
}

- (BOOL)judgeTextFieldCurrentContent
{
    //通过正则表达式判断
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$" options:0 error:nil];
    
    NSRange range = [regex rangeOfFirstMatchInString:self.phoneNumber.text options:NSMatchingReportCompletion range:NSMakeRange(0,self.phoneNumber.text.length)];
    
    
    if (range.location == NSNotFound || range.length == 0) {

        UILabel *hintView = [self creareLableViewWithMessage:@"手机格式不对,请重新输入"];
        [self.view addSubview:hintView];
        [hintView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerY.mas_equalTo(self.view);
            make.centerX.mas_equalTo(self.view);
            make.height.mas_equalTo(30);
            
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hintView removeFromSuperview];
            
        });
        return NO;
    }
    return YES;

}

- (UILabel *)creareLableViewWithMessage:(NSString *)message
{
    UILabel *hintView = [[UILabel alloc] init];
    hintView.text = message;
    hintView.backgroundColor = [UIColor blackColor];
    hintView.textColor = [UIColor whiteColor];
    hintView.textAlignment = NSTextAlignmentCenter;
    hintView.font = [UIFont systemFontOfSize:13];
    hintView.numberOfLines = 0;
    hintView.layer.cornerRadius = 10.0f;
    hintView.clipsToBounds = YES;
    hintView.center = self.view.center;
    return hintView;
}

- (void)resendButtomDidClicked
{
    [self judgePhoneNumberWithExist];
}
@end
