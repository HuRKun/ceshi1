//
//  RKBestVideoCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWedding.h"
@interface RKBestVideoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *default_image;
@property (weak, nonatomic) IBOutlet UILabel *hxjx_name;

@property (weak, nonatomic) IBOutlet UILabel *jxsp_date;

@property (weak, nonatomic) IBOutlet UILabel *team_name;
@property (weak, nonatomic) IBOutlet UILabel *jxsp_duration;
@property (weak, nonatomic) IBOutlet UILabel *views;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

/**
 *  给RKBestVideoCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestWedding *)wedding;

@end
