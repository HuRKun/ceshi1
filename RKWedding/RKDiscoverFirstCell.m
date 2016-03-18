//
//  RKDiscoverFirstCell.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDiscoverFirstCell.h"
#import "RKDiscoverCollectionCell.h"
#import "RKGlobalDefine.h"

#define kRKDiscoverCollectionCell @"RKDiscoverCollectionCell"
@interface RKDiscoverFirstCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataSource;//!<婚礼服务数据源

@end

@implementation RKDiscoverFirstCell


- (void)awakeFromNib {
    
    //设置tableviewcell 为collectionView的代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // 注册 collectionViewCell
    [self.collectionView registerNib:[UINib nibWithNibName:kRKDiscoverCollectionCell bundle:nil] forCellWithReuseIdentifier:kRKDiscoverCollectionCell];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)refreshWithData:(NSArray *)data
{
    self.dataSource = data;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource(数据源代理)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKDiscoverCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKDiscoverCollectionCell forIndexPath:indexPath];
    NSDictionary *dic = self.dataSource[indexPath.item];
    NSString *imagename = dic[@"imagename"];
    cell.headImageView.image = [UIImage imageNamed:imagename];

    cell.numLabel.text = dic[@"num"];
    cell.titleLabel.text = dic[@"name"];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cellItemDidClicked:itemIndex:)]) {
        [self.delegate cellItemDidClicked:self itemIndex:indexPath.row];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/2.5, kScreenWidth/2.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - 懒加载

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc] init];
        
    }
    return _dataSource;
}

@end
