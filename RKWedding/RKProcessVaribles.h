//
//  RKProcessVaribles.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKProcessNotice.h"
#import "RKProcessForum.h"
#import "RKProcessGroup.h"
#import "RKProcessThreadlist.h"
#import "RKToplist.h"
@interface RKProcessVaribles : JSONModel

@property (nonatomic, copy) NSString *cookiepre;
@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *saltkey;
@property (nonatomic, copy) NSString *member_uid;
@property (nonatomic, copy) NSString *member_username;

@property (nonatomic, copy) NSString *formhash;
@property (nonatomic, strong) RKProcessNotice *notice;
@property (nonatomic, strong) RKProcessForum *forum;
@property (nonatomic, strong) RKProcessGroup *group;
@property (nonatomic, strong) NSMutableArray<RKProcessThreadlist *> *forum_threadlist;

@property (nonatomic, copy) NSString *tpp;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, strong) NSMutableArray<RKToplist *> *toplist;


@end
