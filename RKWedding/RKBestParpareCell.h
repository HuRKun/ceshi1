//
//  RKBestParpareCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestPackage.h"
@interface RKBestParpareCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *default_image;
@property (weak, nonatomic) IBOutlet UILabel *yhhd_name;
@property (weak, nonatomic) IBOutlet UILabel *shop_cate_name;
@property (weak, nonatomic) IBOutlet UILabel *market_price;
@property (weak, nonatomic) IBOutlet UILabel *shop_price;
/**
 *  给RKBestParpareCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestPackage *)parpare;

@end
