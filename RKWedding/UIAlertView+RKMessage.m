//
//  UIAlertView+RKMessage.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/12.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UIAlertView+RKMessage.h"

@implementation UIAlertView (RKMessage)

+ (void)alertWithMessage:(NSString *)message title:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:1 animated:YES];
    });
}
@end
