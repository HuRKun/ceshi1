//
//  RKWDCompanyDetailTopCell.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKCompanyDetailTop.h"

@interface RKWDCompanyDetailTopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView0;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView4;
@property (weak, nonatomic) IBOutlet UIButton *plNumberBtn;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyDesciptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *storeView;

-(void)configeDataForCell:(RKCompanyDetailTop *)model;

@end
