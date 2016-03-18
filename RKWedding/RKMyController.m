//
//  RKMyController.m
//  ceshi1
//
//  Created by 胡荣坤 on 16/2/29.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKMyController.h"
#import "TransparentNavigationController.h"
#import "RKLoginViewController.h"
#import "RKMyControllerHeadView.h"
#import "RKGlobalDefine.h"
#import "RKLoginManager.h"
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)
@interface RKMyController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) RKMyControllerHeadView *headImageView;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation RKMyController

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadData];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(leaveDidClicked)];
    self.navigationItem.rightBarButtonItem = bbi;
    
    //把导航栏背景设置成白色
    self.navigationController.transparentBackgroundView.backgroundColor = [UIColor purpleColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.headImageView = [[NSBundle mainBundle] loadNibNamed:@"RKMyControllerHeadView" owner:nil options:nil][0];
    
    self.headImageView.frame = CGRectMake(0, -270, kScreenWidth, 270);
    self.coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
    self.coverImageView.frame = CGRectMake(0, -270, kScreenWidth, 270);
    self.coverImageView.alpha = 1;
    [self.collectionView insertSubview:self.coverImageView atIndex:0];

    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;


    [self.collectionView addSubview:self.headImageView];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(270, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setNavigationBarTransparentWithCContentOffset:self.collectionView.contentOffset];
    
    
}

- (void)leaveDidClicked
{
    [RKLoginManager shareManager].islogin = NO;
    [RKUserManager shareManager].username = nil;
    [RKUserManager shareManager].headImage = nil;
    [self fetchDataFromServer];
    self.tabBarController.selectedIndex = 0;
    
}

- (void)reloadData
{
    self.navigationItem.title = [RKUserManager shareManager].username;
}
#pragma mark - 数据请求

- (void)fetchDataFromServer
{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *formhash = [RKUserManager shareManager].formhash;
    
    NSDictionary *params = @{@"channelid": @"0",
                             @"mver": @"3",
                             @"type":@"1",
                             @"formhash":formhash};

    
    [manage POST:@"http://circle.halobear.cn/api/mobile/index.php?version=4&module=pushbinduser" parameters:params success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",obj[@"Message"][@"messagestr"]);
        NSLog(@"%@",obj);
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //网络连接错误
    }];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setNavigationBarTransparentWithCContentOffset:scrollView.contentOffset];

    
    if (scrollView.contentOffset.y < -270) {
        CGFloat y = 0.01;
        CGFloat p = (-scrollView.contentOffset.y - 270) *y;

        self.coverImageView.transform = CGAffineTransformMakeScale(1+p, 1+p);
        self.headImageView.frame = CGRectMake(0,-270, kScreenWidth,-scrollView.contentOffset.y);
//        NSLog(@"frame =%@",NSStringFromCGRect(self.coverImageView.frame));
//        NSLog(@"frame =%@",NSStringFromCGRect(self.collectionView.frame));
      
    }
}

- (void)setNavigationBarTransparentWithCContentOffset:(CGPoint)contentOffest
{
    //透明度的比例
    CGFloat p = (contentOffest.y + 270) / (270.0f - 64);
    self.navigationController.transparentBackgroundView.alpha = p;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:256/255.0f green:256/255.0f  blue:256/255.0f  alpha:1];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
    
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
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
