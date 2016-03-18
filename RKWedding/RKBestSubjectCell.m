//
//  RKBestSubjectCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestSubjectCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RKBestWDSubject.h"
#import "RKGlobalDefine.h"
@interface RKBestSubjectCell ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *decriptionHeight;

@end
@implementation RKBestSubjectCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 8.0f;
    self.default_image.clipsToBounds = YES;
    //设置图片的拉伸
    UIImage *bg = [UIImage imageNamed:@"img_be_shadowlight"];
    
    CGFloat top = 200; // 顶端盖高度
    CGFloat bottom = 200 ; // 底端盖高度
    CGFloat left = 5; // 左端盖宽度
    CGFloat right = 5; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    bg = [bg resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    
    
}

-(void)fillDataForCell:(RKBestWDSubject *)subject
{
    //    根据屏幕大小适配
    self.defaultImageHeight.constant = self.bounds.size.height * 0.7;
    self.bgImageViewHeight.constant = self.bounds.size.height * 0.3 + 10;
    self.wdDescription.text = subject.ztDescription;
    
    NSURL *imageUrl = [NSURL URLWithString:subject.default_image];
    
    [self.default_image sd_setImageWithURL:imageUrl];
}

@end
