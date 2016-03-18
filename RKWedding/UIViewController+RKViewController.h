//
//  UIViewController+RKViewController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  为了方便添加子视图控制器到容器上的封装
 */
@interface UIViewController (RKViewController)

/**
 *  把子视图控制器加到容器上
 *
 *  @param childViewController 要添加的子视图控制器
 */
- (void)rk_addChildViewController:(UIViewController *)childViewController;

/**
 *  把子视图控制器加到容器上，并指定其位置
 *
 *  @param childViewController 要添加的子视图控制器
 *  @param rect                表示位置的矩形
 */
- (void)rk_addChildViewController:(UIViewController *)childViewController inRect:(CGRect)rect;

/**
 *  把一个子视图控制器从容器上移除
 *
 *  @param childViewController 要移除的子视图控制器
 */
- (void)rk_removeChildViewController:(UIViewController *)childViewController;


@end
