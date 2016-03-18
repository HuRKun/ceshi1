//
//  RKTexthtmlController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKTexthtmlController.h"

@interface RKTexthtmlController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RKTexthtmlController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"隐私政策";
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content2" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
