//
//  RKBestReusableView.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestReusableView.h"
#import "RKShowMoreController.h"
#import "RKNavigationController.h"
@implementation RKBestReusableView

- (void)awakeFromNib {

    self.leftView.layer.cornerRadius = 2.2f;
    self.leftView.clipsToBounds = YES;
    
    
}
- (IBAction)rigthBtnDidClicked:(id)sender {
}

-(void)createHeadViewFor:(NSString *)title image:(NSString *)image
{
    self.titleLabel.text = title;
    self.rightImage.image = [UIImage imageNamed:image];
}

-(void)createHeadViewForButtom:(NSString *)title taget:(id)taget  indexPath:(NSInteger)index
{
    [self.rightBtn setTitle:title forState:UIControlStateNormal];

    [self.rightBtn addTarget:taget action:@selector(moreBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightBtn setTag:index];
}

- (void)createHeadViewFor:(NSString *)title
{
    self.titleLabel.text = title;
    self.rightImage.hidden = YES;
    self.rightBtn.hidden = YES;
    self.rightBtn.enabled = NO;
}
@end
