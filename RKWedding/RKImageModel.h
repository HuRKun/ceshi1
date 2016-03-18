//
//  RKImageModel.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RKImageModel : JSONModel
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *is_logo;
@property (nonatomic, copy) NSString *file_site;

@property (nonatomic, copy) NSString *image_id;

@property (nonatomic, copy) NSString *image_url_m;
@end
