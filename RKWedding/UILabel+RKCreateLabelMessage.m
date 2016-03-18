//
//  UILabel+RKCreateLabelMessage.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UILabel+RKCreateLabelMessage.h"

@implementation UILabel (RKCreateLabelMessage)

+ (UILabel *)creareLableViewWithMessage:(NSString *)message
{
    UILabel *hintView = [[UILabel alloc] init];
    hintView.text = message;
    hintView.backgroundColor = [UIColor blackColor];
    hintView.textColor = [UIColor whiteColor];
    hintView.textAlignment = NSTextAlignmentCenter;
    hintView.font = [UIFont systemFontOfSize:13];
    hintView.numberOfLines = 0;
    hintView.layer.cornerRadius = 10.0f;
    hintView.clipsToBounds = YES;
    return hintView;
}


+ (void)creareLableViewWithMessage:(NSString *)message supView:(UIView *)view
{
    UILabel *hintView = [[UILabel alloc] init];
    hintView.text = message;
    hintView.backgroundColor = [UIColor blackColor];
    hintView.textColor = [UIColor whiteColor];
    hintView.textAlignment = NSTextAlignmentCenter;
    hintView.font = [UIFont systemFontOfSize:15];
    hintView.numberOfLines = 0;
    hintView.center = view.center;
    hintView.frame = CGRectMake(0, 0, 100, 50);
    hintView.layer.cornerRadius = 10.0f;
    hintView.clipsToBounds = YES;
    [view addSubview:hintView];
    
    [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(50);
        make.width.mas_greaterThanOrEqualTo(80);
        
    }];
    [view bringSubviewToFront:hintView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hintView removeFromSuperview];
        
    });

}

@end
