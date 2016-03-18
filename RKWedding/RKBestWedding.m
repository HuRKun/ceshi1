//
//  RKBestWedding.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKBestWedding.h"

@implementation RKBestWedding

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"hxjx_id"]) {
        return NO;
    }
    return YES;
}
@end
