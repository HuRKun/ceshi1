//
//  RKProcessThreadlistCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKProcessThreadlistCell.h"
#import "RKGlobalDefine.h"
@implementation RKProcessThreadlistCell

- (void)awakeFromNib {
    
    self.headImageView.layer.cornerRadius = 20.0f;
    self.headImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)fillDataForCell:(RKProcessThreadlist *)list
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:list.avatar]];
    self.nameLabel.text = list.author;
    self.timeLabel.text = list.lastpost;
    self.subjectLabel.text = list.subject;
    self.messageLabel.text = list.message;
    self.repliseLabel.text = list.replies;
    
}
@end
