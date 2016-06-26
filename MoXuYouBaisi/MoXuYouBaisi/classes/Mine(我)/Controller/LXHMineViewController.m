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
#import "LXHMineFootCellController.h"
#import "rrrViewController.h"

@interface LXHMineViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic , strong)LXHMineFootCellController *footVc;

@end

@implementation LXHMineViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataDidLoad) name:@"collectionViewDidAppear" object:nil];
        
    UIBarButtonItem *settingItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] seletImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setting)];
    UIBarButtonItem *sunItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] seletImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(sun:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,sunItem];
    
    self.navigationItem.title = @"我的";
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self.tableView setSectionHeaderHeight:0];
    [self.tableView setSectionFooterHeight:10];
        
    LXHMineFootCellController *vc = [[LXHMineFootCellController alloc] init];
    self.footVc = vc;
    vc.superVC = self;
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    
//    self.tableView.tableFooterView = vc.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    
    
}

- (void)setting
{
//    NSLog(@"%s",__func__);
//    LXHSettingViewController *vc = [[LXHSettingViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    rrrViewController *vc = [[rrrViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
    });
}

- (void)sun:(UIButton *)btn
{
    [self dataDidLoad];
    btn.selected = !btn.isSelected;
//    NSLog(@"%s",__func__);
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    LXHMineFootCellController *vc = [[LXHMineFootCellController alloc] init];
//    self.footVc = vc;
//    
//    return vc.view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return 200;
//    }
//    return 10;
//}

- (void)dataDidLoad
{    
    self.tableView.tableFooterView = self.footVc.view;

}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [self dataDidLoad];
//}

@end
