//
//  UILabel+RKCreateLabelMessage.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface UILabel (RKCreateLabelMessage)

+ (UILabel *)creareLableViewWithMessage:(NSString *)message;

+ (void)creareLableViewWithMessage:(NSString *)message supView:(UIView *)view;

@end
