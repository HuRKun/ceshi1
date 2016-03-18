//
//  RKDiscoverViewController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RKDiscoverViewControllerDelegate <NSObject>

- (void)seletedIndex:(NSInteger)index;

@end

@interface RKDiscoverViewController : UITableViewController

@property (nonatomic, weak) id <RKDiscoverViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *location;//!<选择的城市，默认为全国

@property (nonatomic, copy) NSString *lon;//!< 用户当前所在城市的经度
@property (nonatomic, copy) NSString *lat;//!< 用户当前所在城市的纬度

@end
