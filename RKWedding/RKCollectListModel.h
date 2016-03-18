//
//  RKCollectListModel.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  喜欢的数据模型
 */
@interface RKCollectListModel : JSONModel

@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *avatar;

@end
