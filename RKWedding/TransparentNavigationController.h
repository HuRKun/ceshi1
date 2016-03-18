//
//  TransparentNavigationController.h
//  
//
//  Created by DancewithPeng on 16/2/22.
//
//

#import <UIKit/UIKit.h>

/**
 *  透明背景的导航控制器
 */
@interface TransparentNavigationController : UINavigationController

@property (nonatomic, strong) UIView *transparentBackgroundView; //!< 透明的背景

@end



/**
 *  封装方便获取透明的背景的View的接口
 */
@interface UINavigationController (Transparent)

@property (nonatomic, readonly) UIView *transparentBackgroundView;

@end


