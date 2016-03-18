//
//  RKCompanyWDSPCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKCompanyJxal.h"
@interface RKCompanyWDSPCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)configeDataForCell:(RKCompanyJxal *)model;

@end
