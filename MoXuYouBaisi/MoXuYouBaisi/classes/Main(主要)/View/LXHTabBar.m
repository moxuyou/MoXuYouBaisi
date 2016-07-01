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
/**  */
@property (nonatomic , strong)UITabBar *currentSelectTabBar;

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
    for (UIControl *tabBar in self.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (count == 0 && self.currentSelectTabBar == nil) {
                self.currentSelectTabBar = (UITabBar *)tabBar;
            }
            //空出第3个位置给中间的按钮
            if (count < 2) {
                barX = count * barW;
                tabBar.frame = CGRectMake( barX, barY, barW, barH);
            }else{
                barX = (count + 1) * barW;
                tabBar.frame = CGRectMake( barX, barY, barW, barH);
            }
            count++;
            
            //添加选中监听，用于点击刷新界面数据
            [tabBar addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
    self.publishBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)add
{
    //发送通知，让中间的按钮弹出界面
    [[NSNotificationCenter defaultCenter] postNotificationName:LXHShowPresonViewConctroller object:self];
}

- (void)tabBarClick:(UITabBar *)tabBar
{
    if (tabBar == self.currentSelectTabBar){
        //发出通知，用于控制点击刷新界面
        [[NSNotificationCenter defaultCenter] postNotificationName:LXHReflashViewByTabbarClick object:self];
    };
    
    self.currentSelectTabBar = tabBar;
}

@end
