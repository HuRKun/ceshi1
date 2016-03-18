//
//  RKWeddingSubDtail2.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKWeddingSubDtail2 : JSONModel

@property (nonatomic, copy) NSString *hxjx_id;
@property (nonatomic, copy) NSString *hxjx_name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *wdDescription;
@property (nonatomic, copy) NSString *company_id;

@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *team_id;
@property (nonatomic, copy) NSString *team_name;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *top_image;

@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *topfile_site;
@property (nonatomic, copy) NSString *default_image_m;
@property (nonatomic, copy) NSString *top_image_m;
@end
