//
//  RKCompanyWDALCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCompanyWDALCell.h"
#import "RKGlobalDefine.h"
@implementation RKCompanyWDALCell

- (void)awakeFromNib {
    
    self.defaultImageView.layer.cornerRadius = 10.0f;
    self.defaultImageView.clipsToBounds = YES;
}

-(void)configeDataForCell:(RKCompanyJxal *)model
{
    [self.defaultImageView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
    self.nameLabel.text = model.product_name;
    
}
@end
