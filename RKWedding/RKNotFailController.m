//
//  RKNotFailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKNotFailController.h"
#import "RKShareViewController.h"

#import "RKGlobalDefine.h"
@interface RKNotFailController ()

@end

@implementation RKNotFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refreshDidClicked:(id)sender {
    
    if ([self.delegaet respondsToSelector:@selector(againRefreshData)]) {
        [self.delegaet againRefreshData];
    }
}
// 设置导航栏的内容
- (void) editNavigationItem
{
    UIBarButtonItem *backBBI = [UIBarButtonItem createNormalBackBarButtomItemWithTaget:self action:@selector(backBBIDidClicked) CGRect:CGRectMake(0, 0, 10, 16)];
    self.navigationItem.leftBarButtonItem = backBBI;
    UIBarButtonItem *shareBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_be_share"] taget:self action:@selector(shareBBIDidClicked) CGRect:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem *fixedBBI = [UIBarButtonItem createFixedBackBarButtomItemWithWidth:15];
    UIBarButtonItem *likeBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_dis_listlike_n@3x"] taget:self action:@selector(likeBBIDidClicked) CGRect:CGRectMake(0, 0, 18, 16)];
    self.navigationItem.rightBarButtonItems = @[likeBBI,fixedBBI,shareBBI];
}
//返回  被点击
- (void)backBBIDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//喜欢  被点击
- (void)likeBBIDidClicked
{
    //如果没有登陆要跳到登陆界面
}
//分享  被点击
- (void)shareBBIDidClicked
{
    RKShareViewController *vc = [[RKShareViewController alloc] initWithNibName:@"RKShareViewController" bundle:nil];
    NSLog(@"%@",NSStringFromCGRect(vc.view.bounds));
    [self.navigationController rk_addChildViewController:vc inRect:kScreenBounds];
}

- (void)showMessage
{
    [UIView animateWithDuration:1 animations:^{
        [UILabel creareLableViewWithMessage:@"公司无效" supView:self.view];
    }];
}

@end
