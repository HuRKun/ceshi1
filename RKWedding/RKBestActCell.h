//
//  RKBestActCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestLineAct.h"
@interface RKBestActCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *xxhd_name;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *default_image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintTop;


/**
 *  给RKBestActCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestLineAct *)lineAct;
@end
