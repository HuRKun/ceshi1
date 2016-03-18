//
//  RKCollectListCell.h
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKCollectListCell : UICollectionViewCell


@property (nonatomic, strong) NSArray *dataList;//!<喜欢列表的信息数据
/**
 *  把数据从ViewController传过来，在Cell里显示
 *
 *  @param data 要显示的数据
 */
- (void)refreshWithData:(NSArray *)data;

@end
