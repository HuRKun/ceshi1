//
//  UILabel+LabelHeight.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeight)


/**
 *  计算Label的高度
 *
 *  @param content label显示的内容
 *
 *  @return label的高度
 */
+ (CGRect)calculateLabelWithContentForHeight:(NSString *) content width:(CGFloat)width font:(UIFont *)font;


@end
