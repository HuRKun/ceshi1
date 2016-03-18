//
//  RKCompanyRoot.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKCompanyDetailTop.h"
#import "RKCompanyJxal.h"
#import "commentListModel.h"
#import "RKBestPackage.h"
@interface RKCompanyRoot : JSONModel

@property (nonatomic, assign) BOOL ret;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *service_id;
@property (nonatomic, strong) RKCompanyDetailTop *company;

@property (nonatomic, strong) NSMutableArray<RKCompanyJxal *> *jxal;
@property (nonatomic, strong) NSMutableArray<RKCompanyJxal *> *spal;
@property (nonatomic, strong) NSMutableArray<RKBestPackage *> *yhtx;
@property (nonatomic, strong) NSMutableArray *yykd;
@property (nonatomic, strong) NSMutableArray<commentListModel *> *commentlist;

@property (nonatomic, copy) NSString *usedms;

@end
