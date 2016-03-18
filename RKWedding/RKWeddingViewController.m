//
//  RKWeddingViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingViewController.h"
#import "RKGlobalDefine.h"
#import "RKWeddingProcessController.h"
#import "RKDiscussController.h"
#import "UIViewController+RKViewController.h"
@interface RKWeddingViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UISegmentedControl *segController;


@end

@implementation RKWeddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    self.navigationItem.titleView = self.segController;
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - other MOthor
- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * sender.selectedSegmentIndex, -64) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.segController.selectedSegmentIndex = page;
}
#pragma mark - Setter & Getter
- (UISegmentedControl *)segController
{
    if (_segController == nil) {
        NSArray *arr = @[@"婚礼全程",@"讨论小组"];
        _segController = [[UISegmentedControl alloc] initWithItems:arr];
        _segController.center = CGPointMake(kScreenWidth/2.0f, self.navigationController.navigationBar.frame.size.height/2.0f);
        _segController.frame = CGRectMake(0, 0, 160, 30);
        _segController.selectedSegmentIndex = 1;
        [_segController addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segController;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -49)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        // 添加两个ViewController（婚礼全程和讨论小组）
        
        //添加两个内容控制器
        RKWeddingProcessController *proVC = [[RKWeddingProcessController alloc] initWithNibName:@"RKWeddingProcessController" bundle:nil];
        RKDiscussController *discussVC = [[RKDiscussController alloc] initWithNibName:@"RKDiscussController" bundle:nil];
        
        [self addChildViewController:proVC];
        [self addChildViewController:discussVC];
        // 设置x的偏移量
        proVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49);
         discussVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-64-49);
        //（婚礼全程和讨论小组）的view添加到_scrollView上显示
        
        [_scrollView addSubview:discussVC.view];
        [_scrollView addSubview:proVC.view];

    }
    return _scrollView;
}


@end
