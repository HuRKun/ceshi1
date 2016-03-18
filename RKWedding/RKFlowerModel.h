//
//  RKFlowerModel.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/12.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKFlowerModel : JSONModel

@property (nonatomic, copy) NSString *lgsc_id;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *photoby;
@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *image_url_m;
@property (nonatomic, copy) NSString *default_image_m;

@end
