//
//  UIImage+SaveToDirectory.m
//  测试
//
//  Created by 胡荣坤 on 16/2/21.
//  Copyright © 2016年 HuRongKun. All rights reserved.
//

#import "UIImage+SaveToDirectory.h"

@implementation UIImage (SaveToDirectory)
//根据图片的网络地址  下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}


-(NSString *) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    NSString *name = nil;
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        
        NSString *name = [NSString stringWithFormat:@"%@.%@", imageName, @"png"];
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:name] options:NSAtomicWrite error:nil];
        NSLog(@"name %@",name);
        return name;
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        NSString *name = [NSString stringWithFormat:@"%@.%@", imageName, @"jpg"];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:name] options:NSAtomicWrite error:nil];
         NSLog(@"name %@",name);
        return name;
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
        return name;
    }
    
    
}

//从本地获取图片
- (UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

@end
