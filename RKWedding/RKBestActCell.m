//
//  RKBestActCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestActCell.h"
#import "RKGlobalDefine.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RKBestActCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageViewHeight;

@end
@implementation RKBestActCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 12.0f;
    self.default_image.clipsToBounds = YES;
    if (kScreenWidth == 415) {
        self.ConstraintTop.constant = self.bounds.size.height * 0.9;
    }
    
}

-(void)fillDataForCell:(RKBestLineAct *)lineAct
{
    
    //根据屏幕大小适配
    if (kScreenWidth > 320) {
        self.defaultImageViewHeight.constant = self.bounds.size.height - self.bgImageViewHeight.constant + 10;
        self.xxhd_name.text = lineAct.xxhd_name;
    }else{
        self.defaultImageViewHeight.constant = self.bounds.size.height * 0.67;
        self.bgImageViewHeight.constant = self.bounds.size.height * 0.33 + 10;
    }
    self.xxhd_name.text = lineAct.xxhd_name;
    NSString *data = [NSString stringWithFormat:@"时间: %@",lineAct.date];
    NSString *address = [NSString stringWithFormat:@"地点: %@",lineAct.address];
    self.data.text = data;
    self.address.text = address;

    NSURL *imageUrl = [NSURL URLWithString:lineAct.default_image];
    
    [self.default_image sd_setImageWithURL:imageUrl];
}

@end
