//
//  RKBestVideoCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestVideoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RKBestVideoCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 12.0f;
    self.default_image.clipsToBounds = YES;
    self.center = self.playImageView.center;
}

-(void)fillDataForCell:(RKBestWedding *)wedding
{
    NSURL *imageUrl = [NSURL URLWithString:wedding.default_image];
    [self.default_image sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"maskback"]];
    
    self.hxjx_name.text = wedding.hxjx_name;
    self.jxsp_date.text = wedding.jxsp_date;
    self.team_name.text = wedding.team_name;
    CGFloat time = [wedding.jxsp_duration floatValue];
    NSInteger f = time / 60.0f;
    NSInteger s = time - f*60;
    NSString *duration = [NSString stringWithFormat:@"%ld分%ld秒",f,s];
    self.jxsp_duration.text = duration;
    self.views.text = [NSString stringWithFormat:@"%@ 播放",wedding.views];
}

@end
