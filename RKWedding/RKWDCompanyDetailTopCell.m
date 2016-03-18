//
//  RKWDCompanyDetailTopCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWDCompanyDetailTopCell.h"
#import "RKGlobalDefine.h"
@implementation RKWDCompanyDetailTopCell

- (void)awakeFromNib {

}

-(void)configeDataForCell:(RKCompanyDetailTop *)model
{
    int store = [model.comment_score intValue];
    NSArray *imageViewArray = [self.storeView subviews];
    for (int i=0; i<store; i++) {
        UIImageView *imageView = imageViewArray[i];
        imageView.image = [UIImage imageNamed:@"img_star_s"];
    }
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.top_image]];
    self.companyNameLabel.text = model.company_name;
    NSString *com = [NSString stringWithFormat:@" %@条",model.comments];
    [self.plNumberBtn setTitle:com forState:UIControlStateNormal];
    self.collectLabel.text = model.collects;
    NSString *price = [NSString stringWithFormat:@"人均 %@",model.base_amount];
    self.priceLabel.text = price;
    NSString *address = [NSString stringWithFormat:@"地址：%@",model.address];
    NSString *descrip = [NSString stringWithFormat:@"概览：%@",model.wdDescription];
    self.adressLabel.text = address;
    self.companyDesciptionLabel.text = descrip;
    
}

@end
