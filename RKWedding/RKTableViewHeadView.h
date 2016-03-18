//
//  RKTableViewHeadView.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/27.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKTableViewHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIButton *locationCityBtn;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@end
