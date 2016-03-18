//
//  RKBestSubjectCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKBestWDSubject.h"
#import "RKBestWDSubject.h"
@interface RKBestSubjectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *wdDescription;
@property (weak, nonatomic) IBOutlet UIImageView *default_image;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgImageViewHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultImageHeight;


/**
 *  给RKBestSubjectCell填充数据
 *
 *  @param wedding 数据模型
 */
- (void)fillDataForCell:(RKBestWDSubject*)subject;

@end
