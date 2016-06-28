//
//  UIImage+Original.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "UIImage+Original.h"

@implementation UIImage (Original)

+ (UIImage *)imageWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

@end
