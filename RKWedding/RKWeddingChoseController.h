//
//  RKWeddingChoseController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/5.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKWeddingChoseController : UIViewController

@property (nonatomic, copy) NSString *level;

@property (nonatomic, assign) NSInteger session;

@property (nonatomic, assign) NSInteger region;//!< 城市编号

@property (nonatomic, copy) NSString *act;//!< 数据请求参数

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *info;

@end
