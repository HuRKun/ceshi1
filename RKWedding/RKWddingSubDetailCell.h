//
//  RKWddingSubDetailCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKWeddingSubDtail2;
@interface RKWddingSubDetailCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraintHeight;//!< 上部分View的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midViewConstraintHeight;//!< 中部View的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraintHeight;//!< 尾部View的高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionLabelHeight;//!< 文字描述Label的高度
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *default_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *top_imageView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

- (void)filDataFromCell:(NSArray *)array index:(NSInteger)index;

@end
