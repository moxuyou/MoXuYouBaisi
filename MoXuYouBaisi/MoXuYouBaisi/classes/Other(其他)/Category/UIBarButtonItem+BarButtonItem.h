//
//  UIBarButtonItem+BarButtonItem.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItem)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)higthImage targer:(id)targer action:(SEL)seletor;
+ (instancetype)barButtonItemWithImage:(UIImage *)image seletImage:(UIImage *)higthImage targer:(id)targer action:(SEL)seletor;

@end
