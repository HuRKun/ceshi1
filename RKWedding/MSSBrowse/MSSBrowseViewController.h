//
//  MSSBrowseViewController.h
//  MSSBrowse
//
//  Created by 于威 on 15/12/23.
//  Copyright © 2015年 于威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSBrowseCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+MSSScale.h"
#import "MSSBrowseDefine.h"
#import "MSSBrowseRemindView.h"
#import "MSSBrowseActionSheet.h"
@interface MSSBrowseViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate>

- (instancetype)initWithBrowseItemArray:(NSArray *)browseItemArray currentIndex:(NSInteger)currentIndex;

- (void)showBrowseViewController;

@end
