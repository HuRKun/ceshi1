//
//  RKHeadViewCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKHeadViewCell;
@protocol RKHeadViewCellDelegate <NSObject>

- (void)companyBtnDidTriggerWith:(RKHeadViewCell *)cell;

@end


@interface RKHeadViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *hxjxLabel;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
@property (weak, nonatomic) IBOutlet UIButton *showMoreBrn;

@property (nonatomic, weak) id <RKHeadViewCellDelegate> delegate;

@end
