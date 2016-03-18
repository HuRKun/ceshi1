//
//  RKTableViewHeadView.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/27.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKTableViewHeadView.h"

@implementation RKTableViewHeadView

- (void)awakeFromNib
{
    self.leftView.layer.cornerRadius = 2.0f;
    self.leftView.clipsToBounds = YES;
}

@end
