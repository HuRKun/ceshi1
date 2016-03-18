//
//  RKToplist.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKToplist : JSONModel

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *views;

@end
