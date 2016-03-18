//
//  RKHeadViewCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKHeadViewCell.h"

@implementation RKHeadViewCell

- (void)awakeFromNib {
    
    self.companyBtn.layer.cornerRadius = 8.0f;
    self.companyBtn.clipsToBounds = YES;
    self.showMoreBrn.hidden = YES;
}

- (IBAction)companyBtnDidClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(companyBtnDidTriggerWith:)]) {
        [self.delegate companyBtnDidTriggerWith:self];
    }
}


@end
