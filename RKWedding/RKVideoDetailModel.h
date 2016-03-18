//
//  RKVideoDetailModel.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "JSONModel.h"

/**
 *  婚礼精选视频的数据模型
 */
@interface RKVideoDetailModel : JSONModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *hxjx_name;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hotel_id;

@property (nonatomic, copy) NSString *hotel_name;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *team_id;
@property (nonatomic, copy) NSString *team_name;

@property (nonatomic, copy) NSString *jxsp_date;
@property (nonatomic, copy) NSString *jxsp_video;
@property (nonatomic, copy) NSString *jxsp_duration;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *top_image;

@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *topfile_site;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *collects;
@property (nonatomic, copy) NSString *wdDescription;
@property (nonatomic, copy) NSString *hxjx_id;
@property (nonatomic, copy) NSString *default_image_m;
@property (nonatomic, copy) NSString *hotel_level_id;

@property (nonatomic, copy) NSString *hotel_level_name;
@property (nonatomic, copy) NSString *company_cate_id;
@property (nonatomic, copy) NSString *company_cate_name;
@property (nonatomic, copy) NSString *team_cate_id;
@property (nonatomic, copy) NSString *team_cate_name;

@property (nonatomic, copy) NSString *collected;


@end
