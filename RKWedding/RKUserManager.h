//
//  RKUserManager.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/10.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKUserManager : NSObject


@property (nonatomic, copy) NSString *username;//!<用户名字

@property (nonatomic, copy) NSString *headImage;//!<用户头像


@property (nonatomic, copy) NSString *formhash;


+ (instancetype)shareManager;



@end
