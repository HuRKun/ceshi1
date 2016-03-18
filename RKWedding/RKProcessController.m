//
//  RKProcessController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/24.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKProcessController.h"
#import "RKGlobalDefine.h"

#import "RKProcessForum.h"
#import "RKProcessThreadlist.h"
#import "RKToplist.h"
#import "RKProcessRoot.h"

#import "RKProcessToplistCell.h"
#import "RKProcessThreadlistCell.h"
#import "RKProcessTableheadViewCell.h"

#define kRKProcessTableheadViewCell @"RKProcessTableheadViewCell"
#define kRKProcessToplistCell @"RKProcessToplistCell"
#define kRKProcessThreadlistCell @"RKProcessThreadlistCell"
@interface RKProcessController ()<MBProgressHUDDelegate>

@property (nonatomic, strong) RKProcessForum *forum;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, assign) NSInteger currentPage;//!< 当前的数据页

@property (nonatomic, strong) NSMutableArray *dataSource;//!<数据源

@property (nonatomic, strong) NSMutableArray *toplistData;//!<toplist数据源

@property (nonatomic, strong) NSMutableArray *forumData;//!<forum数据源

//@property (nonatomic, strong) RKProcessTableheadViewCell *headView;

@property (nonatomic, strong)MBProgressHUD *hud;

@end

@implementation RKProcessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.hud show:YES];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self refreshData];
    [self fetchDataFromServerWithNextPage:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:kRKProcessThreadlistCell bundle:nil ] forCellReuseIdentifier:kRKProcessThreadlistCell];
    [self.tableView registerNib:[UINib nibWithNibName:kRKProcessToplistCell bundle:nil ] forCellReuseIdentifier:kRKProcessToplistCell];
    [self.tableView registerNib:[UINib nibWithNibName:kRKProcessTableheadViewCell bundle:nil] forCellReuseIdentifier:kRKProcessTableheadViewCell];

    
}
- (void)refreshData
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self fetchDataFormServer];
        
    } ];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self fetchNextDataFromServer];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    if (section == 0) {
//        return 1;
//    }else {
        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        RKProcessTableheadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKProcessTableheadViewCell forIndexPath:indexPath];
////        NSString *name = [NSString stringWithFormat:@"%ld",self.index];
////        cell.titleImageView.image = [UIImage imageNamed:name];
////        cell.titleLabel.text = self.forum.name;
////        cell.threadsLabel.text = self.forum.threads;
////        cell.postsLabel.text = self.forum.posts;
//        return cell;
//    }else{
        RKProcessThreadlistCell *threadCell = [tableView dequeueReusableCellWithIdentifier:kRKProcessThreadlistCell forIndexPath:indexPath];
        RKProcessThreadlist *list = self.dataSource[indexPath.section];
        [threadCell fillDataForCell:list];
        
        return threadCell;
//    }
    
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return 64;
//    }else{
        return 110;
//    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - 数据请求
/**
 *  从服务器请求数据
 */
- (void)fetchDataFormServer
{
    [self fetchDataFromServerWithNextPage:NO];
}
/**
 *  请求下一页的数据
 */
- (void)fetchNextDataFromServer
{
    [self fetchDataFromServerWithNextPage:YES];
}
/**
 *  从服务器请求数据，并指定是否是请求下一页的数据
 *
 *  @param isNextPage 是否是请求下一页的数据
 */

- (void)fetchDataFromServerWithNextPage:(BOOL)isNextPage
{
    
    if (isNextPage == NO) {
        [self.dataSource removeAllObjects];
    }
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    //module=forumdisplay&version=3&fid=83&top=1&page=1&orderby=dateline&mver=3
    NSDictionary *paramsters = @{@"module" : @"forumdisplay",
                                 @"version" : @"3",
                                 @"fid" : self.model.fid,
                                 @"page" : isNextPage ? @(self.currentPage + 1) : @(1),
                                 @"top" : isNextPage ? @(0) : @(1),
                                 @"orderby" : @"dateline",
                                 @"mver" : @"3"
                                 };
   self.dataTask = [manage GET:@"http://circle.halobear.cn/api/mobile/index.php?" parameters:paramsters success:^(NSURLSessionDataTask * task, id  responseObject) {
       NSError *error = nil;
       NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];


       if (error == nil) {
            self.forum = [[RKProcessForum alloc] initWithDictionary:jsonObj[@"Variables"] error:nil];
           for (NSDictionary *dis in jsonObj[@"Variables"][@"toplist"]) {
               RKToplist *list = [[RKToplist alloc] initWithDictionary:dis error:nil];
               [self.toplistData addObject:list];
           }
           for (NSDictionary *dis in jsonObj[@"Variables"][@"forum_threadlist"]) {
               
               RKProcessThreadlist *list = [[RKProcessThreadlist alloc] initWithDictionary:dis error:nil];
               [self.dataSource addObject:list];
               
               
           }
           [self.hud hide:YES afterDelay:1.25];
           [self.tableView reloadData];
           
       }else{
           NSLog(@"筹备详情数据模型出错：%@",error);
       }
       
       if (isNextPage == YES) {
           [self.tableView.mj_footer endRefreshing];
           self.currentPage++;
       }else{
           [self.tableView.mj_header endRefreshing];
           self.currentPage = 1;
       }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}
#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)toplistData
{
    if (_toplistData == nil) {
        _toplistData = [[NSMutableArray alloc] init];
    }
    return _toplistData;
}

- (NSMutableArray *)forumData
{
    if (_forumData == nil) {
        _forumData = [[NSMutableArray alloc] init];
    }
    return _forumData;
}

- (RKProcessForum *)forum
{
    if (_forum == nil) {
        _forum = [[RKProcessForum alloc] init];
    }
    return _forum;
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
