//
//  NSString+RKExtractString.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "NSString+RKExtractString.h"

@implementation NSString (RKExtractString)


+(NSDictionary *)extractWithString:(NSString *)imageUrl
{
    NSArray *arr = [imageUrl componentsSeparatedByString:@"?"];
    NSString *str = [arr lastObject];
    NSArray *arr1 = [str componentsSeparatedByString:@"/"];
    NSMutableArray *keyArr = [[NSMutableArray alloc] init];
    NSMutableArray *valueArr = [[NSMutableArray alloc] init];
    for (int i=0; i<arr1.count; i=i+2) {
        [keyArr addObject:arr1[i]];
        [valueArr addObject:arr1[i+1]];
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:valueArr forKeys:keyArr];
    return dic;

}

+ (NSArray *)extractWithRegionName:(NSString *)regionName
{
    NSArray *arr = [regionName componentsSeparatedByString:@"\t"];
    return arr;
}

@end
