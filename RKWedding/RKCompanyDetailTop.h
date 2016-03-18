//
//  RKCompanyDetailTop.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKImage.h"
/**
 *  婚礼公司简介数据模型
 */
@interface RKCompanyDetailTop : JSONModel

@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *region_name;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *tel_1;
@property (nonatomic, copy) NSString *tel_2;
@property (nonatomic, copy) NSString *tel_3;
@property (nonatomic, copy) NSString *tel_4;
@property (nonatomic, copy) NSString *website;

@property (nonatomic, copy) NSString *weibo_name;
@property (nonatomic, copy) NSString *weibo_site;
@property (nonatomic, copy) NSString *weixin_no;
@property (nonatomic, copy) NSString *hours_start;
@property (nonatomic, copy) NSString *hours_type;

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *yhhd_num;
@property (nonatomic, copy) NSString *fwtx_num;
@property (nonatomic, copy) NSString *jxsp_num;

@property (nonatomic, copy) NSString *jxal_num;
@property (nonatomic, copy) NSString *spal_num;
@property (nonatomic, copy) NSString *yhtx_num;
@property (nonatomic, copy) NSString *yykd_num;
@property (nonatomic, copy) NSString *rgrade;

@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *top_image;
@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *topfile_site;
@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *collects;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *comment_score;
@property (nonatomic, copy) NSString *comment_amount;

@property (nonatomic, copy) NSString *base_amount;
@property (nonatomic, copy) NSString *region_id_1;
@property (nonatomic, copy) NSString *wdDescription;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *default_image_m;

@property (nonatomic, copy) NSString *top_image_m;
@property (nonatomic, copy) NSString *collected;
@property (nonatomic, copy) NSString *logo_image;
@property (nonatomic, strong) NSMutableArray<RKImage *> *_images;

@end


