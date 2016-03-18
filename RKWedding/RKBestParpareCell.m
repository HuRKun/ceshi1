//
//  RKBestParpareCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestParpareCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RKBestParpareCell

- (void)awakeFromNib {
    self.default_image.layer.cornerRadius = 12.0f;
    self.default_image.clipsToBounds = YES;
}

-(void)fillDataForCell:(RKBestPackage *)parpare
{
    self.yhhd_name.text = parpare.yhhd_name;
    self.shop_cate_name.text = parpare.shop_cate_name;
    self.market_price.text = parpare.market_price;
    
    NSString *price = [NSString stringWithFormat:@"%@ 元起",parpare.shop_price];
    self.shop_price.text = price;
    
    NSURL *imageUrl = [NSURL URLWithString:parpare.default_image];
    [self.default_image sd_setImageWithURL:imageUrl];
    
}

@end
