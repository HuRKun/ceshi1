//
//  RKDiscoverCollectionCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDiscoverCollectionCell.h"
#import "RKColorsDetail.h"
#import "RKGlobalDefine.h"
@implementation RKDiscoverCollectionCell

- (void)awakeFromNib {
    self.numLabel.layer.cornerRadius = 9.0f;
    self.numLabel.clipsToBounds = YES;
}

- (void)configDataForCell:(RKColorsDetail *)model
{

    self.titleLabel.text = model.color_name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.color_logo] placeholderImage:[UIImage imageNamed:@"img_dis_shadowpicn@2x "]];
    self.numLabel.text = [NSString stringWithFormat:@" %@ 图 ",model.count];
}

@end
