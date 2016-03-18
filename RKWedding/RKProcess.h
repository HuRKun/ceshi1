//
//  RKProcess.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKProcess : JSONModel
/**
 *  讨论小组总的数据模型
 */
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *todayposts;
@property (nonatomic, copy) NSString *proDescription;

@end
