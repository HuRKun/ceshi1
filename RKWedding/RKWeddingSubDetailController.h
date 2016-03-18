//
//  RKWeddingSubDetailController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWDSubject.h"
#import "RKHeadImageModel.h"
@interface RKWeddingSubDetailController : UICollectionViewController

@property (nonatomic, strong) RKBestWDSubject *model;//!< 精选婚礼专题数据模型

@property (nonatomic, strong) RKHeadImageModel *bannerModel;//!< 广告栏数据模型

@property (nonatomic, assign) BOOL isBanner;
@end
