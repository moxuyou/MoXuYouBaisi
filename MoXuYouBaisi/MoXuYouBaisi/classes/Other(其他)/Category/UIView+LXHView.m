//
//  UIView+LXHView.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "UIView+LXHView.h"

@implementation UIView (LXHView)

- (CGFloat)LXHWidth
{
    return self.bounds.size.width;
}

- (void)setLXHWidth:(CGFloat)LXHWidth
{
    CGRect frame = self.frame;
    frame.size.width = LXHWidth;
    self.frame = frame;
}

- (CGFloat)LXHHeight
{
    return self.bounds.size.height;
}

- (void)setLXHHeight:(CGFloat)LXHHeight
{
    CGRect frame = self.frame;
    frame.size.height = LXHHeight;
    self.frame = frame;
}

- (CGFloat)LXHX
{
    return self.bounds.origin.x;
}

- (void)setLXHX:(CGFloat)LXHX
{
    CGRect frame = self.frame;
    frame.origin.x = LXHX;
    self.frame = frame;
}

- (CGFloat)LXHY
{
    return self.bounds.origin.y;
}

- (void)setLXHY:(CGFloat)LXHY
{
    CGRect frame = self.frame;
    frame.origin.y = LXHY;
    self.frame = frame;
}

- (CGFloat)LXHCenterX
{
    return self.center.x;
}

- (void)setLXHCenterX:(CGFloat)LXHCenterX
{
    CGPoint point = self.center;
    point.x = LXHCenterX;
    self.center = point;
}

- (CGFloat)LXHCenterY
{
    return self.center.y;
}

- (void)setLXHCenterY:(CGFloat)LXHCenterY
{
    CGPoint point = self.center;
    point.y = LXHCenterY;
    self.center = point;
}


@end
