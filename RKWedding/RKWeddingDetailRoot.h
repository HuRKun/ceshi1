//
//  RKWeddingDetailRoot.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/5.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "commentListModel.h"
#import "collectListModel.h"
#import "RKWeddingDtail.h"
@interface RKWeddingDetailRoot : JSONModel

@property (nonatomic, assign) BOOL ret;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) RKWeddingDtail *hxjx;
@property (nonatomic, strong) NSMutableArray<commentListModel *> *commentlist;
@property (nonatomic, strong) NSMutableArray<collectListModel *> *collectlist;
@property (nonatomic, copy) NSString *usedms;

@end
