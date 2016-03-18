//
//  RKColors.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKColors.h"

@implementation RKColors

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        _list = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"list"]) {
            RKColorsDetail *detail = [[RKColorsDetail alloc] initWithDictionary:dic error:nil];
            [_list addObject:detail];
        }
    }
    return self;
}

@end
