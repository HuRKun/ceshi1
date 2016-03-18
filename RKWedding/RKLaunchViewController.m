//
//  RKLaunchViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLaunchViewController.h"

@interface RKLaunchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RKLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageViews= @[@"IMG_0420.jpg",@"IMG_0421.jpg",@"IMG_0422.jpg",@"IMG_0423.jpg",@"IMG_0424.jpg"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i=0; i<imageViews.count; i++) {
        UIImage *image = [UIImage imageNamed:imageViews[i]];
        [images addObject:image];
    }
    self.imageView.animationImages = images;
    self.imageView.animationDuration = 1.5;
    self.imageView.animationRepeatCount = 1;
    
    [self.imageView startAnimating];
    

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
