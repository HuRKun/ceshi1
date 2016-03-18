//
//  RKShowMoreController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKShowMoreController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
@interface RKShowMoreController ()
@property (nonatomic, strong) NSMutableArray *dataSource;//!< 更多界面的数据源
@property (nonatomic, assign) NSInteger currentPage;//!< 当前请求的数据页

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;//!<


@end

@implementation RKShowMoreController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.dataTask cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self refreshData];
    //设置导航控制器的按钮
    [self editNavigationItem];
    [self registerCell];
    
    
    [self fetchDataFromServerForNextPage:NO];
    
    
}

- (void)refreshData
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self fetchDataFormServer];
        
    } ];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self fetchNextDataFromServer];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)editNavigationItem
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBack"] forBarMetrics:UIBarMetricsDefault];
    if (self.moreBtn <= 2) {
        UIImage *listImage = [[UIImage imageNamed:@"listSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *rightBBI = [UIBarButtonItem createImageBarButtomItemWithImage:listImage taget:self action:@selector(listBtnDidClicked) CGRect:CGRectMake(0, 0, 18, 16)];
        self.navigationItem.rightBarButtonItem = rightBBI;
    }
    
}

- (void)backBBIDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listBtnDidClicked
{
    NSLog(@"listBtn被点击了");
}
#pragma mark - 数据请求
/**
 *  从服务器请求数据
 */
- (void)fetchDataFormServer
{
    [self fetchDataFromServerForNextPage:NO];
}
/**
 *  请求下一页的数据
 */
- (void)fetchNextDataFromServer
{
    [self fetchDataFromServerForNextPage:YES];
}
/**
 *  从服务器请求数据，并指定是否是请求下一页的数据
 *
 *  @param isNextPage 是否是请求下一页的数据
 */
- (void)fetchDataFromServerForNextPage:(BOOL)isNextPage
{
    if (isNextPage == NO) {
        //清空数据源  防止数据重复
        [self.dataSource removeAllObjects];
    }
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //设置响应解析器的类型 为二进制
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @{@"act":self.act,
                             @"page": isNextPage ? @(self.currentPage+1):@(1),
                             @"type": self.type,
                             @"mver":@(3)};
    self.dataTask = [manage GET:API parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        id jsonOBJ = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *list = jsonOBJ[@"list"];
        for (NSDictionary *dic in list) {
            if (self.moreBtn == 3) {
                RKBestWDSubject *subject = [[RKBestWDSubject alloc] initWithDictionary:dic error:nil];
                [self.dataSource addObject:subject];
            }else if (self.moreBtn == 4){
                RKBestPackage *package = [[RKBestPackage alloc] initWithDictionary:dic error:nil];
                [self.dataSource addObject:package];
            }else if (self.moreBtn == 5){
                RKBestLineAct *act = [[RKBestLineAct alloc] initWithDictionary:dic error:nil];
                [self.dataSource addObject:act];
            }else{
                RKBestWedding *model = [[RKBestWedding alloc] initWithDictionary:dic error:nil];
                [self.dataSource addObject:model];
            }
        }
        //刷新UI
        [self.collectionView reloadData];
        if (isNextPage == YES) {
            [self.collectionView.mj_footer endRefreshing];
            self.currentPage ++;
        }else{
            [self.collectionView.mj_header endRefreshing];
            self.currentPage = 1;
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RKRKBestWeddingCell *weddingCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestWeddingCell forIndexPath:indexPath];
    RKBestImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestImageCell forIndexPath:indexPath];
    RKBestVideoCell *videoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestVideoCell forIndexPath:indexPath];
    
    RKBestSubjectCell *subjectCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestWDSubjectCell forIndexPath:indexPath];
    RKBestParpareCell *parpareCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestParpareCell forIndexPath:indexPath];
    RKBestActCell *actCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestActCell forIndexPath:indexPath];
    
    if (self.moreBtn == 3) {
        // 提取数据
        RKBestWDSubject *model = self.dataSource[indexPath.row];
        [subjectCell fillDataForCell:model];
        return subjectCell;
    }else if (self.moreBtn == 4){
        RKBestPackage *model = self.dataSource[indexPath.row];
        [parpareCell fillDataForCell:model];
        return parpareCell;
        
    }else if (self.moreBtn == 5){
        RKBestLineAct *model = self.dataSource[indexPath.row];
        [actCell fillDataForCell:model];
        return actCell;
    }else{
        RKBestWedding *model = self.dataSource[indexPath.row];
        if (self.moreBtn == 0) {
           [weddingCell fillDataForCell:model];
            return weddingCell;
        }else if (self.moreBtn == 1){
            [imageCell fillDataForCell:model];
            return imageCell;
        }else{
            [videoCell fillDataForCell:model];
            return videoCell;
        }
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个item的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.moreBtn == 0 || self.moreBtn == 2) {
        return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.5 );
    } else if (self.moreBtn == 1){
        return CGSizeMake((kScreenWidth-30) / 2.0f, (kScreenWidth-30) /2.0f);
    }else if ( self.moreBtn == 5){
        return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.65);
    }else if (self.moreBtn == 3)
    {
        return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.8);
    }
    else{
        return CGSizeMake(kScreenWidth-20, 110);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
//设置每个item 的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.moreBtn == 0)
    {
        RKWeddingDetailController *detailVC = [[RKWeddingDetailController alloc] initWithNibName:@"RKWeddingDetailController" bundle:nil];
        
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.model = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (self.moreBtn == 1)
    {
        RKVideoDetailController *vc = [[RKVideoDetailController alloc] initWithNibName:@"RKVideoDetailController" bundle:nil];
        vc.isVideo = NO;
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (self.moreBtn == 2)
    {
        RKVideoDetailController *vc = [[RKVideoDetailController alloc] initWithNibName:@"RKVideoDetailController" bundle:nil];
        vc.isVideo = YES;
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (self.moreBtn == 3)
    {
        RKWeddingSubDetailController *vc = [[RKWeddingSubDetailController alloc] initWithNibName:@"RKWeddingSubDetailController" bundle:nil];
        
        RKBestWDSubject *subject = self.dataSource[indexPath.row];
        vc.isBanner = NO;
        vc.model = subject;
        vc.navigationItem.title = @"婚礼专题";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (self.moreBtn == 4)
    {
        RKLineActDetailController *act = [[RKLineActDetailController alloc] initWithNibName:@"RKLineActDetailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:act];
        
        [self presentViewController:nav animated:YES completion:nil];
        RKBestPackage *model = self.dataSource[indexPath.row];
        act.strUrl = model.yhhd_id;
    }
    else if (self.moreBtn == 5)
    {
        RKLineActDetailController *act = [[RKLineActDetailController alloc] initWithNibName:@"RKLineActDetailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:act];
        
        [self presentViewController:nav animated:YES completion:nil];
        RKBestLineAct *model = self.dataSource[indexPath.row];
        act.strUrl = model.xxhd_id;
    }
    
    

}

#pragma mark - help Mothor
//注册cell
- (void)registerCell
{
    //注册第一段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKRKBestWeddingCell" bundle:nil] forCellWithReuseIdentifier:kRKBestWeddingCell];
    //注册第二段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestImageCell" bundle:nil] forCellWithReuseIdentifier:kRKBestImageCell];
    //注册第三段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestVideoCell" bundle:nil] forCellWithReuseIdentifier:kRKBestVideoCell];
    
    //注册第四段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestSubjectCell" bundle:nil] forCellWithReuseIdentifier:kRKBestWDSubjectCell];
    //注册第五段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestParpareCell" bundle:nil] forCellWithReuseIdentifier:kRKBestParpareCell];
    //注册第六段的cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestActCell" bundle:nil] forCellWithReuseIdentifier:kRKBestActCell];
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
