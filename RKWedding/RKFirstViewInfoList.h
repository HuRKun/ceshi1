//
//  RKFirstViewInfoList.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKFirstViewInfoList : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString * info1;
@property (nonatomic, copy) NSString * info2;
@property (nonatomic, copy) NSString * picname;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *indexintype;



/**
 *  通过name
 *
 *
 *  @return 该条数据模型
 */
+ (instancetype)InfoListFromDatabaseWithName:(NSString *)name;



@end
