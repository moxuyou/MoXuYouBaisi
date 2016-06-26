//
//  LXHHeardViewButton.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/24.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHHeardViewButton.h"

@implementation LXHHeardViewButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted{}

@end
