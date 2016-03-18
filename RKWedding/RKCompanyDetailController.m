//
//  RKCompanyDetailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/6.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCompanyDetailController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"

#import "RKCompanyRoot.h"
#import "commentListModel.h"

#import "RKCompanyWDALCell.h"
#import "RKWDCompanyDetailTopCell.h"
#import "RKCompanyWDSPCell.h"
#import "RKBestParpareCell.h"
#import "RKCompanyCommetCell.h"
#import "RKBestReusableView.h"

#define kRKBestReusableView @"RKBestReusableView"
#define kRKCompanyCommetCell @"RKCompanyCommetCell"
#define kRKCompanyWDALCell @"RKCompanyWDALCell"
#define kRKWDCompanyDetailTopCell @"RKWDCompanyDetailTopCell"
#define kRKCompanyWDSPCell @"RKCompanyWDSPCell"
#define kRKBestParpareCell @"RKBestParpareCell"
@interface RKCompanyDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;//!<数据源
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;//!<任务管理器

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RKCompanyDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self editNavigationItem];
    
    [self.hud show:YES];
    
    [self fetchDataFromServer];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCompanyWDALCell bundle:nil] forCellWithReuseIdentifier:kRKCompanyWDALCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKWDCompanyDetailTopCell bundle:nil] forCellWithReuseIdentifier:kRKWDCompanyDetailTopCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCompanyWDSPCell bundle:nil] forCellWithReuseIdentifier:kRKCompanyWDSPCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKBestParpareCell bundle:nil] forCellWithReuseIdentifier:kRKBestParpareCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCompanyCommetCell bundle:nil] forCellWithReuseIdentifier:kRKCompanyCommetCell];
    
    //注册段头
    [self.collectionView registerNib:[UINib nibWithNibName:kRKBestReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
#pragma mark - other
// 设置导航栏的内容
- (void) editNavigationItem
{
    UIBarButtonItem *backBBI = [UIBarButtonItem createNormalBackBarButtomItemWithTaget:self action:@selector(backBBIDidClicked) CGRect:CGRectMake(0, 0, 10, 16)];
    self.navigationItem.leftBarButtonItem = backBBI;
    UIBarButtonItem *shareBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_be_share"] taget:self action:@selector(shareBBIDidClicked) CGRect:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem *fixedBBI = [UIBarButtonItem createFixedBackBarButtomItemWithWidth:15];
    UIBarButtonItem *likeBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_dis_listlike_n@3x"] taget:self action:@selector(likeBBIDidClicked) CGRect:CGRectMake(0, 0, 18, 16)];
    self.navigationItem.rightBarButtonItems = @[likeBBI,fixedBBI,shareBBI];
}
//返回  被点击
- (void)backBBIDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//喜欢  被点击
- (void)likeBBIDidClicked
{
    //如果没有登陆要跳到登陆界面
}
//分享  被点击
- (void)shareBBIDidClicked
{
    RKShareViewController *vc = [[RKShareViewController alloc] initWithNibName:@"RKShareViewController" bundle:nil];
    NSLog(@"%@",NSStringFromCGRect(vc.view.bounds));
    [self.navigationController rk_addChildViewController:vc inRect:kScreenBounds];
}

#pragma mark - 数据请求

- (void)fetchDataFromServer
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.dataTask = [manager GET:COMPANY parameters:@{@"company": self.company} success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if ([dic[@"company"][@"description"] isKindOfClass:[NSNull class]]) {
            [dic setObject:@"null"forKey:dic[@"company"][@"description"]];
        }
        NSError *error = nil;
        RKCompanyRoot *root = [[RKCompanyRoot alloc] initWithDictionary:dic error:&error];
        if (error == nil) {
            [self.dataSource addObject:root];
        }else{
            NSLog(@"%@",error);
            
        }
        [self.hud hide:YES afterDelay:1.35];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
      
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
        
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    RKCompanyRoot *root = [self.dataSource firstObject];
    NSInteger jxal = [root.company.jxal_num integerValue];
    NSInteger spal = [root.company.spal_num integerValue];
    NSInteger comment = [root.company.comments integerValue];
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (jxal>4) {
            return 4;
        }else {
            return jxal;
        }
    }else if (section == 2){
        if (spal>4) {
            return 4;
        }else{
            return spal;
        }
    }else{
        return comment;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKWDCompanyDetailTopCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKWDCompanyDetailTopCell forIndexPath:indexPath];
    RKCompanyWDALCell *alCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCompanyWDALCell forIndexPath:indexPath];
    RKCompanyWDSPCell *spCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCompanyWDSPCell  forIndexPath:indexPath];
    RKCompanyCommetCell *comCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCompanyCommetCell forIndexPath:indexPath];
    RKCompanyRoot *root = [self.dataSource firstObject];
    if (indexPath.section == 0) {
        
        RKCompanyDetailTop *top = root.company;
        [topCell configeDataForCell:top];
        
        return topCell;
    }else if(indexPath.section == 1){
        
        NSArray *arr = root.jxal;
        RKCompanyJxal *model = arr[indexPath.row];
        [alCell configeDataForCell:model];
        return alCell;
        
    }
    else if (indexPath.section == 2){
        
        NSArray *arr = root.spal;
        RKCompanyJxal *model = arr[indexPath.row];
        [spCell configeDataForCell:model];
        
        return spCell;
    }else{
        
        NSArray *arr = root.commentlist;
        commentListModel *model = arr[indexPath.row];
        [comCell configeDataForCell:model];
        return comCell;
    }
    

}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 350);
    }else if (indexPath.section == 1 || indexPath.section == 2){
        return CGSizeMake((kScreenWidth - 30)/2, (kScreenWidth - 30)/2);
    }else{
        
        return CGSizeMake(kScreenWidth - 20 , 93);
    }

}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else{
        return CGSizeMake(kScreenWidth, 35);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RKBestReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView forIndexPath:indexPath];
    RKCompanyRoot *root = [self.dataSource firstObject];
    RKCompanyDetailTop *top = root.company;
    if (indexPath.section == 1) {
        headView.titleLabel.text = @"婚礼案例";
        NSString *content = [NSString stringWithFormat:@"全部%@个案例",top.jxal_num];
        [headView.rightBtn setTitle:content forState:UIControlStateNormal];
        return headView;
    }else if (indexPath.section == 2){
        headView.titleLabel.text = @"婚礼视频";
        NSString *content = [NSString stringWithFormat:@"全部%@个视频",top.spal_num];
        [headView.rightBtn setTitle:content forState:UIControlStateNormal];
        return headView;
    }else if (indexPath.section == 3){
        headView.titleLabel.text = @"网友点评";
        NSString *content = [NSString stringWithFormat:@"全部%@条评论",top.comments];
        [headView.rightBtn setTitle:content forState:UIControlStateNormal];
        return headView;
    }else{
        return nil;
    }
    return headView;
}
#pragma mark <UICollectionViewDelegate>

#pragma mark - Setter & Getter
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (MBProgressHUD *)hud
{
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.opacity = 0.4;
        _hud.labelText = @"loading";
        _hud.animationType = MBProgressHUDAnimationZoomIn;
    
    }
    return _hud;
}
@end
