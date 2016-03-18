//
//  RKParpareViewController.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKParpareViewController.h"
#import "RKGlobalDefine.h"
@interface RKParpareViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberLabelConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelConstrain;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSTimer *time;
@property (nonatomic, copy) NSString *servicer_num;//!< 记入资深统筹顾问的人数

@end

@implementation RKParpareViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        [self fetchNumbeDataFromServer];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筹备";
    self.constrainWidth.constant = kScreenWidth;
    self.constrainHeight.constant = kScreenHeight;
    self.labelConstrain.constant = kScreenWidth / 5.1;

    self.numberLabelConstrain.constant = kScreenWidth / 5.2;

    
    
    /**
     *  设置一个定时器改变数字
     *
     *  @param changerNumber 调用改变数字的方法
     *  @param userInfo  可以带参数
     *  @return 一个定时器
     */
//    self.time = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(changerNumber) userInfo:nil repeats:YES];
//    [self.time fire];
    
   self.time = [NSTimer scheduledTimerWithTimeInterval:0.00001 target:self selector:@selector(changerNumber) userInfo:nil repeats:YES];
}
- (void)changerNumber
{
    static NSInteger i=0;
    i++;
    if (i >=[self.servicer_num intValue]) {
        //停止定时器
        [self.time invalidate];
    }
    [UIView animateWithDuration:1 animations:^{
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)i];
    }];
    
}

- (void)fetchNumbeDataFromServer
{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    self.dataTask = [manage GET:@"http://data.halobear.cn/mapi/index.php?act=preparenav&mver=3" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.servicer_num = json[@"servicer_num"];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"筹备数据请求错误：%@",error);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)topDidClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    alert.message = @"此功能暂未开通，尽请期待!";
    [alert addButtonWithTitle:@"朕知道了"];
    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}

@end
