//
//  RKWeddingDetailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/22.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingDetailController.h"
#import "RKCompanyDetailController.h"
#import "RKNotFailController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "RKWeddingModel.h"
#import "RKWeddingDetailRoot.h"
#import "RKImageCell.h"

#import "RKHeadViewCell.h"
#import "RKCollectListCell.h"
#import "commentListCell.h"
#import "RKShowNumpersonView.h"

#import "MSSBrowseCollectionViewCell.h"

#define kRKShowNumpersonView @"RKShowNumpersonView"
#define kcommentListCell @"commentListCell"
#define kRKCollectListCell @"RKCollectListCell"
#define kRKImageCell @"RKImageCell"
#define kRKHeadViewCell @"RKHeadViewCell"
@interface RKWeddingDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RKHeadViewCellDelegate>


@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSMutableArray *dataSource;//!< 照片的数据源

@property (nonatomic, assign) NSInteger cunrrentPage;


@property (nonatomic, strong) NSMutableArray *decriptionSource;//!< 简介的数据源

@property (nonatomic, strong) NSMutableArray *collectSource;//!< 喜欢的数据源

@property (nonatomic, strong) NSMutableArray *commentSource;//!< 评论的数据源

@end

@implementation RKWeddingDetailController


- (void)viewDidLoad {
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    self.navigationController.transparentBackgroundView.backgroundColor = [UIColor whiteColor];
    [self fetchDataForNextPageFromServer:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1];
    [self editNavigationItem];
    
    
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:kRKImageCell bundle:nil] forCellWithReuseIdentifier:kRKImageCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKHeadViewCell bundle:nil] forCellWithReuseIdentifier:kRKHeadViewCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCollectListCell bundle:nil] forCellWithReuseIdentifier:kRKCollectListCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kcommentListCell bundle:nil] forCellWithReuseIdentifier:kcommentListCell];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKShowNumpersonView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKShowNumpersonView];
    

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //在页面消失时 取消界面数据请求，以免不必要的浪费
    [self.dataTask cancel];
}
// 设置导航栏的内容
- (void) editNavigationItem
{

    UIBarButtonItem *shareBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_be_share"] taget:self action:@selector(shareBBIDidClicked) CGRect:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem *fixedBBI = [UIBarButtonItem createFixedBackBarButtomItemWithWidth:15];
    UIBarButtonItem *likeBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_dis_listlike_n@3x"] taget:self action:@selector(likeBBIDidClicked) CGRect:CGRectMake(0, 0, 18, 16)];
    self.navigationItem.rightBarButtonItems = @[likeBBI,fixedBBI,shareBBI];
}
//喜欢  被点击
- (void)likeBBIDidClicked
{
   //如果没有登陆要跳到登陆界面
}
//分享  被点击
- (void)shareBBIDidClicked
{
    RKShareViewController *vc = [[RKShareViewController alloc] initWithNibName:@"RKShareViewController" bundle:nil];
    NSLog(@"%@",NSStringFromCGRect(vc.view.bounds));
    [self.navigationController rk_addChildViewController:vc inRect:kScreenBounds];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchDataForNextPageFromServer:(BOOL)isNext
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //设置响应解析器
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"act":@"hxjxinfo",
                                 @"hxjx":self.model.hxjx_id,
                                 @"page":isNext ? @(self.cunrrentPage+1) : @(1),
                                 @"pageper":@"10"};

    [manage GET: API parameters:parameters success:^(NSURLSessionDataTask *  task, id  responseObject) {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSError *error = nil;
        RKWeddingDetailRoot *root = [[RKWeddingDetailRoot alloc] initWithDictionary:jsonObj error:&error];
        [self.dataSource addObject:root];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}
#pragma mark - UICollectionViewDataSource(数据源代理)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    RKWeddingDetailRoot *root = [self.dataSource firstObject];
    NSArray *comment = root.commentlist;
    NSArray *images = root.hxjx._images;
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return images.count;
    }else if (section == 2){
        return 1;
    }else{
        return comment.count;
    }
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKImageCell forIndexPath:indexPath];
    RKHeadViewCell *headCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKHeadViewCell forIndexPath:indexPath];
    RKWeddingDetailRoot *root = [self.dataSource firstObject];
    if (indexPath.section == 0) {
        headCell.delegate = self;
        RKWeddingDtail *model = root.hxjx;
        [headCell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
        headCell.hxjxLabel.text = model.hxjx_name;
        NSString *title = [NSString stringWithFormat:@"  %@  ",model.company_name];
        [headCell.companyBtn setTitle:title forState:UIControlStateNormal];

        headCell.descripLabel.text = model.wdDescription;
        
        return headCell;
        
    }else if (indexPath.section == 1){
        RKWeddingDetailRoot *root = [self.dataSource firstObject];
        NSArray *images = root.hxjx._images;
        RKImageModel *model = images[indexPath.row];
        NSString *imageStr = model.image_url_m;
        NSURL *url = [NSURL URLWithString:imageStr];
        [cell.image_url sd_setImageWithURL:url];
        return cell;
    }else if (indexPath.section == 2){
        
        RKCollectListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCollectListCell forIndexPath:indexPath];
        RKWeddingDetailRoot *root = [self.dataSource firstObject];
        
        [cell refreshWithData:root.collectlist];
        return cell;
        
    }else{
        commentListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcommentListCell forIndexPath:indexPath];
        RKWeddingDetailRoot *root = [self.dataSource firstObject];
        if (root.commentlist.count <= 0) {
            
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            return cell;
            
        }else{
            commentListModel *model = root.commentlist[indexPath.row];
            [cell cofigDataForCell:model];
    
            
            return cell;
        }
    }

    
}
#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RKWeddingDetailRoot *root = [self.dataSource firstObject];
    RKShowNumpersonView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKShowNumpersonView forIndexPath:indexPath];
    if (indexPath.section == 2) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSString *string = [NSString stringWithFormat:@"%ld 人喜欢",(unsigned long)root.collectlist.count];
            head.commentLabel.text = string;
            return head;
        }
    }else if (indexPath.section == 3){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSString *string = [NSString stringWithFormat:@"%ld 人喜欢",root.commentlist.count];
            head.commentLabel.text = string;
            return head;
        }
    }else{
        return nil;
    }
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        RKWeddingDetailRoot *root = [self.dataSource firstObject];
        NSMutableArray *bigUrlArray = [NSMutableArray array];
        RKImageCell *cell = (RKImageCell *)[collectionView cellForItemAtIndexPath:indexPath];

        for (RKImageModel *model in root.hxjx._images) {
            [bigUrlArray addObject:model.image_url];
        }
        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
        int i = 0;
        for(i = 0;i < [bigUrlArray count];i++)
        {
            
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            browseItem.bigImageUrl = bigUrlArray[i];// 大图url地址

            browseItem.smallImageView = cell.image_url;
            [browseItemArray addObject:browseItem];
        }
        
        MSSBrowseViewController *bvc = [[MSSBrowseViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
        [bvc showBrowseViewController];
        
    }
}
    

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKWeddingDetailRoot *root = [self.dataSource firstObject];
    if (indexPath.section == 0) {
        RKWeddingDtail *model = root.hxjx;
      CGRect label = [UILabel calculateLabelWithContentForHeight:model.wdDescription width:kScreenWidth - 16 font:[UIFont systemFontOfSize:14]];
        return CGSizeMake(kScreenWidth, 300 + label.size.height );
    }else if (indexPath.section == 1){
        NSArray *images = root.hxjx._images;
        RKImageModel *model = images[indexPath.row];
        CGFloat height = [model.height integerValue];
        return CGSizeMake(self.view.bounds.size.width - 20, height*0.4);
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth - 20, 60);
    }else
    {
        return CGSizeMake(kScreenWidth - 20, 50);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return CGSizeMake(kScreenWidth - 20, 21);
    }
    return CGSizeMake(kScreenWidth - 20, 0);
}
#pragma mark - RKHeadViewCellDelegate

-(void)companyBtnDidTriggerWith:(RKHeadViewCell *)cell
{
    RKWeddingDetailRoot *root = [self.dataSource firstObject];
    RKWeddingDtail *model = root.hxjx;
    if (![model.company_id isEqualToString:@"0"]) {
        RKCompanyDetailController *vc = [[RKCompanyDetailController alloc] initWithNibName:@"RKCompanyDetailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        vc.company = model.company_id;
    }else{
        RKNotFailController *vc = [[RKNotFailController alloc] initWithNibName:@"RKNotFailController" bundle:nil];
        RKNavigationController *nav = [[RKNavigationController alloc] initWithRootViewController:vc];
        [vc showMessage];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

#pragma mark - Setter & Getter
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc ] init];
    }
    return _dataSource;
}
- (NSMutableArray *)decriptionSource
{
    if (_decriptionSource == nil) {
        _decriptionSource = [[NSMutableArray alloc ] init];
    }
    return _decriptionSource;
}
- (NSMutableArray *)collectSource
{
    if (_collectSource == nil) {
        _collectSource = [[NSMutableArray alloc ] init];
    }
    return _collectSource;
}
- (NSMutableArray *)commentSource
{
    if (_commentSource == nil) {
        _commentSource = [[NSMutableArray alloc ] init];
    }
    return _commentSource;
}
@end
