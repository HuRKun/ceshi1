//
//  RKFirstViewInfoList.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKFirstViewInfoList.h"
#import "RKDatabaseManager.h"
@implementation RKFirstViewInfoList



+ (instancetype)InfoListFromDatabaseWithName:(NSString *)name
{
    NSString *sql = @"SELECT * FROM FirstViewInfoList WHERE name=?";
    __block RKFirstViewInfoList *list = nil;
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        //执行查询语句
        FMResultSet *rs = [db executeQuery:sql,name];
        
        while ([rs next]) {
            
            list = [[RKFirstViewInfoList alloc] init];
            [list configAppWithResultSet:rs];
            
        }
        
    }];
    return list;
}


#pragma mark - Helper Methods

- (void)configAppWithResultSet:(FMResultSet *)rs
{
    self.name = [rs stringForColumn:@"name"];
    self.info1 = [rs stringForColumn:@"info1"];
    self.info2 = [rs stringForColumn:@"info2"];
    self.picname = [rs stringForColumn:@"picname"];
    self.type = [rs intForColumn:@"type"];
    self.indexintype = [rs stringForColumn:@"indexintype"];
}



@end
