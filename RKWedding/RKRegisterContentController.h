//
//  RKRegisterContentController.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/29.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef  (NSString *)(^TansinformationBlock)();

@protocol RKRegisterContentControllerDelegate <NSObject>

- (void)resendButtomDidClicked;

@end

@interface RKRegisterContentController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *password2TextField;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

@property (nonatomic, assign) NSInteger phoneNum;//!<从上一界面传过来的电话号码

@property (nonatomic, weak) id <RKRegisterContentControllerDelegate> delegate;

@end
