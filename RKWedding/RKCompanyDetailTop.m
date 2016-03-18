//
//  RKCompanyDetailTop.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCompanyDetailTop.h"

@implementation RKCompanyDetailTop

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"wdDescription"}];
    
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        __images = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"_images"]) {
            RKImage *image = [[RKImage alloc] initWithDictionary:dic error:nil];
            [__images addObject:image];
        }
    }
    return self;
}

@end
