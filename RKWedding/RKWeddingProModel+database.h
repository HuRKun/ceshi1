//
//  RKWeddingProModel+database.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/11.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingProModel.h"

@interface RKWeddingProModel (database)

/**
 *  保存数据到数据库
 *
 *  @return 保存是否成功
 */
- (BOOL)saveDataForlocation;

/**
 *  从数据库获取数据
 *
 *  @return 返回数据库的数据
 */
+ (NSMutableArray *)getDataFromLocation;


@end
