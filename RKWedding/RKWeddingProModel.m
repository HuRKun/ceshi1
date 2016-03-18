//
//  RKWeddingProModel.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingProModel.h"

@implementation RKWeddingProModel

// 属性名转换
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"typeid":@"wdTypeid"}];
}


+ (BOOL) propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


@end
