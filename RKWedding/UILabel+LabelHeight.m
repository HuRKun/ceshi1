//
//  UILabel+LabelHeight.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UILabel+LabelHeight.h"

@implementation UILabel (LabelHeight)


+(CGRect)calculateLabelWithContentForHeight:(NSString *)content width:(CGFloat)width font:(UIFont *)font
{
   
    CGSize constraintsSize = CGSizeMake(width , MAXFLOAT);
    CGRect itemHeight = [content boundingRectWithSize:constraintsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return itemHeight;
}
@end
