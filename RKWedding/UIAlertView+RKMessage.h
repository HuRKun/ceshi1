//
//  UIAlertView+RKMessage.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/12.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (RKMessage)

/**
 *  文本请示框
 *
 *  @param message 提示的信息
 *  @param title   提示的标题
 */
+ (void)alertWithMessage:(NSString *)message title:(NSString *)title;


@end
