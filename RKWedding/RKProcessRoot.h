//
//  RKProcessRoot.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/3/2.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "RKProcessVaribles.h"
@interface RKProcessRoot : JSONModel

@property (nonatomic, copy) NSString *Version;
@property (nonatomic, copy) NSString *Charset;
@property (nonatomic, strong) RKProcessVaribles *Variables;
@property (nonatomic, copy) NSString *Runtime;


@end
