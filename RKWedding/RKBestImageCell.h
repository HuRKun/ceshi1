//
//  RKBestImageCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWedding.h"
@interface RKBestImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *default_image;
/**
 *  给RKBestImageCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestWedding *)wedding;
@end
