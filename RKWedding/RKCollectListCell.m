//
//  RKCollectListCell.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCollectListCell.h"
#import "RKCollectHeadImageCell.h"
#import "RKGlobalDefine.h"
#import "collectListModel.h"

#define kRKCollectHeadImageCell @"RKCollectHeadImageCell"
@interface RKCollectListCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end


@implementation RKCollectListCell

- (void)awakeFromNib {
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCollectHeadImageCell bundle:nil] forCellWithReuseIdentifier:kRKCollectHeadImageCell];
    
}

-(void)refreshWithData:(NSArray *)data
{
    self.dataList = data;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource(数据源代理)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKCollectHeadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCollectHeadImageCell forIndexPath:indexPath];
    if (indexPath.row == 0) {
       
        cell.headImageView.image = [UIImage imageNamed:@"btn_be_likebig"];
    }else{
    collectListModel *model = self.dataList[indexPath.row - 1];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       // 如果用户没登陆 ，需跳到登陆界面
    }
}
#pragma mark - 懒加载

- (NSArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [[NSArray alloc] init];
    }
    return _dataList;
}
@end
