//
//  RKDiscoverCollectionCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKColorsDetail.h"
@interface RKDiscoverCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

- (void)configDataForCell:(RKColorsDetail *)model;


@end
