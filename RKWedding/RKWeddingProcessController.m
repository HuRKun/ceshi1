//
//  RKWeddingProcessController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingProcessController.h"
#import "RKGlobalDefine.h"
#import "RKWeddingProModel.h"
#import "RKWeddingProModel+database.h"
#import "RKWeddingProcessCell.h"

#define kRKWeddingProcessCell @"RKWeddingProcessCell"

@interface RKWeddingProcessController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate,MBProgressHUDDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;//!<按编辑精选，热门推荐，最近更新排序
@property (nonatomic, copy) NSString *fiter;//!< 请求的参数
@property (nonatomic, copy) NSString *orderby;//!<请求的参数

@property (nonatomic, assign) NSInteger currentPage;//!<请求的页数

@property (nonatomic, strong) NSMutableArray *dataSource;//!< 数据源

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RKWeddingProcessController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.dataSource = [RKWeddingProModel getDataFromLocation];
    [self.hud show:YES];
    
    
    
    self.fiter = @"heat";
    self.orderby = @"heats";
    
    [self fetchDataFromServerForNextPage:NO];
    //自定义一个表头给collectionView
    [self.collectionView addSubview:self.segment];
    
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = 100;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKWeddingProcessCell" bundle:nil] forCellWithReuseIdentifier:kRKWeddingProcessCell];
    
    //设置collectionView内容偏移
    self.collectionView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
//    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = -90.0f;
    
    //数据请求
        [self refreshData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshData
{
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self fetchNextDataFromServer];
    }];
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
    
    NSDictionary *params = @{@"module" : @"forumdisplay",
                             @"version": @"3",
                             @"fid"    : @"2",
                             @"page"   : isNextPage ? @(self.currentPage+1) : @(self.currentPage),
                             @"filter" : self.fiter,
                             @"orderby": self.orderby,
                             @"mver"   : @"3"};
    self.dataTask = [manage GET:@"http://circle.halobear.cn/api/mobile/index.php?" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        id jsonOBJ = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *forum_threadlist = jsonOBJ[@"Variables"][@"forum_threadlist"];
        for (NSDictionary *dic in forum_threadlist) {
            NSError *error = nil;
            RKWeddingProModel *model = [[RKWeddingProModel alloc] initWithDictionary:dic error:&error];
            if (error == nil) {
                [self.dataSource addObject:model];
//                [model saveDataForlocation];
            }
            else{
                NSLog(@"模型数据错误：%@",error);
            }
            
        }
        
        [self.hud hide:YES afterDelay:1.0f];
       // 刷新UI
        [self.collectionView reloadData];
        if (isNextPage == YES) {
            [self.collectionView.mj_footer endRefreshing];
            self.currentPage ++;
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
    
    RKWeddingProcessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKWeddingProcessCell forIndexPath:indexPath];
    RKWeddingProModel *model = self.dataSource[indexPath.row];
    [cell fillDataForCell:model];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width - 20, 160);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

#pragma mark - other
- (void)segmentDidClicked:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {
        self.fiter = @"digest";
        self.orderby = @"lastpost";
        [self fetchDataFromServerForNextPage:NO];
    }else if (segment.selectedSegmentIndex == 1){
        self.fiter = @"heat";
        self.orderby = @"heats";
        [self fetchDataFromServerForNextPage:NO];
    }else{
        self.fiter = @"lastpost";;
        self.orderby = @"lastpost";
        [self fetchDataFromServerForNextPage:NO];
    }
    self.currentPage = 1;
}
#pragma mark - Setter & Getter
- (UISegmentedControl *)segment
{
    if (_segment == nil) {
        NSArray *arr = @[@"编辑精选",@"热门推荐",@"最近更新"];
        _segment = [[UISegmentedControl alloc] initWithItems:arr];
        _segment.selectedSegmentIndex = 1;
        _segment.frame = CGRectMake(5, -45, kScreenWidth-20, 35);
        [_segment setTintColor:[UIColor colorWithRed:209/255.0f green:52/255.0f blue:109/255.0f alpha:1]];
        //设置点击事件
        [_segment addTarget:self action:@selector(segmentDidClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

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
