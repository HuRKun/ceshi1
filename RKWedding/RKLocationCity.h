//
//  RKLocationCity.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  为了方便其他界面得到我们定位到的信息，我们把定位到的数据模型写成一个单例
 */
@interface RKLocationCity : NSObject

@property (nonatomic, copy) NSString *cityName;//!< 当前定位到的城市

@property (nonatomic, copy) NSString *lon;//!<经度

@property (nonatomic, copy) NSString *lat;//!< 纬度

+ (instancetype)shareManager;

@end
