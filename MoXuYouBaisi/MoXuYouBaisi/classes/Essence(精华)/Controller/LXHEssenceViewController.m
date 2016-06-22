//
//  LXHEssenceViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHEssenceViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"

@interface LXHEssenceViewController ()

@end

@implementation LXHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] targer:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rigthItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] targer:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
}

- (void)game
{
    NSLog(@"%s",__func__);
}

- (void)random
{
    NSLog(@"%s",__func__);
}


@end
