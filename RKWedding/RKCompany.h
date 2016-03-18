//
//  RKCompany.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKCompany : NSObject

@property (nonatomic, assign) NSInteger cate_id;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic, assign) NSInteger sort_order;

@end
