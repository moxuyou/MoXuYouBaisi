//
//  LXHTabBarController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHTabBarController.h"
#import "LXHEssenceViewController.h"
#import "LXHFriendTrendsViewController.h"
#import "LXHMineViewController.h"
#import "LXHNewViewController.h"
#import "LXHPublishViewController.h"
#import "UIImage+Original.h"
#import "LXHTabBar.h"
#import "LXHNavigationController.h"

@interface LXHTabBarController ()

@end

@implementation LXHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPublish) name:@"addPublish" object:nil];
    
    //设置子控制器
    [self setUpChildViewController];
    
    //设置tabBarItem属性
    [self setUpTabBarItem];
    
    //设置导航条
    LXHTabBar *tabBar = [[LXHTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
}

#pragma mark - 设置子控制器
- (void)setUpChildViewController
{
    //精华
    LXHEssenceViewController *essenceVc = [[LXHEssenceViewController alloc] init];
    LXHNavigationController *essenceNav = [[LXHNavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:essenceNav];
    
    //新帖
    LXHNewViewController *newVc = [[LXHNewViewController alloc] init];
    LXHNavigationController *newNav = [[LXHNavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:newNav];
    
    //发布
//    LXHPublishViewController *publishVc = [[LXHPublishViewController alloc] init];
//    [self addChildViewController:publishVc];
    
    //关注
    LXHFriendTrendsViewController *friendTrendsVc = [[LXHFriendTrendsViewController alloc] init];
    LXHNavigationController *friendTrendsNav = [[LXHNavigationController alloc] initWithRootViewController:friendTrendsVc];
    [self addChildViewController:friendTrendsNav];
    
    //我
    LXHMineViewController *mineVc = [[LXHMineViewController alloc] init];
    LXHNavigationController *mineNav = [[LXHNavigationController alloc] initWithRootViewController:mineVc];
    [self addChildViewController:mineNav];
    
}

#pragma mark -设置tabBarItem属性
- (void)setUpTabBarItem
{
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    //精华
    LXHNavigationController *essenceNav = self.childViewControllers[0];
    essenceNav.tabBarItem.title = @"精华";
    essenceNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_essence_icon"];
    essenceNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_essence_click_icon"];
    
    //新帖
    LXHNavigationController *newNav = self.childViewControllers[1];
    newNav.tabBarItem.title = @"新帖";
    newNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_new_icon"];
    newNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_new_click_icon"];
    
    //发布
//    LXHPublishViewController *publishVc = self.childViewControllers[2];
//    
//    [publishVc.tabBarItem setImageInsets:UIEdgeInsetsMake(7, 0, -7, 0)];
//    publishVc.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_publish_icon"];
//    publishVc.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_publish_click_icon"];
    
    //关注
    LXHNavigationController *friendTrendsNav = self.childViewControllers[2];
    friendTrendsNav.tabBarItem.title = @"关注";
    friendTrendsNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_friendTrends_icon"];
    friendTrendsNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_friendTrends_click_icon"];
    
    //我
    LXHNavigationController *mineNav = self.childViewControllers[3];
    mineNav.tabBarItem.title = @"我";
    mineNav.tabBarItem.image = [UIImage imageWithOriginal:@"tabBar_me_icon"];
    mineNav.tabBarItem.selectedImage = [UIImage imageWithOriginal:@"tabBar_me_click_icon"];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addPublish
{
    LXHPublishViewController *vc = [[LXHPublishViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
