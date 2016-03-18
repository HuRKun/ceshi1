//
//  RKWeddingModel.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingModel.h"

@implementation RKWeddingModel

//key 转换
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"wdDescription"}];
}

@end
