//
//  RKColorsDetail.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKColorsDetail.h"

@interface RKColorsDetail : JSONModel



@property (nonatomic, copy) NSString *cate;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *color_name;
@property (nonatomic, copy) NSString *color_logo;
@property (nonatomic, copy) NSString *count;

@end
