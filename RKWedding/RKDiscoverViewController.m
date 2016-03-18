//
//  RKDiscoverViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/26.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDiscoverViewController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
#import "RKWeddingAfflatusController.h"
#import "RKWeddingChoseController.h"
#import "RKCompanyDetailController.h"

#import "RKDiscoverFirstCell.h"
#import "RKDiscoverHotelCell.h"

#import "RKBestReusableView.h"
#import "RKTableViewHeadView.h"
#import "RKDiscoverHotel.h"
#import "RKDiscoverCompany.h"




#import "RKGlobalDefine.h"
#import "NetAPI.h"

#define kRKDiscoverHotelCell @"RKDiscoverHotelCell"
#define kRKTableViewHeadView @"RKTableViewHeadView"
#define kRKDiscoverFirstCell @"RKDiscoverFirstCell"
@interface RKDiscoverViewController () <GGBannerViewDelegate,RKDiscoverFirstCellDelegate>

@property (nonatomic, strong) NSMutableArray *localData;//!<本地的数据信息
@property (nonatomic, strong) NSMutableArray *hotelData;//!<婚宴酒店的数据信息

@property (nonatomic, strong) NSMutableArray *companyData;//!<婚庆公司的数据信息

@property (nonatomic, strong) NSMutableArray *weddingDressData;//!<婚纱的数据信息
@property (nonatomic, strong) NSArray *headData;//!< 段头数据

@property (nonatomic, strong) NSMutableArray *bannerData;//!<广告栏数据
@property (nonatomic, strong) GGBannerView *bannerView;//!<广告轮播
@property (nonatomic, assign) NSInteger region;//!< 请求数据的参数

@property (nonatomic, strong) RKNotFailController *fail;

@end

@implementation RKDiscoverViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSNotificationCenter *cencer = [NSNotificationCenter defaultCenter];
        
        [cencer addObserver:self selector:@selector(reciveMessage:) name:@"CityChange" object:nil];
        _location = @"全国";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchBannerDataFromServer];
    
//    //设置界面
//    self.navigationItem.title = @"发现";
//    UIBarButtonItem *searchBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_dis_search"]taget:nil action:nil CGRect:CGRectMake(0, 0, 16, 16)];
//    self.navigationItem.rightBarButtonItem = searchBBI;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:kRKDiscoverFirstCell bundle:nil] forCellReuseIdentifier:kRKDiscoverFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:kRKDiscoverHotelCell bundle:nil] forCellReuseIdentifier:kRKDiscoverHotelCell];
    
    //注册段头
    [self.tableView registerNib:[UINib nibWithNibName:kRKTableViewHeadView bundle:nil] forHeaderFooterViewReuseIdentifier:kRKTableViewHeadView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Discover" ofType:@"plist"];
    self.localData = [NSMutableArray arrayWithContentsOfFile:path];
    
    self.tableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    

    
}

#pragma mark - help
- (void)fetchBannerDataFromServer
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:DISCOVERBANNER parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *list = jsonObj[@"list"];
        [self.bannerData removeAllObjects];
        for (NSDictionary *dic in list) {
            NSError *error = nil;
            RKHeadImageModel *model = [[RKHeadImageModel alloc] initWithDictionary:dic error:&error];
            if (error == nil) {
                [self.bannerData addObject:model];
            }else{
                NSLog(@"发现广告栏的数据模型数据出错：%@",error);
            }
        }
        
        [self.tableView addSubview:self.bannerView];
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
       
    }];
}

- (void)fetchHotelDataFromServer
{
    [self.hotelData removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramsters = @{@"act":@"hotellist",
                                 @"region":@(self.region)};
    [manager GET:DISCOVER parameters:paramsters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        NSArray *list = jsonObj[@"list"];
        for (NSDictionary *dic in list) {
            NSError *error = nil;
            RKDiscoverHotel *hotel = [[RKDiscoverHotel alloc] initWithDictionary:dic error:&error];
            if (error == nil) {
                [self.hotelData addObject:hotel];
            }else{
                NSLog(@"酒店的数据模型数据出错：%@",error);
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"酒店的数据请求错误：%@",error);
    }];
}

- (void)fetchCompanyDataFromServer
{
    [self.companyData removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramsters = @{@"act":@"companylist",
                                 @"region":@(self.region),
                                 @"cate":@"2"};
    [manager GET:DISCOVER parameters:paramsters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                NSArray *list = jsonObj[@"list"];
                for (NSDictionary *dic in list) {
                    NSError *error = nil;
                    RKDiscoverCompany *company = [[RKDiscoverCompany alloc] initWithDictionary:dic error:&error];
                    if (error == nil) {
                        [self.companyData addObject:company];
                    }else{
                        NSLog(@"婚庆公司的数据模型数据出错：%@",error);
                    }
                }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"婚庆公司的数据请求错误：%@",error);
    }];
}

- (void)fetchWeddingDressDataFromServer
{
    
    [self.weddingDressData removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramsters = @{@"act":@"companylist",
                                 @"region":@(self.region),
                                 @"cate":@"1"};
    [manager GET:DISCOVER parameters:paramsters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                NSArray *list = jsonObj[@"list"];
                for (NSDictionary *dic in list) {
                    NSError *error = nil;
                    RKDiscoverCompany *model = [[RKDiscoverCompany alloc] initWithDictionary:dic error:&error];
                    if (error == nil) {
                        [self.weddingDressData addObject:model];
                    }else{
                        NSLog(@"婚纱的数据模型数据出错：%@",error);
                    }
                }
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}
#pragma mark - other
- (void)reciveMessage:(NSNotification *)notifi
{
    if ([notifi.object isEqualToString:@"全国"]) {
        self.location = notifi.object;
    }else{
        NSString *name = [NSString stringWithFormat:@"%@市",notifi.object];
        self.location = name;
      RKCity *city = [RKCity cityFromDatabaseWithRegion_name:self.location];
        self.region = city.region_id;
        [self againFetchDataFromServer];

        
    }
    [self.tableView reloadData];
}

- (void)removeData
{
    [self.companyData removeAllObjects];
    [self.hotelData removeAllObjects];
    [self.weddingDressData removeAllObjects];
}
- (void)againFetchDataFromServer
{
    //全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [self fetchHotelDataFromServer];
    });
    dispatch_async(globalQueue, ^{
        [self fetchCompanyDataFromServer];
    });
    dispatch_async(globalQueue, ^{
        [self fetchWeddingDressDataFromServer];
    });
    dispatch_async(globalQueue, ^{
        //请求广告页数据
        [self fetchBannerDataFromServer];
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section < 3) {
        return 1;
    }else{
        return self.companyData.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section < 3) {
        RKDiscoverFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKDiscoverFirstCell forIndexPath:indexPath];
        cell.delegate = self;
        NSArray *arr = self.localData[indexPath.section];
        [cell refreshWithData:arr];
        return cell;
    }else if (indexPath.section == 3){
        RKDiscoverHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKDiscoverHotelCell];
        RKDiscoverHotel *hotel = self.hotelData[indexPath.row];
        [cell configeDataForCellWithIndexPath:indexPath hotel:hotel];
        return cell;
    }else if(indexPath.section == 4){
        RKDiscoverHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKDiscoverHotelCell];
        RKDiscoverCompany *company = self.weddingDressData[indexPath.row];
        [cell configeDataForCellWithIndexPath:indexPath company:company];
        return cell;
    }else{
        RKDiscoverHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:kRKDiscoverHotelCell];
        RKDiscoverCompany *company = self.companyData[indexPath.row];
        [cell configeDataForCellWithIndexPath:indexPath company:company];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        return 150;
    }else{
        return 74;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 5) {
        return nil;
    }
    UIView *foot = [[UIView alloc] init];
    foot.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f  blue:240/255.0f  alpha:1];
    return foot;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RKTableViewHeadView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kRKTableViewHeadView];
//    head.contentView.backgroundColor = [UIColor whiteColor];
    head.titleLabel.text = self.headData[section];
    if (section <3) {
        head.locationCityBtn.hidden = YES;
        head.rightImageView.hidden = YES;
        return head;

    }else{
    
        [head.locationCityBtn setTitle:self.location forState:UIControlStateNormal];
        head.locationCityBtn.hidden = NO;
        head.rightImageView.hidden = NO;
        return head;
    }
    
}


#pragma mark - RKDiscoverFirstCellDelegate

- (void)cellItemDidClicked:(RKDiscoverFirstCell *)cell itemIndex:(NSInteger)itemIndex
{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 2) {
        RKWeddingAfflatusController *vc = [[RKWeddingAfflatusController alloc] initWithNibName:@"RKWeddingAfflatusController" bundle:nil];
        vc.number = itemIndex + 1;
        NSArray *arr = self.localData[indexPath.section];
        NSDictionary *dic = arr[itemIndex];
        vc.navigationItem.title = dic[@"name"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        RKWeddingChoseController *vc = [[RKWeddingChoseController alloc] initWithNibName:@"RKWeddingChoseController" bundle:nil];
        NSArray *arr = self.localData[indexPath.section];
        NSDictionary *dic = arr[itemIndex];

        RKFirstViewInfoList *list = [RKFirstViewInfoList InfoListFromDatabaseWithName:dic[@"name"]];
        vc.level = list.indexintype;
        NSLog(@"%@",vc.level);
        vc.act = [NSString stringWithFormat:@"%@list",list.info1];
        vc.info = list.info1;
        vc.session = indexPath.section;
        vc.region = self.region;
        vc.navigationItem.title = dic[@"name"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }


    
}
#pragma mark - GGBannerViewDelegate
- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"background1"]];
}

-(void)bannerView:(GGBannerView *)bannerView didSelectAtIndex:(NSUInteger)index{
    
    //点击那张图片就把对应的参数传给界面请求数据
    
    RKCompanyDetailController *vc = [[RKCompanyDetailController alloc] initWithNibName:@"RKCompanyDetailController" bundle:nil];

 
    [self.navigationController pushViewController:vc animated:YES];
    

    
}
#pragma mark - 懒加载
- (NSMutableArray *)localData
{
    if (_localData == nil) {
        _localData = [[NSMutableArray alloc] init];
    }
    return _localData;
}

- (NSMutableArray *)hotelData
{
    if (_hotelData == nil) {
        _hotelData = [[NSMutableArray alloc] init];
    }
    return _hotelData;
}

- (NSMutableArray *)companyData
{
    if (_companyData == nil) {
        _companyData = [[NSMutableArray alloc] init];
    }
    return _companyData;
}

- (NSMutableArray *)weddingDressData
{
    if (_weddingDressData == nil) {
        _weddingDressData = [[NSMutableArray alloc] init];
    }
    return _weddingDressData;
}

- (NSArray *)headData
{
    if (_headData == nil) {
        _headData = [[NSArray alloc] init];
        _headData = @[@"婚宴场地",@"结婚服务",@"婚礼灵感",@"热门婚宴酒店",@"热门婚纱摄影",@"热门婚庆公司"];
    }
    return _headData;
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



@end
