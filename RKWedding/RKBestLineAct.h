//
//  RKBestLineAct.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  线下活动 数据模型
 */
@interface RKBestLineAct : JSONModel

@property (nonatomic, copy) NSString *xxhd_id;
@property (nonatomic, copy) NSString *xxhd_name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *default_image_m;

@end
