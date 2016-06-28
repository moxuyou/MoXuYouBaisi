//
//  UIImage+Original.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Original)

/**返回一个不被渲染的image，也可以在image对应的属性上面设置*/
+ (UIImage *)imageWithOriginal:(NSString *)imageName;

@end
