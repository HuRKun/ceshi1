//
//  RKProcessForum.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  讨论小组头部的数据模型
 */
@interface RKProcessForum : JSONModel

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *fup;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *threads;
@property (nonatomic, copy) NSString *posts;
@property (nonatomic, copy) NSString *autoclose;

@end
