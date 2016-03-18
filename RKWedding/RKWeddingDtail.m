//
//  RKWeddingDtail.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/5.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingDtail.h"

@implementation RKWeddingDtail

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"wdDescription"}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        __images = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"_images"]) {
            
            RKImageModel *model = [[RKImageModel alloc] initWithDictionary:dic error:nil];
           
                [__images addObject:model];
        }
    }
    return self;
}
@end
