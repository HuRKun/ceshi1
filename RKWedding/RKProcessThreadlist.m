//
//  RKProcessThreadlist.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKProcessThreadlist.h"

@implementation RKProcessThreadlist

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"typeid" : @"proTypeid"}];
}
@end
