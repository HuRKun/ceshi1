//
//  RKVideoDetailController.m
//  Video WEDDING
//
//  Created by 胡荣坤 on 16/3/1.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKVideoDetailController.h"

#import "RKVideoDeatailCell.h"
#import "RKCollectListCell.h"
#import "commentListCell.h"
#import "RKShowNumpersonView.h"

#import "UILabel+LabelHeight.h"
#import "RKGlobalDefine.h"
#import "RKVideoDetailRoot.h"

#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define kRKShowNumpersonView @"RKShowNumpersonView"
#define kcommentListCell @"commentListCell"
#define kRKCollectListCell @"RKCollectListCell"
#define kRKVideoDeatailCell @"RKVideoDeatailCell"
@interface RKVideoDetailController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RKVideoDeatailCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;//!<视频详情页数据源
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;//!< 任务管理器

@property (nonatomic, assign) NSInteger current;//!<当前请求页数

@property (nonatomic ,strong) AVPlayer *player;

@end

@implementation RKVideoDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editNavigationItem];
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f  blue:230/255.0f  alpha:1];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self fetchDataFromServerWith:NO];
    
    [self.collectionView registerNib:[UINib nibWithNibName:kRKVideoDeatailCell bundle:nil] forCellWithReuseIdentifier:kRKVideoDeatailCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKCollectListCell bundle:nil] forCellWithReuseIdentifier:kRKCollectListCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kcommentListCell bundle:nil] forCellWithReuseIdentifier:kcommentListCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kRKShowNumpersonView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKShowNumpersonView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
  
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

- (void)fetchDataFromServerWith:(BOOL)isNext;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"hxjx":self.model.hxjx_id,
                                 @"page":isNext ? @(self.current+1):@(1)};
    
    self.dataTask = [manager GET:@"http://data.halobear.cn/mapi/index.php?act=hxjxinfo&mver=3&pageper=10" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            RKVideoDetailRoot *root = [[RKVideoDetailRoot alloc] initWithDictionary:obj error:&error];
            [self.dataSource addObject:root];
            [self.collectionView reloadData];
        }else{
            NSLog(@"视频模型数据错误");
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [UIView animateWithDuration:1 animations:^{
            [UILabel creareLableViewWithMessage:@"好像网络跑丢了,快去找找吧!" supView:self.view];
        }];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 3) {
        RKVideoDetailRoot *root = [self.dataSource firstObject];
        return root.commentlist.count;
    }else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RKVideoDeatailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKVideoDeatailCell forIndexPath:indexPath];
        cell.delegate = self;
        RKVideoDetailRoot *root = [self.dataSource firstObject];
        RKVideoDetailModel *model = root.hxjx;
        [cell configDataForCell:model NormalHeight:self.isVideo];
        
        return cell;
    }else if (indexPath.section == 1){
        
        RKCollectListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRKCollectListCell forIndexPath:indexPath];
        RKVideoDetailRoot *root = [self.dataSource firstObject];

        [cell refreshWithData:root.collectlist];
        return cell;
        
    }else{
        commentListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcommentListCell forIndexPath:indexPath];
        RKVideoDetailRoot *root = [self.dataSource firstObject];
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
    RKVideoDetailRoot *root = [self.dataSource firstObject];
    RKShowNumpersonView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRKShowNumpersonView forIndexPath:indexPath];
    if (indexPath.section == 1) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSString *string = [NSString stringWithFormat:@"%ld 人喜欢",(unsigned long)root.collectlist.count];
            head.commentLabel.text = string;
            return head;
        }
    }else if (indexPath.section == 2){
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSString *string = [NSString stringWithFormat:@"%ld 人喜欢",root.commentlist.count];
            head.commentLabel.text = string;
            return head;
        }
    }else{
        NSString *string = @"";
        head.commentLabel.text = string;
        return nil;
    }
    return nil;
    
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (self.isVideo == YES) {
            //计算Label的高度
            RKVideoDetailRoot *root = [self.dataSource firstObject];
            RKVideoDetailModel *model = root.hxjx;
            UIFont *font = [UIFont systemFontOfSize:14.0f];
            
            CGRect labelH = [UILabel calculateLabelWithContentForHeight:model.wdDescription width:kScreenWidth - 20 font:font];
            
            return CGSizeMake(self.view.bounds.size.width - 20, 186+54+labelH.size.height);
        }else{
            RKVideoDetailRoot *root = [self.dataSource firstObject];
            RKVideoDetailModel *model = root.hxjx;
            //计算图片的高度
            //1.得到图片的url
            NSDictionary *dic= [NSString extractWithString:model.default_image];
            NSString *height = [dic valueForKey:@"w"];

            if ([height integerValue] <400) {
                 return CGSizeMake(kScreenWidth - 20, 200 + 54);
            }else{
                return CGSizeMake(kScreenWidth - 20, 540 + 54);
            }
            
        }
        
    }else if (indexPath.section == 1)
    {
        return CGSizeMake(kScreenWidth - 20, 60);
    }else
    {
        return CGSizeMake(kScreenWidth - 20, 50);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kScreenWidth - 20, 0);
    }else{
        return CGSizeMake(kScreenWidth - 20, 21);
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
#pragma mark - RKVideoDeatailCellDelegate

- (void)playBtnDidClickedWithVideoUrl:(NSString *)url
{
    
    MPMoviePlayerViewController *m = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    NSLog(@"正在播放");
    // present控制器:
    [self presentViewController:m animated:YES completion:nil];
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
