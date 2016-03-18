//
//  RKHeadImageModel.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//精选 广告栏模型数据
@interface RKHeadImageModel : JSONModel

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *region_code;
@property (nonatomic, copy) NSString *item_type;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *item_url;
@property (nonatomic, copy) NSString *banner_logo;
@property (nonatomic, copy) NSString *banner_id;

@end
