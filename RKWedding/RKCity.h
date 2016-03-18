//
//  RKCity.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKDatabaseManager.h"
#import <FMDB/FMDB.h>
@interface RKCity : NSObject

@property (nonatomic,assign) NSInteger region_id;//!< 全国每个城市的id
@property (nonatomic, copy) NSString *region_code;//!省id
@property (nonatomic, copy) NSString *region_name;//!<城市名称
@property (nonatomic, assign) NSInteger parent_id;//!< 市级id
@property (nonatomic, assign) NSInteger sort_order;



/**
 *  通过市级城市名称
 *
 *  @param region_name 市级城市名称
 *
 *  @return 该市级的数据模型
 */
+ (instancetype)cityFromDatabaseWithRegion_name:(NSString *)region_name;


/**
 *  通过市级城市id
 *
 *  @param region_name 市级城市id
 *
 *  @return 该市的所有区县数据模型的集合
 */
+ (NSArray *)cityFromDatabaseWithParent_id:(NSInteger)parent_id;

@end
