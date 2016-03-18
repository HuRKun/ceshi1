//
//  RKCollectHeadImageCell.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCollectHeadImageCell.h"

@implementation RKCollectHeadImageCell

- (void)awakeFromNib {
    
    self.headImageView.layer.cornerRadius = 20.0f;
    self.headImageView.clipsToBounds = YES;
}

@end
