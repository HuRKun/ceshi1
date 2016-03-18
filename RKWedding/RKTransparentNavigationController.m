//
//  RKTransparentNavigationController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKTransparentNavigationController.h"
#import "UIImage+DPTransparent.h"
#import "UIBarButtonItem+RKCustomBBI.h"
@interface RKTransparentNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation RKTransparentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏样式
    UIColor *color = [UIColor colorWithRed:209/255.0f green:52/255.0f blue:109/255.0f alpha:1];
    //    UIFont *foint = [UIFont systemFontOfSize:17];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    [self.navigationBar setTintColor:color];
    
    UIImage *image = [UIImage transparentImage];
    //设置一张透明的图片为导航栏的背景图片
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //导航栏下面的黑色线条也是一张图片  也要换成透明的图片
    [self.navigationBar setShadowImage:image];
    
    
    // 处理navigationController iOS7的返回手势
    self.interactivePopGestureRecognizer.delegate = self;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 先判断是不是返回的手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count > 1) {
            return YES;
        }
        
        return NO;
    }
    
    return YES;
}

//返回  被点击
- (void)backBBIDidClicked
{
    [self popViewControllerAnimated:YES];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:YES];
    if (self.viewControllers.count > 1) {
        UIBarButtonItem *backBBI = [UIBarButtonItem createNormalBackBarButtomItemWithTaget:self action:@selector(backBBIDidClicked) CGRect:CGRectMake(0, 0, 10, 16)];
        viewController.navigationItem.leftBarButtonItem = backBBI;
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


@implementation UINavigationController (Transparent)

- (UIView *)transparentBackgroundView
{
    if ([self isKindOfClass:[RKTransparentNavigationController class]]) {
        return [self.navigationBar viewWithTag:1001];
    }
    
    return nil;
}

@end