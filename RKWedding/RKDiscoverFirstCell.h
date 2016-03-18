//
//  RKDiscoverFirstCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKDiscoverFirstCell;
@protocol RKDiscoverFirstCellDelegate <NSObject>

- (void)cellItemDidClicked:(RKDiscoverFirstCell *)cell itemIndex:(NSInteger)itemIndex;

@end


@interface RKDiscoverFirstCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, weak) id<RKDiscoverFirstCellDelegate> delegate;

/**
 *  把数据从ViewController传过来，在Cell里显示
 *
 *  @param data 要显示的数据
 */
- (void)refreshWithData:(NSArray *)data;

@end
