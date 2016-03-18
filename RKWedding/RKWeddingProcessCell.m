//
//  RKWeddingProcessCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingProcessCell.h"
#import "RKWeddingProModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RKWeddingProcessCell

- (void)awakeFromNib {
    
    self.commentImageView.layer.cornerRadius = 10.f;
    self.commentImageView.clipsToBounds = YES;
    self.headImageView.layer.cornerRadius = 20.f;
    self.headImageView.clipsToBounds = YES;
}

- (void)fillDataForCell:(RKWeddingProModel *)model
{
    self.titleNameLabel.text = model.subject;
    self.placeLabel.text = model.city;
    self.timeLabel.text = model.marrydate;
    self.nameLabel.text =  model.author;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    [self.commentImageView sd_setImageWithURL:[NSURL URLWithString:model.coverpath] placeholderImage:[UIImage imageNamed:@"maskback"]];
    
}

@end
