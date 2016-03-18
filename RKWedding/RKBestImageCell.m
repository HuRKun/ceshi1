//
//  RKBestImageCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RKBestImageCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 12.0f;
    self.default_image.clipsToBounds = YES;
}

-(void)fillDataForCell:(RKBestWedding *)wedding
{
    NSURL *imageUrl = [NSURL URLWithString:wedding.default_image];
    [self.default_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"img_dis_shadowpicn@2x "]];
}
@end
