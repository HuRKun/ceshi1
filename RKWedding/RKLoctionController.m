//
//  RKLoctionController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/25.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKLoctionController.h"
#import "UIBarButtonItem+RKCustomBBI.h"
#import "ChineseString.h"
#import "RKAppDelegate.h"
#import "RKGlobalDefine.h"
@interface RKLoctionController ()

@property (nonatomic, strong) NSMutableArray *addressArray;//!<市级地区数据
@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) NSDictionary *infon;


@end

@implementation RKLoctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIBarButtonItem *leftBBI = [UIBarButtonItem createImageBarButtomItemWithImage:[UIImage imageNamed:@"btn_nav_close"] taget:self action:@selector(leftDidClicked) CGRect:CGRectMake(0, 0, 18, 18)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    self.navigationItem.title = [NSString stringWithFormat:@"当前城市-%@",self.city];
    self.tableView.sectionIndexColor = [UIColor colorWithRed:209/255.0f green:52/255.0f blue:109/255.0f alpha:1];
    [self getAddressInfo];
  
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
 
}


- (void)leftDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.addressArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.addressArray[section];
    
    return arr.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
 
    NSArray *arr = self.addressArray[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *arr = @[@"定位城市",@"热门城市",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    UILabel *labei = [[UILabel alloc] init];
    labei.text = arr[section];
    labei.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0  blue:230/255.0  alpha:1];
    labei.frame = CGRectMake(0, 0, self.view.bounds.size.width, 15);
    return labei;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.addressArray[indexPath.section];
    NSString *str = arr[indexPath.row];
     [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(locationAddress:)]) {
        [self.delegate locationAddress:str];
    }
    
}
#pragma mark index
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
 NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
   
    return index+2;
    
}

#pragma mark - help
- (void)getAddressInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    self.addressArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    RKLoginManager *manage = [RKLoginManager shareManager];
    
    if (manage.islocation == YES) {
    
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:self.addressArray[0]];
            [arr replaceObjectAtIndex:1 withObject:manage.locationCity];
            
            [self.addressArray replaceObjectAtIndex:0 withObject:arr];

    }
    
}
#pragma mark - 懒加载
- (NSMutableArray *)addressArray
{
    if (_addressArray == nil) {
        _addressArray = [[NSMutableArray alloc] init];
        
    }
    return _addressArray;
}

@end
