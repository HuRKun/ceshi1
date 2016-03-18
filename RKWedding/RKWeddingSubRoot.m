//
//  RKWeddingSubRoot.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingSubRoot.h"

@implementation RKWeddingSubRoot

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"wdTrue":@"true"}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        _hls = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"hls"]) {
            RKWeddingSubDtail2 *model = [[RKWeddingSubDtail2 alloc] initWithDictionary:dic error:err];
            [_hls addObject:model];
        }
        
    }
    return self;
}
@end


