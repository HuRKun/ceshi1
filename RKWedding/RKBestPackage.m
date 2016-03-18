//
//  RKBestPackage.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestPackage.h"

@implementation RKBestPackage

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"yhhd_id"]) {
        return NO;
    }
    return YES;
}
@end
