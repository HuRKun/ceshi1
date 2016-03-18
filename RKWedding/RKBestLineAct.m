//
//  RKBestLineAct.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/20.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestLineAct.h"

@implementation RKBestLineAct

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"xxhd_id"]) {
        return NO;
    }
    return YES;
}
@end
