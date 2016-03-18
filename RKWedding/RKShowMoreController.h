//
//  RKShowMoreController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKShowMoreController : UICollectionViewController

@property (nonatomic, assign) NSInteger moreBtn;//!< 判断是哪一组的更多按钮，被点击
@property (nonatomic, copy) NSString *act;//!< 数据请求的参数

@property (nonatomic, copy) NSString *type;//!< 数据请求的参数


@end
