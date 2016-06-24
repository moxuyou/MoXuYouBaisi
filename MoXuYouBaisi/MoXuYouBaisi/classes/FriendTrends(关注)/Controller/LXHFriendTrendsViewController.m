//
//  LXHFriendTrendsViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHFriendTrendsViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "LXHLoginViewController.h"

@interface LXHFriendTrendsViewController ()

@end

@implementation LXHFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1];
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] targer:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = @"我的关注";
}

- (void)friendsRecomment
{
    NSLog(@"%s",__func__);
}

- (IBAction)loginClick {
    LXHLoginViewController *vc = [[LXHLoginViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
