//
//  RKTransparentNavigationController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKTransparentNavigationController : UINavigationController

@property (nonatomic, strong) UIView *transparentBackgroundView; //!< 透明的背景

@end



///**
// *  封装方便获取透明的背景的View的接口
// */
//@interface UINavigationController (Transparent)
//
//@property (nonatomic, readonly) UIView *transparentBackgroundView;

//@end