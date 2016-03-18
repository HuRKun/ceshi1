//
//  RKLoginManager.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/10.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLoginManager.h"

@implementation RKLoginManager






+(instancetype)shareManager
{
    static RKLoginManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^{
        manager = [[RKLoginManager alloc] init];
    });
    return manager;
}


@end
