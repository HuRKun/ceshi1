//
//  RKRegisterContentController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/29.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKRegisterContentController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "Masonry.h"


@interface RKRegisterContentController () <UITextFieldDelegate>

@property (nonatomic, strong) NSTimer *time;

@property (nonatomic, assign) NSInteger number;//!<计时数

@end

@implementation RKRegisterContentController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置重新发送的按钮，完成按钮都为不能点击 并且重新按钮内容为一分钟倒计时
    self.number = 60;
//    self.finishBtn.enabled = NO;
    self.resendBtn.enabled = NO;
    self.resendBtn.highlighted = NO;

    
    [self saveMessageToSandbox];
    NSLog(@"%@",NSHomeDirectory());
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changerNumber) userInfo:nil repeats:YES];
}
- (void)changerNumber
{
    
    if (self.number == 0) {
        //停止定时器
        self.resendBtn.enabled = YES;
        self.number = 60;
        [self.resendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.time invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"重新发送(%ld)",self.number];
        [self.resendBtn setTitle:str forState:UIControlStateNormal];
    }
    self.number--;
    
}


- (void)editNavigationItem
{
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backBBI = [UIBarButtonItem createArrowBackBarButtomItemWithTaget:self action:@selector(backBBIDidClick:) CGRect:CGRectMake(0, 0, 24, 13)];
    self.navigationItem.title = @"注册";
    
    self.navigationItem.leftBarButtonItem = backBBI;

}
-(void)backBBIDidClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerUserWithCompletion:(void (^)(NSDictionary *))finishBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置AFNetworking的请求解析器，它会自动把参数拼成JSON的格式，包括把在请求头添加Content-Type字段为application/json
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{@"code": self.codeTextField.text,
                             @"mver":@"4",
                             @"xpassword":self.passwordTextField.text,
                             @"xpassword2" : self.password2TextField.text,
                             @"xusername": self.nameTextField.text,
                             @"mobile": @(self.phoneNum)};
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:REGISTER parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            
            finishBlock(obj);
//            NSLog(@"%@",obj);
//            NSLog(@"%@",obj[@"Message"][@"messagestr"]);
//            NSLog(@"%@",obj[@"Message"][@"messageval"]);
            
        }else{
            NSLog(@"数据错误%@",error);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"请求失败: %@", error);
        
    }];
    

}

#pragma mark - other
//判断所有的textFiled都没有为空
- (BOOL)judgeCommentIsWithNill
{
    if (self.codeTextField.text.length != 0 &&
        self.nameTextField.text.length != 0 &&
        self.passwordTextField.text.length != 0 &&
        self.password2TextField.text.length != 0) {
        
        return YES;
    }
    return NO;
}

- (BOOL)judgePasswordIsEqual
{
    if (self.passwordTextField.text.length >= 6 && self.password2TextField.text.length >=6
        ) {
        return YES;
    }
    return NO;
}

//完成按钮被点击
- (IBAction)finishBtnDidClicked:(id)sender {
    
    //判断内容不为空
    if ([self judgeCommentIsWithNill]) {
        //判断密码的字符个数大于六位
        if ([self judgePasswordIsEqual]) {
            //判断两次输入的密码相同
            if ([self.passwordTextField.text isEqualToString:self.password2TextField.text]) {
                
                [self registerUserWithCompletion:^(NSDictionary *dic) {
                    
                    if ([dic[@"messageval"] isEqualToString:@"register_succeed"]){
                        [self createMessageLabelWithView:self.view message:dic[@"messagestr"]];
                        //写入沙盒保存用户密码跟账号，以便下次启动软件的时候可以直接登陆
                        
                        [self saveMessageToSandbox];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [self createMessageLabelWithView:self.view message:dic[@"messagestr"]];
                    }
                }];
                
            }else{
                [self createMessageLabelWithView:self.view message:@"您两次输入的密码不一致"];
            }
        }else{
           [self createMessageLabelWithView:self.view message:@"您输入密码不足六位"];
        }
    }else{
        [self createMessageLabelWithView:self.view message:@"请完善注册信息"];
    }
   
    
}
//重新按钮被点击
- (IBAction)resendBtnDidClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(resendButtomDidClicked)]) {
        [self.delegate resendButtomDidClicked];
        self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changerNumber) userInfo:nil repeats:YES];
        self.resendBtn.enabled = NO;
    }
    
}
//隐藏键盘
- (IBAction)ClickedView:(id)sender {
    
    [self.view endEditing:YES];
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

- (void)saveMessageToSandbox
{
    //1.获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [path stringByAppendingString:@"/user.plist"];
    NSMutableArray *user = [NSMutableArray arrayWithContentsOfFile:plistPath];
    NSString *name = self.nameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSDictionary *dic = @{@"name":name,@"password":password};
    [user addObject:dic];
    //保存到沙盒
    [user writeToFile:plistPath atomically:YES];

}

//判断空格的时候不输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}
@end
