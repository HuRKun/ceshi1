//
//  NSString+RKExtractString.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RKExtractString)

/**
 *  根据网上图片的url 取出对应图片高度的子串
 *
 *  @param imageUrl 图片的url
 *
 *  @return 图片的高度
 */
+ (NSDictionary *)extractWithString:(NSString *)imageUrl;

/**
 *  切割字符串的辅助方法
 *
 *  @param regionName
 *
 *  @return 一个数组
 */
+ (NSArray *)extractWithRegionName:(NSString *)regionName;


@end
