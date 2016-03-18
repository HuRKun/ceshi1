//
//  UIBarButtonItem+RKCustomBBI.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UIBarButtonItem+RKCustomBBI.h"

@implementation UIBarButtonItem (RKCustomBBI)

+(instancetype)createArrowBackBarButtomItemWithTaget:(id)taget action:(SEL)action CGRect:(CGRect)rect
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backBBI;
}


+(instancetype)createNormalBackBarButtomItemWithTaget:(id)taget action:(SEL)action CGRect:(CGRect)rect
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect ;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_nav_back"] forState:UIControlStateNormal];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backBBI;
}

+(instancetype)createImageBarButtomItemWithImage:(UIImage *)image taget:(id)taget action:(SEL)action CGRect:(CGRect)rect
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backBBI;
}

+(instancetype)createFixedBackBarButtomItemWithWidth:(CGFloat)width
{
    UIBarButtonItem *fixedBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedBBI.width = width;
    
    return fixedBBI;
}
@end
