//
//  RKVideoDeatailCell.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKVideoDeatailCell.h"
#import "RKGlobalDefine.h"

@interface RKVideoDeatailCell ()

@property (nonatomic, copy) NSString *videoUrl;

@end
@implementation RKVideoDeatailCell

- (void)awakeFromNib {
    
    self.nameBtn.layer.cornerRadius = 8.0f;
    self.nameBtn.clipsToBounds = YES;
    
    
    
}
- (IBAction)playBtnDidClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(playBtnDidClickedWithVideoUrl:)]) {
        
        [self.delegate playBtnDidClickedWithVideoUrl:self.videoUrl];
    }
    
}
- (IBAction)nameBtnDidClicked:(id)sender {
}

- (void)configDataForCell:(RKVideoDetailModel *)model NormalHeight:(BOOL)isNormal
{

    self.backgroundColor = [UIColor whiteColor];
    self.videoUrl = model.jxsp_video;
    
    self.descroptionLabel.text = model.wdDescription;

    NSString *title = [NSString stringWithFormat:@"  %@  ",model.team_name];
    [self.nameBtn setTitle:title forState:UIControlStateNormal];
    
    if (isNormal == YES) {
        self.headImageHeight.constant = 186.0f;
        [self.headImageView  sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
//        self.playBtn.hidden = NO;
//        self.playBtn.enabled = YES;
        
    }else{
        self.playBtn.hidden = YES;
        self.playBtn.enabled = NO;
        [self.headImageView  sd_setImageWithURL:[NSURL URLWithString:model.top_image]];
        //计算图片的高度
        //1.得到图片的url
        NSDictionary *dic= [NSString extractWithString:model.default_image];
        NSString *height = [dic valueForKey:@"w"];
        if ([height integerValue] <400) {
            self.headImageHeight.constant = 180.0f;
        }else{
            self.headImageHeight.constant = 540.0f;
        }
    }

}


@end
