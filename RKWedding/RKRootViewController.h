//
//  RKRootViewController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RKRootViewControllerDelegate <NSObject>

- (void)locationWithlon:(NSString *)lon lat:(NSString *)lat;

@end

@interface RKRootViewController : UIViewController

@property (nonatomic, weak)id<RKRootViewControllerDelegate> delegate;

@end


