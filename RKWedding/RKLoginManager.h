//
//  RKLoginManager.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/10.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKLoginManager : NSObject

@property (nonatomic, assign) BOOL islogin;//!<判断是否登入

@property (nonatomic, assign) BOOL islocation;//< 判断是否定位成功

@property (nonatomic, copy) NSString *locationCity;//!< 当前定位到的城市

@property (nonatomic, assign) BOOL islocationCity;//!< 判断是否定位城市

@property (nonatomic, copy) NSString *chooseCity;//!< 用户手动定位的城市

+ (instancetype)shareManager;

@end
