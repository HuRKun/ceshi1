//
//  RKShareViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/27.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKShareViewController.h"
#import "RKGlobalDefine.h"
@interface RKShareViewController ()




@end

@implementation RKShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelDidClick:(id)sender {
    
    [UIView animateWithDuration:3 animations:^{
        
        [self.view removeFromSuperview];
        [self willMoveToParentViewController:nil];
        [self removeFromParentViewController];
    }];
}
- (IBAction)weixinDidClick:(id)sender {
    
}
- (IBAction)weiboDidClick:(id)sender {
}

- (IBAction)pengyouquanDidClick:(id)sender {
}

//该手势是添加到bgView上的

- (IBAction)tapDidClick:(id)sender {
    
    [UIView animateWithDuration:3 animations:^{
        
        [self.view removeFromSuperview];
        [self willMoveToParentViewController:nil];
        [self removeFromParentViewController];
    }];
}

@end
