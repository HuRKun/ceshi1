//
//  TransparentNavigationController.m
//  
//
//  Created by DancewithPeng on 16/2/22.
//
//

#import "TransparentNavigationController.h"
#import "UIImage+DPTransparent.h"

@interface TransparentNavigationController ()

@end

@implementation TransparentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.把背景图片设置为一张透明图片
    // 这里是用代码来生成一张透明的图片
    UIImage *transparentImage = [UIImage transparentImage];
    [self.navigationBar setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
    
    // 2.如果需要把NavigationBar底部的线也隐藏掉，就把shadowImage也设置为透明图片
    UIImage *shadowTransparentImage = [UIImage transparentImage];
    [self.navigationBar setShadowImage:shadowTransparentImage];
    
    // 3.添加自己的透明的背景的View
    self.transparentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.navigationBar.bounds.size.width, 64)];
    self.transparentBackgroundView.tag = 1001;
    [self.navigationBar insertSubview:self.transparentBackgroundView atIndex:0];
}

- (void)viewDidLayoutSubviews
{
    // 判断屏幕的方向，调整透明背景的View的布局
    UIInterfaceOrientation deviceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (deviceOrientation==UIInterfaceOrientationPortrait || deviceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        self.transparentBackgroundView.frame = CGRectMake(0, -20, self.navigationBar.bounds.size.width, 64);
    } else {
        self.transparentBackgroundView.frame = CGRectMake(0, 0, self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height);
    }
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



@implementation UINavigationController (Transparent)

- (UIView *)transparentBackgroundView
{
    if ([self isKindOfClass:[TransparentNavigationController class]]) {
        return [self.navigationBar viewWithTag:1001];
    }
    
    return nil;
}

@end
