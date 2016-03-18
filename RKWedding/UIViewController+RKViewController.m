//
//  UIViewController+RKViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UIViewController+RKViewController.h"

@implementation UIViewController (RKViewController)

- (void)rk_addChildViewController:(UIViewController *)childViewController inRect:(CGRect)rect
{
    [self.view addSubview:childViewController.view];
    [self addChildViewController:childViewController];
    [childViewController didMoveToParentViewController:self];
    
    childViewController.view.frame = rect;
}

- (void)rk_addChildViewController:(UIViewController *)childViewController
{
    [self rk_addChildViewController:childViewController inRect:self.view.bounds];
}

- (void)rk_removeChildViewController:(UIViewController *)childViewController
{
    [childViewController.view removeFromSuperview];
    [childViewController willMoveToParentViewController:nil];
    [childViewController removeFromParentViewController];
}

@end
