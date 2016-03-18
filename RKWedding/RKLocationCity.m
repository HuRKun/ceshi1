//
//  RKLocationCity.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLocationCity.h"

@implementation RKLocationCity


+ (instancetype)shareManager
{
    static RKLocationCity *city;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        city = [[RKLocationCity alloc] init];
    });
    
    return city;
}

@end
