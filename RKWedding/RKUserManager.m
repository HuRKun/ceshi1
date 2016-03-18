//
//  RKUserManager.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/10.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKUserManager.h"

@implementation RKUserManager

+(instancetype)shareManager
{
    static RKUserManager *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user  = [[RKUserManager alloc] init];
    });
    return user;
}

@end
