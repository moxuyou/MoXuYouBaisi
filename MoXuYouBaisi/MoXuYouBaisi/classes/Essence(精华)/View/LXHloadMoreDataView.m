//
//  LXHloadMoreDataView.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/27.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHloadMoreDataView.h"

@implementation LXHloadMoreDataView

+ (instancetype)loadMoreDataView
{
    LXHloadMoreDataView *view = [[[NSBundle mainBundle] loadNibNamed:@"LXHloadMoreDataView" owner:nil options:nil] lastObject];
    
    return view;
}

@end
