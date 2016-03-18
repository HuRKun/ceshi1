//
//  RKWeddingDetailController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWedding.h"
@interface RKWeddingDetailController : UIViewController

@property (nonatomic, strong) RKBestWedding *model;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@interface WeddingModel : JSONModel

@end