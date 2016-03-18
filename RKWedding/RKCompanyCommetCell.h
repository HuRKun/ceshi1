//
//  RKCompanyCommetCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentListModel.h"
@interface RKCompanyCommetCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *score0;
@property (weak, nonatomic) IBOutlet UIImageView *score1;
@property (weak, nonatomic) IBOutlet UIImageView *score2;

@property (weak, nonatomic) IBOutlet UIImageView *score3;
@property (weak, nonatomic) IBOutlet UIImageView *score4;

@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;



- (void)configeDataForCell:(commentListModel *)model;


@end
