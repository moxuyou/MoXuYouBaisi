//
//  LXHNewViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHNewViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "LXHSugesTagViewController.h"

@interface LXHNewViewController ()

@end

@implementation LXHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIBarButtonItem *mainTagItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] targer:self action:@selector(mainTag)];
    self.navigationItem.leftBarButtonItem = mainTagItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
    
}

- (void)mainTag
{
    NSLog(@"%s",__func__);
    LXHSugesTagViewController *vc = [[LXHSugesTagViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
