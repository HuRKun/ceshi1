//
//  RKHeadImageModel.m
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "RKHeadImageModel.h"

@implementation RKHeadImageModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"item_id"]) {
        return NO;
    }
    return YES;
}
@end
