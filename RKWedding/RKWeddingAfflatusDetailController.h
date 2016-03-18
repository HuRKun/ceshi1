//
//  RKWeddingAfflatusDetailController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/12.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKColorsDetail.h"
@interface RKWeddingAfflatusDetailController : UICollectionViewController

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *act;

@property (nonatomic, strong) RKColorsDetail *model;

@end
