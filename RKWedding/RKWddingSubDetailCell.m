//
//  RKWddingSubDetailCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWddingSubDetailCell.h"
#import "RKGlobalDefine.h"
#import "RKWeddingSubDtail2.h"
@implementation RKWddingSubDetailCell

- (void)awakeFromNib {
    
    self.default_imageView.layer.cornerRadius = 8.0f;
    self.default_imageView.clipsToBounds = YES;
    
    self.top_imageView.layer.cornerRadius = 8.0f;
    self.top_imageView.clipsToBounds = YES;
    
    

    
}

-(void)filDataFromCell:(NSArray *)array index:(NSInteger)index
{
    
    RKWeddingSubDtail2 *model = array[index];
    
    self.nameLabel.text = model.hxjx_name;
    self.titleLabel.text = model.title;
    
    [self.default_imageView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
    
    [self.top_imageView sd_setImageWithURL:[NSURL URLWithString:model.top_image]];
    
    self.descriptionLabel.text = model.wdDescription;

    
}
- (IBAction)detailBtnDidClicked:(id)sender {
}
- (IBAction)companyBtnDidClicked:(id)sender {
}

@end
