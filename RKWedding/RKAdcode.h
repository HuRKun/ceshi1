//
//  RKAdcode.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  全国所有省份的数据模型
 */
@interface RKAdcode : NSObject

@property (nonatomic, copy) NSString *cityname;//!< 省份
@property (nonatomic, copy) NSString *regionid;//!< 对应编号

/**
 *  从数据库里读取对应的详情，根据ID去取
 *
 *  @param applicationID 应用的ID
 *
 *  @return 表示详情数据的模型
 */
+ (instancetype)provinceFromDatabaseWithName:(NSString *)provinceName;





@end
