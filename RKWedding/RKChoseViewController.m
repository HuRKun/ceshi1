//
//  RKChoseViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKChoseViewController.h"
#import "RKGlobalDefine.h"
#import "UIImage+DPTransparent.h"

//cell点击进去的页面
#import "RKWeddingDetailController.h"
#import "RKLineActDetailController.h"
#import "RKWeddingSubDetailController.h"
#import "RKVideoDetailController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "RKLoctionController.h"
#import "Masonry.h"
#import "RKAppDelegate.h"
#import "NetAPI.h"
@interface RKChoseViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GGBannerViewDelegate,RKLoctionControllerDelegate,MBProgressHUDDelegate,RKNotFailControllerDelegate>

@property (strong, nonatomic)  UIImageView *locationImageView;

@property (nonatomic, strong) GGBannerView *playImage; //!<用来图片轮播的
@property (nonatomic, strong) NSMutableArray *imageArray;//!< 存放广告轮播的图片

@property (nonatomic, strong) UILabel *locationLabel;//!< 显示定位城市

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableArray *dataSource;//!<首页数据源

@property (nonatomic, strong) NSArray *pushNextVCData;//跳转到更多的时候的数据

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSURLSessionDataTask *dataTask;//!<数据请求的任务，为了方便在必要的时候，取消当前的请求

@property (nonatomic,strong) NSArray *headViewData;

@property (nonatomic, strong) RKNotFailController *fail;

@end

@implementation RKChoseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage *image = [UIImage transparentImage];
    //设置一张透明的图片为导航栏的背景图片
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //通知中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center  addObserver:self selector:@selector(recevieMessage:) name:@"CurrentLocationCity" object:nil];
    [self.locationBtn addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.hud show:YES];
    //请求数据
    [self fecthChoicenavDtaFromServer];
    //请求广告轮播的数据
    [self fecthBannerDtaFromServer];
   
    //设置collectionView的背景颜色为透明，默认是黑色的
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //注册该界面需要的cell
    [self registerCell];
    
    //设置collection的表内容从哪里开始显示
    self.collectionView.contentInset = UIEdgeInsetsMake(220, 0, 0, 0);
    
    //计算缓存
//    float tmpsize = [[SDImageCache sharedImageCache] getSize]/1024/1024;
//    NSLog(@"%f",tmpsize);
    
    [self aleartViewMessage];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //在页面消失时 取消界面数据请求，以免不必要的浪费
    [self.dataTask cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - help Method

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
    
    //注册组头
    [self.collectionView registerNib:[UINib nibWithNibName:@"RKBestReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView];
}
// 首页数据请求
-(void)fecthChoicenavDtaFromServer
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.dataTask = [manage GET:FIRSTPaAGEAPI parameters:nil success:^(NSURLSessionDataTask *task, id  responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSArray *dataTitle = @[@"jxhl",@"jxtp",@"jxsp",@"hlzt",@"yhhd",@"xxhd"];
        for (int i =0; i<6; i++) {
            NSString *title = self.pushNextVCData[i];
            NSArray *data = jsonObj[title];
            NSMutableArray *dataModel = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in data) {
                if (i == 3) {
                    RKBestWDSubject *subject = [[RKBestWDSubject alloc] initWithDictionary:dic error:nil];
                    [dataModel addObject:subject];
                    
                }else if (i == 4){
                    RKBestPackage *parpare = [[RKBestPackage alloc] initWithDictionary:dic error:nil];
                    [dataModel addObject:parpare];
                }else if (i == 5){
                    RKBestLineAct *line = [[RKBestLineAct alloc] initWithDictionary:dic error:nil];
                    [dataModel addObject:line];
                }else{
                    RKBestWedding *model = [[RKBestWedding alloc] initWithDictionary:dic error:nil];
                    [dataModel addObject:model];
                }
               
            }
             [self.hud hide:YES afterDelay:1.25f];
             [self.dataSource addObject:dataModel];
        }
        [self rk_removeChildViewController:self.fail];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UILabel creareLableViewWithMessage:@"好像网络跑丢了" supView:self.view];
        
        [self rk_addChildViewController:self.fail];
        
    }];
}
// 广告栏数据请求
-(void)fecthBannerDtaFromServer
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage GET:FIRSTBANNER parameters:nil success:^(NSURLSessionDataTask *task, id  responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *list = jsonObj[@"list"];
        for (NSDictionary *dic in list) {
            RKHeadImageModel *model = [[RKHeadImageModel alloc] initWithDictionary:dic error:nil];
            [self.imageArray addObject:model];
        }
        [self.collectionView addSubview:self.playImage];
        [self.playImage addSubview:self.locationImageView];
        [self.playImage addSubview:self.locationBtn];
        
        [self makeConstraintsWith:self.playImage];
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败：%@",error);
    }];
}
#pragma mark - UICollectionViewDataSource(数据源代理)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.dataSource.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *data = self.dataSource[section];
    return data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RKRKBestWeddingCell *weddingCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestWeddingCell forIndexPath:indexPath];
    RKBestImageCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestImageCell forIndexPath:indexPath];
    RKBestVideoCell *videoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestVideoCell forIndexPath:indexPath];
    
    RKBestSubjectCell *subjectCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestWDSubjectCell forIndexPath:indexPath];
    RKBestParpareCell *parpareCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestParpareCell forIndexPath:indexPath];
    RKBestActCell *actCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKBestActCell forIndexPath:indexPath];
    // 提取数据
    NSArray *data = self.dataSource[indexPath.section];
   
    if (indexPath.section == 0) {
        
        RKBestWedding *model = data[indexPath.row];
        [weddingCell fillDataForCell:model];
        return weddingCell;
        
    } else if (indexPath.section == 1){
        RKBestWedding *model = data[indexPath.row];
        [imageCell fillDataForCell:model];
        return imageCell;
    }
    else if(indexPath.section == 2){

         RKBestWedding *model = data[indexPath.row];
        [videoCell fillDataForCell:model];
        return videoCell;
    }else if (indexPath.section == 3){

        RKBestWDSubject *model = data[indexPath.row];
        [subjectCell fillDataForCell:model];
        return subjectCell;
    }else if (indexPath.section == 4){

        RKBestPackage *parpare = data[indexPath.row];
        [parpareCell fillDataForCell:parpare];
        
        return parpareCell;
    }else{

        RKBestLineAct *model = data[indexPath.row];
        [actCell fillDataForCell:model];
        return actCell;
    }
    

}
#pragma mark - UICollectionViewDelegate(行为代理)
//当collectionView上下滚动的时候会调用该方法  向下滚动为-  往上滚动为+
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
//     NSLog(@"%f,%f",point.x,point.y);
    
    if (point.y < -220) {
        self.playImage.frame = CGRectMake(0, point.y, kScreenWidth, 220);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        RKWeddingDetailController *detailVC = [[RKWeddingDetailController alloc] initWithNibName:@"RKWeddingDetailController" bundle:nil];
        
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.model = self.dataSource[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (indexPath.section == 1)
    {
        RKVideoDetailController *vc = [[RKVideoDetailController alloc] initWithNibName:@"RKVideoDetailController" bundle:nil];
        vc.isVideo = NO;
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataSource[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2)
    {
        RKVideoDetailController *vc = [[RKVideoDetailController alloc] initWithNibName:@"RKVideoDetailController" bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isVideo = YES;
        vc.model = self.dataSource[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 3)
    {
        RKWeddingSubDetailController *vc = [[RKWeddingSubDetailController alloc] initWithNibName:@"RKWeddingSubDetailController" bundle:nil];
        
        RKBestWDSubject *subject = self.dataSource[indexPath.section][indexPath.row];
        vc.isBanner = NO;
        vc.model = subject;
        vc.navigationItem.title = @"婚礼专题";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 4)
    {
        RKLineActDetailController *act = [[RKLineActDetailController alloc] initWithNibName:@"RKLineActDetailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:act];
        
        [self presentViewController:nav animated:YES completion:nil];
        RKBestPackage *model = self.dataSource[indexPath.section] [indexPath.row];
        act.strUrl = model.yhhd_id;
    }
    else if (indexPath.section == 5)
    {
        RKLineActDetailController *act = [[RKLineActDetailController alloc] initWithNibName:@"RKLineActDetailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:act];
        
        [self presentViewController:nav animated:YES completion:nil];
        RKBestLineAct *model = [self.dataSource[indexPath.section] lastObject];
        act.strUrl = model.xxhd_id;
    }
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个item的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 || indexPath.section == 2) {
       return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.5 );
    } else if (indexPath.section == 1){
        return CGSizeMake((kScreenWidth-30) / 2.0f, (kScreenWidth-30) /2.0f);
    }else if (indexPath.section == 3 ){
        return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.8);
    }else if (indexPath.section == 5)
    {
        return CGSizeMake(kScreenWidth-20, (kScreenWidth-20)*0.7);
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
//设置段头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RKBestReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKBestReusableView forIndexPath:indexPath];
    
    [headView createHeadViewFor:self.headViewData[indexPath.section] image:@"arrow1"];

    [headView createHeadViewForButtom:@"更多" taget:self indexPath:indexPath.section];
    
    return headView;
}

//设置组头的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 35);
}
#pragma mark - RKNotFailControllerDelegate

- (void)againRefreshData
{
    [self fecthChoicenavDtaFromServer];
    [self fecthBannerDtaFromServer];
}
#pragma mark - otherMothor
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSNotificationCenter *cencer = [NSNotificationCenter defaultCenter];
    NSString *city = change[@"new"];
    [cencer postNotificationName:@"CityChange" object:city];
}

- (void)aleartViewMessage
{
    
    if ([RKLoginManager shareManager].islocation == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        alert.message = @"定位失败";
        [alert addButtonWithTitle:@"朕已阅"];
        [alert show];
    }else{
        NSString *locationCity = [NSString stringWithFormat:@"是否定位到你所在的城市: %@",[RKLoginManager shareManager].locationCity];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你当前所在的城市" message:locationCity delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert show];
    }
    
}
//当监听到事件会触发该方法
- (void)recevieMessage:(NSNotification *)notif
{
    self.locationBtn.text = notif.object;    
}

//更多 的按钮被点击
- (void)moreBtnDidClicked:(UIButton *)sender
{
    
    RKShowMoreController *showMoreVC = [[RKShowMoreController alloc] initWithNibName:@"RKShowMoreController" bundle:nil];
    
    [self.navigationController pushViewController:showMoreVC animated:YES];

    showMoreVC.navigationItem.title = self.headViewData[sender.tag];
    showMoreVC.moreBtn = sender.tag;
    //设置showMoreVC 的请求数据参数
    if (sender.tag<=2) {
        showMoreVC.act = @"hxjxlist";
        showMoreVC.type = self.pushNextVCData[sender.tag];
    }else{
        showMoreVC.act = [NSString stringWithFormat:@"%@list",self.pushNextVCData[sender.tag]];
        showMoreVC.type = @"";
    }
   
}

- (void)makeConstraintsWith:(GGBannerView *)view
{
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(64.0f);
        make.leading.mas_equalTo(view.mas_leading).offset(13.0f);
        make.trailing.mas_lessThanOrEqualTo(self.view.mas_trailing).offset(0);
        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(40);
    }];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(70.0f);
        make.leading.mas_equalTo(self.locationBtn.mas_trailing).offset(3);
     
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(11);
    }];
}
#pragma mark - Setter & Getter

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc] init];
        
    }
    return _imageArray;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        
        
    }
    return _dataSource;
}

- (NSArray *)headViewData
{
    if (_headViewData == nil) {
        _headViewData = [[NSArray alloc] init];
        _headViewData = @[@"最新精选婚礼",@"每日精选图片",@"最新精选视频",@"每月婚礼专题",@"最新优惠套餐",@"精选线下活动"];
    }
    
    return _headViewData;
}
- (NSArray *)pushNextVCData
{
    if (_pushNextVCData == nil) {
        _pushNextVCData = [[NSArray alloc] init];
        _pushNextVCData = @[@"jxhl",@"jxtp",@"jxsp",@"hlzt",@"yhhd",@"xxhd"];
    }
    
    return _pushNextVCData;
}
- (GGBannerView *)playImage
{
    if (_playImage == nil) {
        
        _playImage = [[GGBannerView alloc]initWithFrame:CGRectMake(0, -220, kScreenWidth, 220)];
        _playImage.delegate = self;
        _playImage.interval = 2;
        //隐藏分页控制器
        _playImage.pageController.hidden = YES;
        NSMutableArray *arr = [NSMutableArray array];
        for (RKHeadImageModel *model in self.imageArray) {
            [arr addObject:model.banner_logo];
        }
        
        [_playImage configBanner:arr];
        
        
    }
    return _playImage;
}
#pragma mark - delegate
- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"background1"]];
}

-(void)bannerView:(GGBannerView *)bannerView didSelectAtIndex:(NSUInteger)index{
    if (bannerView == self.playImage) {
      //点击那张图片就把对应的参数传给界面请求数据
       
            RKWeddingSubDetailController *vc = [[RKWeddingSubDetailController alloc] initWithNibName:@"RKWeddingSubDetailController" bundle:nil];
            vc.navigationItem.title = @"婚礼专题";
            vc.bannerModel = self.imageArray[index];
            vc.isBanner = YES;
            [self.navigationController pushViewController:vc animated:YES];
    
        
    }
}
#pragma mark - RKLoctionControllerDlegate

- (void)locationAddress:(NSString *)address
{
    self.locationBtn.text = address;
}

- (void)locationBtnDidClicked {
    
    RKLoctionController *vc = [[RKLoctionController alloc] initWithNibName:@"RKLoctionController" bundle:nil];
    vc.delegate = self;
    RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:vc];
    vc.city = self.locationBtn.text;
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - Setter & Getter
- (UILabel *)locationBtn
{
    if (_locationBtn == nil) {
        _locationBtn = [[UILabel alloc]init];
        _locationBtn.frame = CGRectZero;
        _locationBtn.text = @"定位中";
         _locationBtn.userInteractionEnabled = YES;
        _locationBtn.textColor = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:13.0f];
        _locationBtn.font = font;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationBtnDidClicked)];
       
        [_locationBtn addGestureRecognizer:tap];
    }
    return _locationBtn;
}

- (UIImageView *)locationImageView
{
    if (_locationImageView == nil) {
        _locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_nav_location@3x"]];
        _locationImageView.frame = CGRectZero;
    }
    return _locationImageView;
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

- (RKNotFailController *)fail
{
    if (_fail == nil) {
        _fail = [[RKNotFailController alloc] initWithNibName:@"RKNotFailController" bundle:nil];
        _fail.delegaet = self;
    }
    return _fail;
}
@end
