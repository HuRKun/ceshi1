//
//  RKWeddingChoseController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/5.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingChoseController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"

#import "RKDiscoverHotel.h"
#import "RKDiscoverCompany.h"
#import "RKDiscoverTeam.h"

#import "RKDiscoverHotelCell.h"

#define kRKDiscoverHotelCell @"RKDiscoverHotelCell"

@interface RKWeddingChoseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) NSString *sort;//!<  分类选择

@property (nonatomic, assign) NSInteger currentPage;//!< 当前数据请求页

@end

@implementation RKWeddingChoseController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    
    [self fetchDataFromServerIsNextPage:NO];
    
    
    [self refreshHeader];
    
    
   
    
    
    //设置表尾
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:kRKDiscoverHotelCell bundle:nil] forCellReuseIdentifier:kRKDiscoverHotelCell];
    
}

- (void)refreshHeader
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataFromServerIsNextPage:NO];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataFromServerIsNextPage:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据请求

- (void)fetchDataFromServerIsNextPage:(BOOL)isNext
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = nil;
    if (self.session == 0) {
        parameters = @{@"region":@(self.region),
                       @"level":self.level,
                       @"page":isNext ? @(self.currentPage + 1) :@(1) ,
                       @"sort":@"heats",
                       @"act": self.act};
    }else{
       parameters = @{@"region":@(self.region),
                      @"cate":self.level,
                      @"page":isNext ? @(self.currentPage + 1) :@(1) ,
                      @"sort":@"heats",
                      @"act": self.act};
    }
    self.dataTask = [manager GET:HOTELlIST parameters:parameters success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (isNext == NO) {
            [self.dataSource removeAllObjects];
        }
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (self.session == 0) {
            for (NSDictionary *dic in obj[@"list"]) {
                RKDiscoverHotel *hotel = [[RKDiscoverHotel alloc] initWithDictionary:dic error:nil];
                [self.dataSource addObject:hotel];
            }
            [self.tableView reloadData];
        }else{
            if ([self.info isEqualToString:@"team"]) {
                for (NSDictionary *dic in obj[@"list"]) {
                    NSError *error = nil;
                    RKDiscoverTeam *team = [[RKDiscoverTeam alloc] initWithDictionary:dic error:&error];
                    if (error == nil) {
                        [self.dataSource addObject:team];
                    }else{
                        NSLog(@"模型数据%@",error);
                    }
                }
            }else{
                for (NSDictionary *dic in obj[@"list"]) {
                    NSError *error = nil;
                    RKDiscoverCompany *company = [[RKDiscoverCompany alloc] initWithDictionary:dic error:&error];
                    if (error == nil) {
                        [self.dataSource addObject:company];
                    }else{
                        NSLog(@"模型数据%@",error);
                    }
                }
            }
            [self.tableView reloadData];
        }
        
        if (isNext == YES) {
            [self.tableView.mj_footer endRefreshing];
            self.currentPage ++;
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

#pragma mark - UITableViewDataSource(数据源代理)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKDiscoverHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKDiscoverHotelCell forIndexPath:indexPath];
    if (self.session == 0) {
        RKDiscoverHotel *hotel = self.dataSource[indexPath.row];
        [cell configeDataForCellWithIndexPath:indexPath hotel:hotel];
        cell.numberLabel.hidden = YES;
        cell.numberImage.hidden = YES;
    }else{
        if ([self.info isEqualToString:@"team"]) {
            RKDiscoverTeam *team= self.dataSource[indexPath.row];
            [cell configeDataForCellWithIndexPath:indexPath team:team];
            cell.numberLabel.hidden = YES;
            cell.numberImage.hidden = YES;
        }else{
            RKDiscoverCompany *company= self.dataSource[indexPath.row];
            [cell configeDataForCellWithIndexPath:indexPath company:company];
            cell.numberLabel.hidden = YES;
            cell.numberImage.hidden = YES;
        }
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}


#pragma mark - 懒加载

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
