//
//  RKAdcode.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKAdcode.h"
#import "RKDatabaseManager.h"
@implementation RKAdcode

+ (instancetype)provinceFromDatabaseWithName:(NSString *)provinceName
{
    NSString *sql = @"SELECT * FROM RKAdcodeTable WHERE cityname=?";
    
    __block RKAdcode *adcode = nil;
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        // 执行查询语句
        FMResultSet *rs = [db executeQuery:sql, provinceName];
        
        // 判断如果有数据就把数据填充到模型里
        if ([rs next]) {
            adcode = [[RKAdcode alloc] init];
            [adcode configAppWithResultSet:rs];
        }
    }];
    
    return adcode;
}

#pragma mark - Helper Methods

- (void)configAppWithResultSet:(FMResultSet *)rs
{
    self.cityname = [rs stringForColumn:@"cityname"];
    self.regionid = [rs stringForColumn:@"regionid"];

}

@end
