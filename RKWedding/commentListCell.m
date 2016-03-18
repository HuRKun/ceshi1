//
//  commentListCell.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "commentListCell.h"
#import "RKGlobalDefine.h"
@implementation commentListCell

- (void)awakeFromNib {
    // Initialization code
    self.headImageView.layer.cornerRadius = 20.0f;
    self.headImageView.clipsToBounds = YES;
}


- (void)cofigDataForCell:(commentListModel *)model
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.commentLabel.text = model.comment;
    self.userNameLabel.text = model.user_name;
    self.timeLabel.text = model.comment_time;
}
@end
