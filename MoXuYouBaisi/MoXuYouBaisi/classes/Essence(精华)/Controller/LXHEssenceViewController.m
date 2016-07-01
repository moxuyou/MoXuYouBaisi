//
//  LXHEssenceViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/17.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHEssenceViewController.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "LXHAllDataViewController.h"
#import "LXHVedioViewController.h"
#import "LXHVoiceViewController.h"
#import "LXHPictureViewController.h"
#import "LXHWorldViewController.h"
#import "LXHHeardViewButton.h"


@interface LXHEssenceViewController ()<UIScrollViewDelegate>

/** scrollView */
@property (nonatomic , weak)UIScrollView *scrollView;
/** headViewData */
@property (nonatomic , strong)NSArray *headViewData;
/** headView */
@property (nonatomic , weak)UIView *headView;
/** currenHeardViewButton */
@property (nonatomic , weak)LXHHeardViewButton *currenHeardViewButton;
/** 导航栏下面的线 */
@property (nonatomic , weak)UIView *headFootView;

/** 置顶悬浮按钮 */
@property (nonatomic , strong)UIWindow *windowToTop;

@end

@implementation LXHEssenceViewController

- (UIWindow *)windowToTop
{
    
    if (_windowToTop == nil) {
        
        //设置返回顶部按钮
        UIWindow *windowToTop = [[UIWindow alloc] initWithFrame:CGRectMake(self.view.LXHWidth - 40, self.view.LXHHeight - 100, 30, 30)];
        windowToTop.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToTop)];
        [windowToTop addGestureRecognizer:tap];
        self.windowToTop = windowToTop;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:windowToTop.bounds];
        imageV.image = [UIImage imageNamed:@"mainCellDingClick"];
        imageV.userInteractionEnabled = YES;
        [windowToTop addSubview:imageV];
        [windowToTop makeKeyAndVisible];
    }
    return _windowToTop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.headViewData = @[@"全部",@"视屏",@"声音",@"图片",@"段子"];
    
    // 不要去自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置setNavigationBar
    [self setNavigationBar];
    
    //设置主界面显示
    [self setChildVc];
    
    //设置标题栏
    [self setHeadStatus];
    
}

- (void)scrollToTop
{
    NSInteger index = [self.headView.subviews indexOfObject:self.currenHeardViewButton];
    UITableViewController *vc = self.childViewControllers[index];
    UIScrollView *scrollView = (UIScrollView *)vc.view;
    [UIView animateWithDuration:0.25 animations:^{
        scrollView.contentOffset = CGPointMake(0, -(LXHNavigationBarHeigth + LXHHeadViewHeigth));
    }];
    
}

- (void)game
{
    NSLog(@"%s",__func__);
}

- (void)random
{
    NSLog(@"%s",__func__);
}



/* setNavigationBar */
- (void)setNavigationBar
{
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] targer:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rigthItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] targer:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageView;
}

/* setChildVc */
- (void)setChildVc
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView = scrollView;
    
    LXHAllDataViewController *allVc = [[LXHAllDataViewController alloc] init];
    
    [self addChildViewController:allVc];
    
    LXHVedioViewController *vedioVc = [[LXHVedioViewController alloc] init];
    
    [self addChildViewController:vedioVc];
    
    LXHVoiceViewController *voiceVc = [[LXHVoiceViewController alloc] init];
    
    [self addChildViewController:voiceVc];
    
    LXHPictureViewController *pictureVc = [[LXHPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
    LXHWorldViewController *worldVc = [[LXHWorldViewController alloc] init];
    [self addChildViewController:worldVc];
    
    self.scrollView.contentSize = CGSizeMake(self.view.LXHWidth * self.headViewData.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
}

/* setHeadStatus */
- (void)setHeadStatus
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.LXHWidth, 44)];
    headView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.headView = headView;
    
    CGFloat btnW = self.headView.LXHWidth / self.headViewData.count;
    CGFloat btnH = self.headView.LXHHeight;
    CGFloat btnY = 0;
    for (int i = 0; i < self.headViewData.count; ++i) {
        LXHHeardViewButton *btn = [[LXHHeardViewButton alloc] initWithFrame:CGRectMake(i * btnW, btnY, btnW, btnH - 2)];
        [btn addTarget:self action:@selector(heardViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.headViewData[i] forState:UIControlStateNormal];
        [self.headView addSubview:btn];
        [btn setBackgroundColor:[UIColor colorWithRed:0.1 green:1 blue:0.3 alpha:0.5]];
    }
    
    [self.view addSubview:self.headView];
    
    LXHHeardViewButton *firstBtn = self.headView.subviews[0];
    [firstBtn.titleLabel sizeToFit];
    UIColor *color = [firstBtn titleColorForState:UIControlStateSelected];
    
    //设置下面的线
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = color;
    footView.frame = CGRectMake(0, firstBtn.LXHHeight, firstBtn.titleLabel.LXHWidth, self.headView.LXHHeight - firstBtn.LXHHeight);
    
    self.headFootView = footView;
    [self.headView addSubview:footView];
    
    self.currenHeardViewButton = firstBtn;
    self.headFootView.LXHCenterX = self.currenHeardViewButton.LXHCenterX;
    [self heardViewButtonClick:firstBtn];
    
}

/* heardViewButtonClick */
- (void)heardViewButtonClick:(LXHHeardViewButton *)clickBtn
{
    if (self.currenHeardViewButton == clickBtn) {
        NSLog(@"重复点击了");
        //发出通知，用于控制点击刷新界面
        [[NSNotificationCenter defaultCenter] postNotificationName:LXHReflashViewByTabbarClick object:self];
//        [self ];
    }
    
    self.currenHeardViewButton.selected = NO;
    
    clickBtn.selected = YES;
    
    self.currenHeardViewButton = clickBtn;
    
    NSInteger index = [self.headView.subviews indexOfObject:clickBtn];
    //添加视图
    UITableViewController *vc = self.childViewControllers[index];
    
    if (!vc.isViewLoaded) {
        vc.view.frame = CGRectMake(index * self.view.LXHWidth, 0, self.view.LXHWidth, self.view.LXHHeight);
//        vc.view.backgroundColor = LXHRandomColor;
        UIScrollView *scrollView = (UIScrollView *)vc.view;
        if ([vc.view isKindOfClass:[UIScrollView class]])
        {
            scrollView.scrollsToTop = NO;
        }
        [self.scrollView addSubview:vc.view];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //控制底部视图的游动
        self.headFootView.LXHCenterX = self.currenHeardViewButton.LXHCenterX;
        //控制tableView联动
        self.scrollView.contentOffset = CGPointMake(self.scrollView.LXHWidth * index, self.scrollView.contentOffset.y);
    }];
    
    //循环控制控制器的scrollsToTop属性，还原状态栏的功能
    for (int i = 0; i < self.childViewControllers.count; ++i) {
        UIViewController *vc = self.childViewControllers[i];
        if (!vc.isViewLoaded) continue;
        if (![vc.view isKindOfClass:[UIScrollView class]]) continue;
        
        UIScrollView *scrollView = (UIScrollView *)vc.view;
        scrollView.scrollsToTop = (i == index);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.LXHWidth;
    LXHHeardViewButton *selectedBtn = self.headView.subviews[index];
    //修复左右轻微拖动但还是保持在当前界面的情况不调用点击按钮方法
    if (selectedBtn == self.currenHeardViewButton) {
        return;
    }
    [self heardViewButtonClick:selectedBtn];
    
}

//进入精华界面的时候控制返回顶部按钮显示
- (void)viewDidDisappear:(BOOL)animated
{
    
    self.windowToTop.hidden = YES;
//    [self.windowToTop removeFromSuperview];
}

//离开显示的时候设置顶部按钮消失
- (void)viewDidAppear:(BOOL)animated
{
    self.windowToTop.hidden = NO;
//    [self.windowToTop removeFromSuperview];
}

@end
