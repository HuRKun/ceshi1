//
//  RKWeddingAfflatusDetailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/12.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingAfflatusDetailController.h"
#import "RKFlowerCell.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "RKFlowerModel.h"
#define kRKFlowerCell @"RKFlowerCell"
@interface RKWeddingAfflatusDetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RKWeddingAfflatusDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.model.color_name;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.hud show:YES];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKFlowerCell bundle:nil] forCellWithReuseIdentifier:kRKFlowerCell];
    [self fetchDataFromServerIsNext:NO];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataFromServerIsNext:NO];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataFromServerIsNext:YES];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 数据请求

- (void)fetchDataFromServerIsNext:(BOOL)isNext
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramters = @{@"act":@"lgsclist",
                                @"cate":self.cate,
                                @"page":isNext?@(self.currentpage + 1):@(1),
                                @"pageper":@"32",
                                @"color":@(self.index),
                                @"mver":@"3"};
    self.dataTask = [manager GET:API parameters:paramters success:^(NSURLSessionDataTask * task, id  responseObject) {
        if (isNext == NO) {
            [self.dataSource removeAllObjects];
        }
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in obj[@"list"]) {
            RKFlowerModel *model = [[RKFlowerModel alloc] initWithDictionary:dic error:nil];
            [self.dataSource addObject:model];
        }
        
        [self.hud hide:YES afterDelay:1.25];
        [self.collectionView reloadData];
        if (isNext == YES) {
            [self.collectionView.mj_footer endRefreshing];
            self.currentpage ++;
        }else{
            [self.collectionView.mj_header endRefreshing];
            self.currentpage = 1;
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RKFlowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKFlowerCell forIndexPath:indexPath];
    RKFlowerModel *model = self.dataSource[indexPath.row];
    [cell.flowerImageView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableArray *bigUrlArray = [NSMutableArray array];
    NSMutableArray *normalArray = [NSMutableArray array];
    RKFlowerCell *cell = (RKFlowerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    for (RKFlowerModel *model in self.dataSource) {
        [bigUrlArray addObject:model.image_url];
        [normalArray addObject:model.default_image];
    }
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < [bigUrlArray count];i++)
    {
       
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = bigUrlArray[i];// 大图url地址
        browseItem.smallImageView = cell.flowerImageView;
        [browseItemArray addObject:browseItem];
    }
    
    MSSBrowseViewController *bvc = [[MSSBrowseViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
    [bvc showBrowseViewController];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-1)/2.0f, (kScreenWidth-1)/2.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
#pragma mark - 懒加载
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
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.delegate = self;
        _hud.labelText = @"Loading";
        _hud.removeFromSuperViewOnHide = YES;
        _hud.opacity = 0.4;
        _hud.animationType = MBProgressHUDAnimationZoomOut;
        
    }
    return _hud;
}

@end
