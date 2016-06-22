//
//  LXHMineViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMineViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "LXHSettingViewController.h"

@interface LXHMineViewController ()

@end

@implementation LXHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIBarButtonItem *settingItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] seletImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setting)];
    UIBarButtonItem *sunItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] seletImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(sun:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,sunItem];
    
    self.navigationItem.title = @"我的";
}

- (void)setting
{
//    NSLog(@"%s",__func__);
    LXHSettingViewController *vc = [[LXHSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sun:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
//    NSLog(@"%s",__func__);
}

@end
