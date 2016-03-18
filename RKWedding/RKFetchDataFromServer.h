//
//  RKFetchDataFromServer.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/19.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/**
 *  这个类只要是从服务器请求数据的
 */
@interface RKFetchDataFromServer : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;//!< 数据请求的任务，为了方便在必要的时候，取消当前的请求

/**
 *  给外面提供一个借口请求数据
 *
 *  @param urlString <#urlString description#>
 *
 *  @return <#return value description#>
 */
//+ (id)fetchDataFromServerWithGET:(NSString *)urlString;
//
//
//+ (id)fetchDataFromServerWithPOST:(NSString *)urlString parmars:(NSDictionary *)parmars;

@end
