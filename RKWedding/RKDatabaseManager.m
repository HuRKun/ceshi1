//
//  RKDatabaseManager.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKDatabaseManager.h"

@implementation RKDatabaseManager

+(instancetype)shareManager
{
    static RKDatabaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RKDatabaseManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        //数据存放路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath = [path stringByAppendingPathComponent:@"WDDataSql.sqlite"];
        
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
        // 要执行的SQL语句，要放在Block里执行，用inDatabase不用手动打开数据库
        [self.databaseQueue inDatabase:^(FMDatabase *db) {
            
            // 建表
            NSString *createCityTableSQL = @"CREATE TABLE IF NOT EXISTS CityTable (region_id integer,region_code text,region_name text,parent_id integer,sort_order integer)";
            
            BOOL ret =
            [db executeUpdate:createCityTableSQL];
            if (ret == YES) {
                NSLog(@"建表成功!");
            } else {
                NSLog(@"建表失败!");
            }
            // 建表
            NSString *createFirstViewInfoListSQL = @"CREATE TABLE IF NOT EXISTS FirstViewInfoList (name text,info1 text,info2 text DEFAULT(null),picname text,type integer,indexintype text)";
            BOOL result =
            [db executeUpdate:createFirstViewInfoListSQL];
            if (result == YES) {
                NSLog(@"建表成功!");
            } else {
                NSLog(@"建表失败!");
            }
        }];
        
        
        
    }
    
    return self;

}
@end
