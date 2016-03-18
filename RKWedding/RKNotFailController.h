//
//  RKNotFailController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RKNotFailControllerDelegate <NSObject>

- (void)againRefreshData;

@end

@interface RKNotFailController : UIViewController

@property (nonatomic, weak) id <RKNotFailControllerDelegate> delegaet;


- (void)showMessage;

@end
