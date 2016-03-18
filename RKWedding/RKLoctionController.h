//
//  RKLoctionController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/25.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RKLoctionControllerDelegate <NSObject>

- (void)locationAddress:(NSString *)address;

@end

@interface RKLoctionController : UITableViewController

@property (nonatomic, weak) id <RKLoctionControllerDelegate> delegate;

@property (nonatomic, copy) NSString *city;

@end
