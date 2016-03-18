//
//  RKWeddingSubDtail.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingSubDtail.h"

@implementation RKWeddingSubDtail


//键名转换
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"wdDescription"}];
}

@end
