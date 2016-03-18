//
//  RKBestReusableView.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//


#import <UIKit/UIKit.h>

@class RKNavigationController;
@protocol RKBestReusableViewDelegate <NSObject>
//告诉ChoseViewController 更多的按钮被点击了
- (void)moreButtonDidClickedWithIndex:(UIViewController *)nav index:(NSInteger)index;

@end

@interface RKBestReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (nonatomic, weak) id<RKBestReusableViewDelegate> delegate;




//给外界提供一个接口  设置组头的标题 右边图片
- (void)createHeadViewFor:(NSString *)title image:(NSString *)image;

//设置表头的按钮
- (void)createHeadViewForButtom:(NSString *)title taget:(id)taget indexPath:(NSInteger)index;

//设置组头的标题 
- (void)createHeadViewFor:(NSString *)title;
@end
