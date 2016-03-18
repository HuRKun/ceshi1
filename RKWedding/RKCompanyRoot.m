//
//  RKCompanyRoot.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCompanyRoot.h"

@implementation RKCompanyRoot

//+ (BOOL)propertyIsOptional:(NSString *)propertyName
//{
//    return YES;
//}


- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
        _jxal = [[NSMutableArray alloc] init];
        _spal = [[NSMutableArray alloc] init];
        _yhtx = [[NSMutableArray alloc] init];
        _yykd = [[NSMutableArray alloc] init];
        _commentlist = [[NSMutableArray alloc] init];
        //全局队列
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            for (NSDictionary *dic in dict[@"jxal"]) {
                RKCompanyJxal *model = [[RKCompanyJxal alloc] initWithDictionary:dic error:nil];
                [_jxal addObject:model];
            }
        });
        dispatch_async(globalQueue, ^{
            for (NSDictionary *dic in dict[@"spal"]) {
                RKCompanyJxal *model = [[RKCompanyJxal alloc] initWithDictionary:dic error:nil];
                [_spal addObject:model];
            }
        });
        dispatch_async(globalQueue, ^{
            for (NSDictionary *dic in dict[@"yhtx"]) {
                RKBestPackage *model = [[RKBestPackage alloc] initWithDictionary:dic error:nil];
                [_yhtx addObject:model];
            }
        });
        dispatch_async(globalQueue, ^{
            for (NSDictionary *dic in dict[@"commentlist"]) {
                commentListModel *model = [[commentListModel alloc] initWithDictionary:dic error:nil];
                [_commentlist addObject:model];
            }

        });  
    }
    return self;
}
@end
