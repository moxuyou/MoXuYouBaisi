//
//  LXHVoiceViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/24.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHVoiceViewController.h"
#import "LXHEssenceCell.h"
#import "LXHEssenceItem.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "LXHloadMoreDataView.h"
#import <Masonry.h>

@interface LXHVoiceViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property (nonatomic , strong)NSMutableArray *itemArray;
/**  */
@property (nonatomic , strong)NSString *maxtime;
/** 判断是否正在加载更多数据 */
@property (nonatomic , assign)BOOL isLoadingMoreData;
/** 判断是否正在加载最新数据 */
@property (nonatomic , assign)BOOL isLoadingNewData;
/** 下面加载更多数据的label */
@property (nonatomic , weak)LXHloadMoreDataView *footLoadMoreDataBtn;
/** 上面加载更多数据的label */
@property (nonatomic , weak)LXHloadMoreDataView *headLoadMoreDataBtn;
/** 请求数据的manager */
@property (nonatomic , strong)AFHTTPSessionManager *manager;
/** 加载更多数据的小菊花 */
@property (nonatomic , weak)UIActivityIndicatorView *indicatorView;

@end

@implementation LXHVoiceViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s",__func__);
    
//    添加通知监听tabBar按钮的点击，用于刷新界面数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:LXHReflashViewByTabbarClick object:nil];
    
    //初始化tableView
    [self setTableView];
    
    //加载数据
    [self loadNewData];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarClick
{
    if (self.tableView.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    [self headBeginLoadNewData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXHEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"essenceCell" forIndexPath:indexPath];

//    cell.backgroundColor = [UIColor clearColor];
    
    LXHEssenceItem *item = self.itemArray[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.item = item;
//    cell.textLabel.text = item.name;
//    cell.detailTextLabel.text = item.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LXHEssenceItem *item = self.itemArray[indexPath.row];
    NSLog(@"heightForRowAtIndexPath%zd----item.cellHeigth%lf", indexPath.row, item.cellHeigth);
    return item.cellHeigth;
}

- (void)setTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化tableView的属性
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置偏移量，让tableView能够全屏显示
    self.tableView.contentInset = UIEdgeInsetsMake(LXHNavigationBarHeigth + LXHHeadViewHeigth, 0, LXHTabBarHeigth + self.headLoadMoreDataBtn.LXHHeight, 0);
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"LXHEssenceCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"essenceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXHEssenceCell" bundle:nil] forCellReuseIdentifier:@"essenceCell"];
    
    self.tableView.estimatedRowHeight = 180;
}

//再次刷新请求数据
- (void)loadMoreData
{
    if(self.isLoadingNewData)
    {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel) withObject:nil];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"data";
    dict[@"type"] = @"31";
    dict[@"maxtime"] = self.maxtime;
    
    //设置底部按钮的状态
    self.footLoadMoreDataBtn.animationView.hidden = NO;
    self.footLoadMoreDataBtn.textLabel.text = @"正在加载数据。。。";
    [self.footLoadMoreDataBtn.animationView startAnimating];
    
    [self.manager GET:LXHBaiSiUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        //        NSLog(@"%@", responseObject);
        [responseObject writeToFile:@"/Users/moxuyou/Desktop/responseObjectMore.plist" atomically:YES];
        //获取下一次请求数据的key
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //创建加载模型对象
        NSMutableArray *itemArray = [LXHEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //给本地内存的数据数据赋值
        [self.itemArray addObjectsFromArray:itemArray];
        
        //重新加载tableVie的数据
        [self.tableView reloadData];
        
        //恢复底部按钮的状态
        [self footEndLoadMoreData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        //恢复底部按钮的状态
        [self footEndLoadMoreData];
    }];
    
    
}

//第一次请求数据
- (void)loadNewData
{
    if(self.isLoadingMoreData)
    {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel) withObject:nil];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"data";
    dict[@"type"] = @"31";
    
    [self.manager GET:LXHBaiSiUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        [responseObject writeToFile:@"/Users/moxuyou/Desktop/responseObject.plist" atomically:YES];
        //获取加载更多数据时候的KEY，可防止数据请求重复或者错误
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *itemArray = [LXHEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.itemArray = itemArray;
        
        
        //重新加载tableVie的数据
        [self.tableView reloadData];
        if (self.headLoadMoreDataBtn != nil) {
            
            [self headEndLoadNewData];
        }
        
        //创建底部加载数据的View
        [self loadMoreDataView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        [self headEndLoadNewData];
    }];
    
}

//创建加载数据的按钮
- (void)loadMoreDataView
{
    //添加下面的加载按钮
    LXHloadMoreDataView *footView = [LXHloadMoreDataView loadMoreDataView];
    
    footView.LXHWidth = [UIScreen mainScreen].bounds.size.width;
    //一开始不显示小菊花
    footView.animationView.hidden = YES;
    footView.backgroundColor = [UIColor grayColor];
    footView.textLabel.text = @"点击或者上拉加载更多数据";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMoreData)];
    //添加点击手势
    [footView addGestureRecognizer:tap];
    self.footLoadMoreDataBtn = footView;
    self.tableView.tableFooterView = footView;
    
    //添加上面的加载按钮{375, 915}---(null)
    
    LXHloadMoreDataView *headView = [LXHloadMoreDataView loadMoreDataView];
    headView.frame = CGRectMake(0, -44, [UIScreen mainScreen].bounds.size.width, 44);
    headView.textLabel.text = @"下拉加载更多数据";
    //一开始不显示小菊花
    headView.animationView.hidden = YES;
    [self.tableView addSubview:headView];
    headView.backgroundColor = [UIColor grayColor];

    self.headLoadMoreDataBtn = headView;
    
    //添加广告信息
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35);
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"广告广告广告广告广告广告";
    headLabel.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = headLabel;
    
}

#pragma mark - tableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self headBeginLoadNewData];
    //判断是否满足拖拽条件
    //判断tableView是否有数据
    if (self.itemArray.count <= 0) return;
    CGFloat offset = self.tableView.contentSize.height + LXHTabBarHeigth - ([UIScreen mainScreen].bounds.size.height + self.tableView.contentOffset.y);
    //判断是否已经拖拉到末尾
    if (offset >= 0) return;
    //判断是否正在更新数据
    if (self.isLoadingMoreData) return;
    self.isLoadingMoreData = YES;
    
    [self footBeginLoadMoreData];
    NSLog(@"上拉刷新");
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (self.tableView.contentOffset.y < (-self.tableView.contentInset.top - self.headLoadMoreDataBtn.LXHHeight)) {
        //判断是否正在更新数据
        if (self.isLoadingNewData) return;
        
        self.isLoadingNewData = YES;
        //加载更多数据
        [self headBeginLoadNewData];
        NSLog(@"下拉刷新");
    }
}

- (void)headBeginLoadNewData
{
    self.headLoadMoreDataBtn.textLabel.text = @"正在加载更多数据";
    self.headLoadMoreDataBtn.animationView.hidden = NO;

    // 增大内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += LXHHeadViewHeigth;
        self.tableView.contentInset = inset;
        
        CGPoint offset = self.tableView.contentOffset;
        offset.y = - inset.top;
        self.tableView.contentOffset = offset;
    }];
    //加载新数据
    [self loadNewData];
}

- (void)headEndLoadNewData
{
    //还原请求数据状态
    self.isLoadingNewData = NO;
    
    //还原请求头View的状态
    self.headLoadMoreDataBtn.textLabel.text = @"下拉加载更多数据";
    self.headLoadMoreDataBtn.animationView.hidden = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headLoadMoreDataBtn.LXHHeight;
        self.tableView.contentInset = inset;
        
    }];
}

- (void)footBeginLoadMoreData
{
    
    //判断是否正在加载数据
    self.footLoadMoreDataBtn.animationView.hidden = NO;
    
    [self loadMoreData];
}

- (void)footEndLoadMoreData
{
    //恢复底部按钮的状态
    self.footLoadMoreDataBtn.animationView.hidden = YES;
    self.footLoadMoreDataBtn.textLabel.text = @"点击或者下拉加载更多数据";
    //还原数据请求状态
    self.isLoadingMoreData = NO;
}

@end
