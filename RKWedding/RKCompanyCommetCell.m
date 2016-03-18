//
//  RKCompanyCommetCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCompanyCommetCell.h"
#import "RKGlobalDefine.h"
@implementation RKCompanyCommetCell

- (void)awakeFromNib {
    
    self.headImageView.layer.cornerRadius = 20.0f;
    self.headImageView.clipsToBounds = YES;
}


- (void)configeDataForCell:(commentListModel *)model
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLabel.text = model.user_name;
    int store = [model.score intValue];
    NSArray *imageViewArray = [self.storeView subviews];
    for (int i=0; i<store; i++) {
        UIImageView *imageView = imageViewArray[i];
        imageView.image = [UIImage imageNamed:@"img_stardp_s"];
    }

    self.commentLabel.text = model.comment;
}
@end
