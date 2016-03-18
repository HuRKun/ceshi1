//
//  RKUserGuideViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKUserGuideViewController.h"
#import "RKRootViewController.h"
@interface RKUserGuideViewController ()

@end

@implementation RKUserGuideViewController
{
    UIScrollView *sv;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLaunchViewController];
    
}
- (void)showLaunchViewController
{
    sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.pagingEnabled = YES;
    //    sv.delegate = self;
    sv.bounces = NO;
    [self.view addSubview:sv];
    
    // 引导图的图片
    NSArray *images = @[@"new_feature_1",
                        @"new_feature_2",
                        @"new_feature_3",
                        @"new_feature_4",
                        @"new_feature_5"];
    
    for (int i = 0; i < images.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(sv.bounds.size.width*i,0,sv.bounds.size.width,sv.bounds.size.height)];
        imgView.image = [UIImage imageNamed:images[i]];
        [sv addSubview:imgView];
    }
    
    // 设置滚动区域
    sv.contentSize = CGSizeMake(sv.bounds.size.width * images.count, sv.bounds.size.height);
    
    // 进入主界面
    UIButton *entryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    entryBtn.frame = CGRectMake(sv.bounds.size.width*(images.count-1), sv.bounds.size.height-180, sv.bounds.size.width, 80);
    [entryBtn addTarget:self action:@selector(entryRootViewController) forControlEvents:UIControlEventTouchUpInside];
    [sv addSubview:entryBtn];
}

- (void)entryRootViewController
{
    [UIView animateWithDuration:1.25 animations:^{
        
        sv.alpha = 0;
        sv.transform = CGAffineTransformScale(sv.transform, 2, 2);
        
    } completion:^(BOOL finished) {
        
        RKRootViewController *root = [[RKRootViewController alloc] init];
        [UIApplication sharedApplication].delegate.window.rootViewController = root;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
