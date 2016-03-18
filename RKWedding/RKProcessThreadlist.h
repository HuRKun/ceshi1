//
//  RKProcessThreadlist.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKProcessThreadlist : JSONModel

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *proTypeid;
@property (nonatomic, copy) NSString *readperm;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *lastpost;
@property (nonatomic, copy) NSString *lastposter;
@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *replies;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, copy) NSString *coverpath;
@property (nonatomic, copy) NSString *dbdateline;

@property (nonatomic, copy) NSString *dblastpost;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *marrydate;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *type;

@end
