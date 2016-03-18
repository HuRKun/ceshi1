//
//  RKBestWDSubject.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
/**
 *  精选婚礼专题 数据模型
 */
@interface RKBestWDSubject : JSONModel

@property (nonatomic, copy) NSString *hlzt_id;
@property (nonatomic, copy) NSString *hlzt_name;
@property (nonatomic, copy) NSString *ztDescription;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *file_site;

@property (nonatomic, copy) NSString *default_image_m;


@end
