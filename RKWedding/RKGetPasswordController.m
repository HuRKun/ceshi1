//
//  RKGetPasswordController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKGetPasswordController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
@interface RKGetPasswordController ()
@property (weak, nonatomic) IBOutlet UIButton *nextPassBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation RKGetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backBBI = [UIBarButtonItem createArrowBackBarButtomItemWithTaget:self action:@selector(backBBIDidClick:) CGRect:CGRectMake(0, 0, 24, 13)];
    self.navigationItem.title = @"找回密码";
    
    self.navigationItem.leftBarButtonItem = backBBI;
    self.nextPassBtn.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBBIDidClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
