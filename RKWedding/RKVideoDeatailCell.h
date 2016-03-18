//
//  RKVideoDeatailCell.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKVideoDetailModel.h"

@protocol RKVideoDeatailCellDelegate <NSObject>

- (void)playBtnDidClickedWithVideoUrl:(NSString *)url;

@end

@interface RKVideoDeatailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *descroptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageHeight;


@property (nonatomic, weak) id<RKVideoDeatailCellDelegate > delegate;

- (void)configDataForCell:(RKVideoDetailModel *)model NormalHeight:(BOOL)isNormal;


@end


