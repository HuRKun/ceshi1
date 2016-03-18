//
//  RKWeddingSubDetailController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingSubDetailController.h"
#import "RKGlobalDefine.h"
#import "NetAPI.h"
#import "RKWeddingSubDtail.h"
#import "RKWeddingSubRoot.h"
#import "RKHeadImageModel.h"
#import "RKWddingSubDetailTopCell.h"
#import "RKWddingSubDetailCell.h"
#define kRKWddingSubDetailTopCell @"RKWddingSubDetailTopCell"
#define kRKWddingSubDetailCell @"RKWddingSubDetailCell"
@interface RKWeddingSubDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//任务管理
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSMutableArray *dataSource;//!< 详情页数据源

@end

@implementation RKWeddingSubDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.transparentBackgroundView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
    [self editNavigationItem];
    //数据请求
    [self fetchDataFromServer];
   // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:kRKWddingSubDetailCell bundle:nil] forCellWithReuseIdentifier:kRKWddingSubDetailCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKWddingSubDetailTopCell bundle:nil] forCellWithReuseIdentifier:kRKWddingSubDetailTopCell];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //在页面消失时 取消界面数据请求，以免不必要的浪费
    [self.dataTask cancel];
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

- (void)editNavigationItem
{
    UIBarButtonItem *shareBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_be_share"] taget:self action:@selector(shareBBIDidClicked) CGRect:CGRectMake(0, 0, 25, 25)];
    self.navigationItem.rightBarButtonItem = shareBBI;
}
#pragma mark - 数据请求

- (void)fetchDataFromServer
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"act":@"hlztinfo",
                                 @"hlzt": self.isBanner ? self.bannerModel.item_id : self.model.hlzt_id,
                                 @"mver":@"3"};
   self.dataTask = [manager GET:API parameters:parameters success:^(NSURLSessionDataTask *  task, id responseObject) {
       NSError *error = nil;
       id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
       if (error == nil) {
           RKWeddingSubRoot *root = [[RKWeddingSubRoot alloc] initWithDictionary:jsonObj error:&error];
           if (error == nil) {
               [self.dataSource addObject:root];
               [self.collectionView reloadData];
           }else{
               NSLog(@"模型数据出错：%@",error);
           }
       }
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    RKWeddingSubRoot *root = [self.dataSource firstObject];
    NSArray *arr = root.hls;
    if (section == 0) {
        return 1;
    }else{
         return arr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RKWeddingSubRoot *root = [self.dataSource firstObject];
    if (indexPath.section == 0) {
        RKWddingSubDetailTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKWddingSubDetailTopCell forIndexPath:indexPath];
        
        [cell.topimageView sd_setImageWithURL:[NSURL URLWithString:root.hlzt.default_image]];
        cell.descriptionLabel.text = root.hlzt.wdDescription;
//        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }else{
    RKWddingSubDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKWddingSubDetailCell forIndexPath:indexPath];
    NSArray *arr = root.hls;
    
    [cell filDataFromCell:arr index:indexPath.row];
    
    return cell;
    }
    
}

#pragma mark <UICollectionViewDelegate>


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RKWeddingSubRoot *root = [self.dataSource firstObject];
    
    if (indexPath.section == 0) {
        
        RKWeddingSubDtail *model = root.hlzt;
        NSString *text = model.wdDescription;
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize constraintsSize = CGSizeMake(kScreenWidth - 20, MAXFLOAT);
        CGRect itemHeight = [text boundingRectWithSize:constraintsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
        return CGSizeMake(kScreenWidth, 182 + itemHeight.size.height + 30 );
        
    }else{
        NSArray *arr = root.hls;
        RKWeddingSubDtail2 *model = arr[indexPath.row];
        NSString *text = model.wdDescription;
        UIFont *font = [UIFont systemFontOfSize:14];
        CGSize constraintsSize = CGSizeMake(284.0f, MAXFLOAT);
        CGRect itemHeight = [text boundingRectWithSize:constraintsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
        //这边要计算每个具体的大小
        return CGSizeMake(kScreenWidth - 20, 62+286+68+itemHeight.size.height);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    }
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
