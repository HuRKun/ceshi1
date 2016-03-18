//
//  RKProcessVaribles.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKProcessVaribles.h"

@implementation RKProcessVaribles

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        _forum_threadlist = [[NSMutableArray alloc] init];
        _toplist = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"forum_threadlist "]) {
            RKProcessThreadlist *thread = [[RKProcessThreadlist alloc] initWithDictionary:dic error:nil];
            [_forum_threadlist addObject:thread];
        }
        for (NSDictionary *dic in dict[@"toplist"]) {
            RKToplist *top = [[RKToplist alloc] initWithDictionary:dic error:nil];
            [_toplist addObject:top];
        }
    }
    return self;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
