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

@interface LXHMineViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic , strong)LXHMineFootCellController *footVc;

@end

@implementation LXHMineViewController

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //接收通知，用于控制tableView在footView数据加载完成获取footView高度之后重新布局
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataDidLoad) name:@"collectionViewDidAppear" object:nil];
    //设置右上角两个按钮的属性
    UIBarButtonItem *settingItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] seletImage:[UIImage imageNamed:@"mine-setting-icon-click"] targer:self action:@selector(setting)];
    UIBarButtonItem *sunItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] seletImage:[UIImage imageNamed:@"mine-moon-icon-click"] targer:self action:@selector(sun:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,sunItem];
    //设置标题
    self.navigationItem.title = @"我的";
    //设置一开始屏幕自带的35偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    //分组的时候tableView默认自带heard、foot高度，设置cell底部的高度
    [self.tableView setSectionHeaderHeight:0];
    [self.tableView setSectionFooterHeight:10];
    //设置底部CollectionView的属性
    LXHMineFootCellController *vc = [[LXHMineFootCellController alloc] init];
    [self addChildViewController:vc];
    self.footVc = vc;
    vc.superVC = self;
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    
}


- (void)setting
{
//    NSLog(@"%s",__func__);
    LXHSettingViewController *vc = [[LXHSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

//重新布局tableView
- (void)dataDidLoad
{    
    self.tableView.tableFooterView = self.footVc.view;

}


@end
