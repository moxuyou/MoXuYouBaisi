//
//  LXHFriendTrendsViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHFriendTrendsViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"

@interface LXHFriendTrendsViewController ()

@end

@implementation LXHFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] targer:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = @"我的关注";
}

- (void)friendsRecomment
{
    NSLog(@"%s",__func__);
}

@end
