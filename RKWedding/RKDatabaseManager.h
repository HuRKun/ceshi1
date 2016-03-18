//
//  RKDatabaseManager.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
/**
 *  数据库管理类，单例，为了方便每个地方都用到
 */
@interface RKDatabaseManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue; //!< 用户数据库操作的队列，线程安全的

/**
 *  单例入口
 */
+ (instancetype)shareManager;


@end
