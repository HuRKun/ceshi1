//
//  RKVideoDetailModel.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKVideoDetailModel.h"

@implementation RKVideoDetailModel


+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"wdDescription"}];
}

@end
