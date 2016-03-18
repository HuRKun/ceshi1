//
//  UIImage+SaveToDirectory.h
//  测试
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SaveToDirectory)

-(UIImage *) getImageFromURL:(NSString *)fileURL;

-(NSString *) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

 -(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
@end
