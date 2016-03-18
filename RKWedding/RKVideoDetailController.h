//
//  RKVideoDetailController.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWedding.h"
@interface RKVideoDetailController : UICollectionViewController

@property (nonatomic, strong) RKBestWedding *model;

@property (nonatomic, assign) BOOL isVideo;

@end
