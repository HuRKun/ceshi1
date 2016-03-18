//
//  RKBestWedding.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  精选婚礼/图片/视频类 数据模型
 */
@interface RKBestWedding : JSONModel

@property (nonatomic, copy) NSString *hxjx_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *hxjx_name;
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
@property (nonatomic, copy) NSString *default_image_m;
@property (nonatomic, copy) NSString *top_image_m;

@end
