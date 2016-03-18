//
//  RKCity.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKCity.h"

@implementation RKCity

//获得该城市模型
+ (instancetype)cityFromDatabaseWithRegion_name:(NSString *)region_name
{
     NSString *sql = @"SELECT * FROM CityTable WHERE region_name=?";
    __block RKCity *city = nil;
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        //执行查询语句
        FMResultSet *rs = [db executeQuery:sql,region_name];
        
        while ([rs next]) {
            
            city = [[RKCity alloc] init];
            [city configAppWithResultSet:rs];
            
         }
        
    }];
    return city;
}

+ (NSArray *)cityFromDatabaseWithParent_id:(NSInteger)parent_id
{
    NSString *sql = @"SELECT * FROM CityTable WHERE parent_id=?";
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [[RKDatabaseManager shareManager].databaseQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:sql,@(parent_id)];
        
        while ([rs next]) {
            RKCity *city = [[RKCity alloc] init];
            [city configAppWithResultSet:rs];
            [arr addObject:city];
        
        }
        
    }];
    return arr;
}

#pragma mark - Helper Methods

- (void)configAppWithResultSet:(FMResultSet *)rs
{
    self.region_name = [rs stringForColumn:@"region_name"];
    self.region_code = [rs stringForColumn:@"region_code"];
    self.region_id = [rs intForColumn:@"region_id"];
    self.parent_id = [rs intForColumn:@"parent_id"];
    self.sort_order = [rs intForColumn:@"sort_order"];
}


@end
