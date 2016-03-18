//
//  RKWeddingSubDtail.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  婚礼专题详情页数据模型
 */
@interface RKWeddingSubDtail : JSONModel

@property (nonatomic, copy) NSString *hlzt_name;
@property (nonatomic, copy) NSString *wdDescription;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *file_site;
@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *hlzt_id;
@property (nonatomic, copy) NSString *default_image_m;




@end
