//
//  NetAPI.h
//  RKWedding
//
//  Created by 胡荣坤 on 16/2/27.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#ifndef NetAPI_h
#define NetAPI_h

//幻熊域名API
#define API @"http://data.halobear.cn/mapi/index.php"
/**********************   精选  ****************************/
//广告栏  GET
#define FIRSTBANNER @"http://data.halobear.cn/mapi/index.php?adcode=440304&act=banner&cate=5&mver=3"
//首页API  GET
#define FIRSTPaAGEAPI @"http://data.halobear.cn/mapi/index.php?act=choicenav&mver=3"
//线下活动详情页
#define XIANXIA @"http://www.halobear.cn/mp/youhui"

#define COMPANY @"http://data.halobear.cn/mapi/index.php?act=companyinfo&mver=3"
/**********************   发现  ****************************/
//广告栏
#define DISCOVERBANNER @"http://data.halobear.cn/mapi/index.php?act=banner&cate=6&adcode=&mver=3"

//酒店 婚纱摄影 婚庆公司的AP1
#define DISCOVER @"http://data.halobear.cn/mapi/index.php?&mver=3&sort=dayhot"

#define HOTELlIST @"http://data.halobear.cn/mapi/index.php?&lat=0&lng=0&mver=3"


/**********************   登入注册  ****************************/
//获取验证码
#define CODE @"http://circle.halobear.cn/api/mobile/index.php?module=sms&version=4"

//注册接口   POST
#define REGISTER  @"http://circle.halobear.cn/api/mobile/index.php?module=register&mod=register&version=4"
//登陆接口   POST
#define LOGIN  @"http://circle.halobear.cn/api/mobile/index.php?loginfield=auto&charset=utf-8&version=3&loginsubmit=yes&mobile=yes&module=login"

#endif /* NetAPI_h */

