//
//  RKGlobalDefine.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#ifndef RKGlobalDefine_h
#define RKGlobalDefine_h

//屏幕尺寸
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth  (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

//第三方库
#import <SDWebImage/UIImageView+WebCache.h>
#import "GGBannerView.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <UMSocial.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "MSSBrowseViewController.h"

#import "RKChoseViewController.h"
#import "RKShowMoreController.h"
#import "RKNavigationController.h"
#import "RKTransparentNavigationController.h"
#import "RKNomalNavigationController.h"
#import "TransparentNavigationController.h"

//分享界面
#import "RKShareViewController.h"
//定制cell
#import "RKRKBestWeddingCell.h"
#import "RKBestImageCell.h"
#import "RKBestVideoCell.h"
#import "RKBestSubjectCell.h"
#import "RKBestParpareCell.h"
#import "RKBestActCell.h"

#import "RKBestReusableView.h"

//精选六个详情页
#import "RKWeddingDetailController.h"
#import "RKLineActDetailController.h"
#import "RKWeddingSubDetailController.h"
#import "RKVideoDetailController.h"

//模型
#import "RKBestWedding.h"
#import "RKBestWDSubject.h"
#import "RKBestPackage.h"
#import "RKBestLineAct.h"
#import "RKHeadImageModel.h"



//cell 复用ID
#define kRKBestWeddingCell @"RKBestWeddingCell"
#define kRKBestImageCell @"RKBestImageCell"
#define kRKBestVideoCell @"RKBestVideoCell"
#define kRKBestWDSubjectCell @"RKBestWDSubjectCell"
#define kRKBestParpareCell @"RKBestParpareCell"
#define kRKBestActCell @"RKBestActCell"
#define kRKBestReusableView @"RKBestReusableView"

//工具类
#import "UIBarButtonItem+RKCustomBBI.h"
#import "UIViewController+RKViewController.h"
#import "UILabel+LabelHeight.h"
#import "NSString+RKExtractString.h"
#import "UILabel+RKCreateLabelMessage.h"
#import "UIAlertView+RKMessage.h"


//网络连接错误提示控制器
#import "RKNotFailController.h"

//模糊的第三方分享界面
#import "RKShareViewController.h"

//软件本地数据模型
#import "RKCity.h"
#import "RKPeople.h"
#import "RKCompany.h"
#import "RKAdcode.h"
#import "RKFindView.h"
#import "RKHotelLevel.h"
#import "RKLuckyDayModel.h"
#import "RKFirstViewInfoList.h"

//单例
#import "RKLocationCity.h"
#import "RKLoginManager.h"
#import "RKUserManager.h"

#endif /* RKGlobalDefine_h */


