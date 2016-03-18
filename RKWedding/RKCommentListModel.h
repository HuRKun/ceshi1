//
//  RKCommentListModel.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  评论的数据模型
 */
@interface RKCommentListModel : JSONModel

@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *item_name;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *comment_time;
@property (nonatomic, copy) NSString *avatar;

@end
