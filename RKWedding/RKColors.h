//
//  RKColors.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKColorsDetail.h"
/**
 *  婚礼灵感详情页数据模型
 */
@interface RKColors : JSONModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSMutableArray <RKColorsDetail *> *list;


@end
