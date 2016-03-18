//
//  RKWeddingSubRoot.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/28.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKWeddingSubDtail.h"
#import "RKWeddingSubDtail2.h"

@interface RKWeddingSubRoot : JSONModel

@property (nonatomic, assign) BOOL wdTrue;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) RKWeddingSubDtail *hlzt;

@property (nonatomic, strong) NSMutableArray<RKWeddingSubDtail2 *> *hls;

@property (nonatomic, copy) NSString *usedms;

@end

