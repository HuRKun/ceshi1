//
//  RKLineActDetailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/27.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLineActDetailController.h"
#import "RKShareViewController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
@interface RKLineActDetailController ()<MBProgressHUDDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *lineActWebView;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RKLineActDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.lineActWebView.delegate = self;
    
    [self editNavigationItem];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",XIANXIA,self.strUrl];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.hud show:YES];
    
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [self.lineActWebView loadRequest:requset];
    
}
- (void)editNavigationItem
{
    UIBarButtonItem *backBBI = [UIBarButtonItem createNormalBackBarButtomItemWithTaget:self action:@selector(backBBIDidClick:) CGRect:CGRectMake(0, 0, 10, 16)];
    UIBarButtonItem *shareBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_be_share"] taget:self action:@selector(shareBBIDidClicked) CGRect:CGRectMake(0, 0, 25, 25)];
    self.navigationItem.leftBarButtonItem = backBBI;
    self.navigationItem.rightBarButtonItem = shareBBI;
}
//返回 被点击
- (void)backBBIDidClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//分享  被点击
- (void)shareBBIDidClicked
{
    RKShareViewController *vc = [[RKShareViewController alloc] initWithNibName:@"RKShareViewController" bundle:nil];
    NSLog(@"%@",NSStringFromCGRect(vc.view.bounds));
    [self.navigationController rk_addChildViewController:vc inRect:kScreenBounds];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WebDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hide:YES afterDelay:1.35f];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIView animateWithDuration:1 animations:^{
        [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
    }];
}
#pragma mark - Setter & Getter
- (MBProgressHUD *)hud
{
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.delegate = self;
        _hud.labelText = @"Loading";
        _hud.removeFromSuperViewOnHide = YES;
        _hud.animationType = MBProgressHUDAnimationZoom;
        _hud.opacity = 0.4;
        
    }
    return _hud;
}
@end
