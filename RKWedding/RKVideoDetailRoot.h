//
//  RKVideoDetailRoot.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "JSONModel.h"
#import "RKVideoDetailModel.h"
#import "commentListModel.h"
#import "collectListModel.h"
@interface RKVideoDetailRoot : JSONModel

@property (nonatomic, assign) BOOL ret;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) RKVideoDetailModel *hxjx;
@property (nonatomic, strong) NSMutableArray<commentListModel *> *commentlist;
@property (nonatomic, strong) NSMutableArray<collectListModel *> *collectlist;
@property (nonatomic, copy) NSString *usedms;

@end
