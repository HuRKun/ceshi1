//
//  RKRKBestWeddingCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKRKBestWeddingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RKRKBestWeddingCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 12.0f;
    self.default_image.clipsToBounds = YES;
}

-(void)fillDataForCell:(RKBestWedding *)wedding
{
    NSURL *imageUrl = [NSURL URLWithString:wedding.default_image];
    [self.default_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maskback"]];
    self.company_name.text = wedding.company_name;
    self.cate_name.text = wedding.cate_name;
    NSString *readCount = [NSString stringWithFormat:@"%@ 阅读",wedding.views];
    self.views.text = readCount;
    NSString *share = [NSString stringWithFormat:@"%@ 分享",wedding.points];
    self.points.text = share;
}

@end