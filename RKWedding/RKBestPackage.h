//
//  RKBestPackage.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *   优惠套餐 数据模型
 */
@interface RKBestPackage : JSONModel

@property (nonatomic, copy) NSString *yhhd_id;
@property (nonatomic, copy) NSString *yhhd_name;
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *shop_cate_name;
@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *shop_price;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *top_image;
@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *topfile_site;

@property (nonatomic, copy) NSString *default_image_m;

@end
