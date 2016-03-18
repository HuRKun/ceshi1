//
//  RKDiscoverTeam.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/11.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKDiscoverTeam : JSONModel

@property (nonatomic, copy) NSString *team_id;
@property (nonatomic, copy) NSString *team_name;
@property (nonatomic, copy) NSString *region_name;
@property (nonatomic, copy) NSString *cate_name;

@property (nonatomic, copy) NSString *tel_1;
@property (nonatomic, copy) NSString *tel_2;
@property (nonatomic, copy) NSString *tel_3;
@property (nonatomic, copy) NSString *tel_4;
@property (nonatomic, copy) NSString *belong_company;

@property (nonatomic, copy) NSString *price_person;
@property (nonatomic, copy) NSString *price_team;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *product_num;

@property (nonatomic, copy) NSString *yykd_num;
@property (nonatomic, copy) NSString *rgrade;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *collects;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *region_id_1;
@property (nonatomic, copy) NSString *default_image_m;


@end
