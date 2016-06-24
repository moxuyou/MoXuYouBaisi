//
//  LXHLoginView.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHLoginView.h"

@implementation LXHLoginView

+ (instancetype)loginView
{
    LXHLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"LXHLoginView" owner:nil options:nil] lastObject];
    return view;
    
}

+ (instancetype)registerView
{
    LXHLoginView *view = [[[NSBundle mainBundle] loadNibNamed:@"LXHLoginView" owner:nil options:nil] firstObject];
    return view;
    
}

@end
