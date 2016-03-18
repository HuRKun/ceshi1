//
//  UIBarButtonItem+RKCustomBBI.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RKCustomBBI)

/**
 *  创建一个箭头的返回 BarButtomItem
 *
 *  @param taget  按钮事件的触发者
 *  @param action 按钮事件
 *  @param rect  按钮的大小
 *
 *  @return 返回创建好的BarButtomItem
 */
+ (instancetype)createArrowBackBarButtomItemWithTaget:(id)taget action:(SEL)action CGRect:(CGRect)rect;

/**
 *  创建一个普通的返回 BarButtomItem
 *
 *  @param taget  按钮事件的触发者
 *  @param action 按钮事件
 *  @param rect 按钮的大小
 *
 *  @return 返回创建好的BarButtomItem
 */
+ (instancetype)createNormalBackBarButtomItemWithTaget:(id)taget action:(SEL)action CGRect:(CGRect)rect;

/**
 *  创建一个图片图片式的 BarButtomItem
 *
 *  @param imageName 图片
 *  @param taget     按钮事件的触发者
 *  @param action    按钮事件
 *  @param rect     按钮的大小
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)createImageBarButtomItemWithImage:(UIImage *)image taget:(id)taget action:(SEL)action CGRect:(CGRect)rect;
/**
 *  创建一个可以调整其他BarButtomItem位置的隐形按钮
 *
 *  @param width 按钮的宽度
 *
 *  @return 返回创建好的按钮
 */
+ (instancetype)createFixedBackBarButtomItemWithWidth:(CGFloat)width;


@end
