//
//  RKDiscussController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/23.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDiscussController.h"
#import "RKGlobalDefine.h"
#import "RKProcess.h"
#import "RKHeadImageModel.h"
#import "RKProcessController.h"
@interface RKDiscussController () <GGBannerViewDelegate,RKNotFailControllerDelegate>

@property (nonatomic, strong) NSMutableArray *processData;//!<讨论小组的数据
@property (nonatomic, strong) NSMutableArray *bannerData;//!<广告栏的数据

@property (nonatomic, strong) GGBannerView *bannerView;//!<广告栏

@property (nonatomic, strong) RKNotFailController *fail;

@end

@implementation RKDiscussController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self fetchDataFromServer];
    [self fetchBannerDataFromServer];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.processData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    RKProcess *pro = self.processData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = pro.name;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = pro.proDescription;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    NSString *imageStr = [NSString stringWithFormat:@"choubei%ld",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageStr];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -180) {
        self.bannerView.frame = CGRectMake(0, scrollView.contentOffset.y, kScreenWidth,180);
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKProcessController *pro = [[RKProcessController alloc] initWithNibName:@"RKProcessController" bundle:nil];
    pro.index = indexPath.row;
    pro.model = self.processData[indexPath.row];
    [self.navigationController pushViewController:pro animated:YES];
}
#pragma mark - 数据请求
- (void)fetchDataFromServer
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:@"http://data.halobear.cn/mapi/index.php?act=banner&cate=1&adcode=(null)&mver=3" parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *list = jsonObj[@"list"];
        for (NSDictionary *dic in list) {
            NSError *error = nil;
            RKHeadImageModel *model = [[RKHeadImageModel alloc] initWithDictionary:dic error:&error];
            if (error == nil) {
                [self.bannerData addObject:model];
            }else{
                NSLog(@"广告栏的数据模型数据出错：%@",error);
            }
        }
//        self.tableView.tableHeaderView = self.bannerView;
            [self.tableView addSubview:self.bannerView];
       
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}
//请求广告栏的数据
- (void)fetchBannerDataFromServer
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage GET:@"http://circle.halobear.cn/api/mobile/index.php?module=forumnav&version=4&adcode=653000&mver=3" parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *forums = jsonObj[@"Variables"][@"forums"];
        for (NSDictionary *dic in forums) {
            NSError *error = nil;
            RKProcess *pro = [[RKProcess alloc] initWithDictionary:dic error:&error];
            if (error == nil) {
                [self.processData addObject:pro];
            }else{
                NSLog(@"讨论小组的总数据模型数据出错：%@",error);
            }
        }
        [self rk_removeChildViewController:self.fail];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
        [self rk_addChildViewController:self.fail];
        
    }];
}
#pragma mark - RKNotFailControllerDelegate
//网络连接重新加载数据
- (void)againRefreshData
{
    [self fetchDataFromServer];
    [self fetchBannerDataFromServer];
}
#pragma mark - GGBannerViewDelegate
- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"checkin1"]];
}

-(void)bannerView:(GGBannerView *)bannerView didSelectAtIndex:(NSUInteger)index{
    if (bannerView == self.bannerView) {
        NSLog(@"选中-- bannerView1 - %@",@(index));
    }else{
        NSLog(@"选中-- bannerView2 - %@",@(index));
    }
}
#pragma mark - Setter & Getter

- (NSMutableArray *)processData
{
    if (_processData == nil) {
        _processData = [[NSMutableArray alloc] init];
    }
    return _processData;
}
- (NSMutableArray *)bannerData
{
    if (_bannerData == nil) {
        _bannerData = [[NSMutableArray alloc] init];
    }
    return _bannerData;
}
- (GGBannerView *)bannerView
{
    if (_bannerView == nil) {
        _bannerView = [[GGBannerView alloc] initWithFrame:CGRectMake(0, -180, kScreenWidth, 180)];
        _bannerView.delegate = self;
        _bannerView.interval = 2;
        //隐藏分页控制器
        _bannerView.pageController.hidden = YES;
        NSMutableArray *arr = [NSMutableArray array];
        for (RKHeadImageModel *model in self.bannerData) {
            [arr addObject:model.banner_logo];
        }
        
        [_bannerView configBanner:arr];
    
    }
    return _bannerView;
}

- (RKNotFailController *)fail
{
    if (_fail == nil) {
        _fail = [[RKNotFailController alloc] initWithNibName:@"RKNotFailController" bundle:nil];
    }
    return _fail;
}
@end
