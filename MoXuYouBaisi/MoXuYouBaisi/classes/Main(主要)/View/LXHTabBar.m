//
//  LXHTabBar.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHTabBar.h"
#import "LXHPublishViewController.h"

@interface LXHTabBar ()

/**  */
@property (nonatomic , weak)UIButton *publishBtn;

@end
@implementation LXHTabBar

- (UIButton *)publishBtn
{
    if (_publishBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        
        [btn sizeToFit];
        [self addSubview:btn];
        _publishBtn = btn;
    }
    return _publishBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat barW = 1.0 * self.bounds.size.width / (self.items.count + 1);
    CGFloat barX = 0;
    CGFloat barY = 0;
    CGFloat barH = self.bounds.size.height;
    int count = 0;
    for (UIView *tabBar in self.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (count < 2) {
                barX = count * barW;
                tabBar.frame = CGRectMake( barX, barY, barW, barH);
            }else{
                barX = (count + 1) * barW;
                tabBar.frame = CGRectMake( barX, barY, barW, barH);
            }
            count++;
        }
    }
    self.publishBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)add
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addPublish" object:self];
}

@end
