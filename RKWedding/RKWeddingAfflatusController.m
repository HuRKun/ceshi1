//
//  RKWeddingAfflatusController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/4.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingAfflatusController.h"
#import "RKWeddingAfflatusDetailController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "RKColors.h"

#import "RKBestReusableView.h"
#import "RKDiscoverCollectionCell.h"

#define kRKBestReusableView @"RKBestReusableView"
#define kRKDiscoverCollectionCell @"RKDiscoverCollectionCell"
@interface RKWeddingAfflatusController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;//!<任务管理器
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation RKWeddingAfflatusController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchDataFromServer];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKDiscoverCollectionCell bundle:nil] forCellWithReuseIdentifier:kRKDiscoverCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKBestReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView];
    

}

- (void)fetchDataFromServer
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramsters = @{@"act":@"lgsccolors",
                                 @"cate":@(self.number)};
   self.dataTask = [manager POST:API parameters:paramsters success:^(NSURLSessionDataTask * task, id responseObject) {
       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       NSArray *arr = dic[@"colors"];
       
       for (NSDictionary *dis in arr) {
           NSError *error = nil;
           RKColors *color = [[RKColors alloc] initWithDictionary:dis error:&error];
           if (error == nil) {
               [self.dataSource addObject:color];
           }
       }
       [self.collectionView reloadData];
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
      [UIView animateWithDuration:1 animations:^{
          [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
      }];
   }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.dataSource.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    RKColors *color = self.dataSource[section];
    
    return color.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RKDiscoverCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKDiscoverCollectionCell forIndexPath:indexPath];
    
    RKColors *color = self.dataSource[indexPath.section];
    RKColorsDetail *model = color.list[indexPath.row];
    [cell configDataForCell:model];
    
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置段头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RKBestReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView forIndexPath:indexPath];
    RKColors *color = self.dataSource[indexPath.section];
    [headView createHeadViewFor:color.name];
    
    return headView;
}

//设置组头的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 35);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-30) /2, (kScreenWidth-30) /2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKWeddingAfflatusDetailController *vc = [[RKWeddingAfflatusDetailController alloc] initWithNibName:@"RKWeddingAfflatusDetailController" bundle:nil];
    if (indexPath.section == 0) {
        RKColors *color = self.dataSource[indexPath.section];
        RKColorsDetail *model = color.list[indexPath.row];
        vc.model = model;
        vc.cate = model.cate;
        vc.index = indexPath.row;
        
    }else{
        
        RKColors *color = self.dataSource[indexPath.section-1];
        NSInteger number = color.list.count + indexPath.row;
        RKColorsDetail *model = color.list[indexPath.row];
        vc.model = model;
        vc.cate = model.cate;
        vc.index = number;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Setter & Getter
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
