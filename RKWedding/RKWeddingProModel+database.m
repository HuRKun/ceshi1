//
//  RKWeddingProModel+database.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/11.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKWeddingProModel+database.h"
#import "RKDatabaseManager.h"
@implementation RKWeddingProModel (database)


- (BOOL)saveDataForlocation
{
    NSString *sql = @"REPLACE INTO RKWeddingProTable(attachment,author,authorid,avatar,city,coverpath,dateline,dbdateline,digest,lastpost,lastposter,marrydate,message,readperm,replies,subject,tid,type,wdTypeid,views)VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    __block BOOL ret = NO;
    
    // 执行保存的SQL
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        ret =
        [db executeUpdate:sql,
         self.attachment,
         self.author,
         self.authorid,
         self.avatar,
         self.city,
         
         self.coverpath,
         self.dateline,
         self.dbdateline,
         self.digest,
         self.lastpost,
         
         self.lastposter,
         self.marrydate,
         self.message,
         self.readperm,
         self.replies,
         
         self.subject,
         self.tid,
         self.type,
         self.wdTypeid,
         self.views
         
         ];
    }];
    
    return ret;
}

+ (NSMutableArray *)getDataFromLocation
{
    NSString *sql = @"SELECT * FROM RKWeddingProTable ";
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        // 执行查询语句
        FMResultSet *rs = [db executeQuery:sql];
        
        
        // 遍历查询结果
        while ([rs next]) {
            
            RKWeddingProModel *model = [[RKWeddingProModel alloc] init];
            // 把数据填充到模型里
            [model configAppWithResultSet:rs];
            
            [result addObject:model];
        }
    }];
    
    return result;

}

#pragma mark - Helper Methods

- (void)configAppWithResultSet:(FMResultSet *)rs
{
    
    self.attachment = [rs stringForColumn:@"attachment"];
    self.author = [rs stringForColumn:@"author"];
    self.authorid = [rs stringForColumn:@"authorid"];
    self.avatar = [rs stringForColumn:@"avatar"];
    self.city = [rs stringForColumn:@"city"];
    
    self.coverpath = [rs stringForColumn:@"coverpath"];
    self.dateline = [rs stringForColumn:@"dateline"];
    self.dbdateline = [rs stringForColumn:@"dbdateline"];
    self.digest = [rs stringForColumn:@"digest"];
    self.lastpost = [rs stringForColumn:@"lastpost"];
    
    self.lastposter = [rs stringForColumn:@"lastposter"];
    self.marrydate = [rs stringForColumn:@"marrydate"];
    self.message = [rs stringForColumn:@"message"];
    self.readperm = [rs stringForColumn:@"readperm"];
    self.replies = [rs stringForColumn:@"replies"];
    
    self.subject = [rs stringForColumn:@"subject"];
    self.tid = [rs stringForColumn:@"tid"];
    self.type = [rs stringForColumn:@"type"];
    self.wdTypeid = [rs stringForColumn:@"wdTypeid"];
    self.views = [rs stringForColumn:@"views"];
}
@end
