//
//  RKCompanyJxal.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  婚礼公司婚礼案例数据模型
 */
@interface RKCompanyJxal : JSONModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *product_name;
@property (nonatomic, copy) NSString *product_price;
@property (nonatomic, copy) NSString *product_date;
@property (nonatomic, copy) NSString *product_video;

@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *default_image_m;
@property (nonatomic, copy) NSString *shop;


@end
