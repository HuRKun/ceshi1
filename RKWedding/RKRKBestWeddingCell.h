//
//  RKRKBestWeddingCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWedding.h"
@interface RKRKBestWeddingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *default_image;
@property (weak, nonatomic) IBOutlet UILabel *company_name;
@property (weak, nonatomic) IBOutlet UILabel *cate_name;
@property (weak, nonatomic) IBOutlet UILabel *views;
@property (weak, nonatomic) IBOutlet UILabel *points;
/**
 *  给RKRKBestWeddingCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestWedding *)wedding;

@end
