//
//  RKWeddingDetailRoot.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/5.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingDetailRoot.h"

@implementation RKWeddingDetailRoot

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        _commentlist = [[NSMutableArray alloc] init];
        _collectlist = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dict[@"commentlist"]) {
            commentListModel *model = [[commentListModel alloc] initWithDictionary:dic error:nil];
            [_commentlist addObject:model];
        }
        for (NSDictionary *dic in dict[@"collectlist"]) {
            collectListModel *model = [[collectListModel alloc] initWithDictionary:dic error:nil];
            [_collectlist addObject:model];
        }
        
    }
    return self;
}

@end
