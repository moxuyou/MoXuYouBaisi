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

/** 加载更多数据的小菊花 */
@property (nonatomic , weak)UIActivityIndicatorView *indicatorView;

@end

@implementation LXHVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableView
    [self setTableView];
    
    //加载数据
    [self loadNewData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXHEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"essenceCell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%@---%lu", [self class], indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    LXHEssenceItem *item = self.itemArray[indexPath.row];
    
    cell.item = item;
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.text;
    
    return cell;
}

- (void)setTableView
{
    //初始化tableView的属性
    self.view.backgroundColor = [UIColor greenColor];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置偏移量，让tableView能够全屏显示
    self.tableView.contentInset = UIEdgeInsetsMake(LXHNavigationBarHeigth + LXHHeadViewHeigth, 0, 49, 0);
    
    
    [self.tableView registerClass:[LXHEssenceCell class] forCellReuseIdentifier:@"essenceCell"];
}

//再次刷新请求数据
- (void)loadMoreData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"data";
    dict[@"type"] = @"31";
    dict[@"maxtime"] = self.maxtime;
    
    //设置底部按钮的状态
    self.footLoadMoreDataBtn.animationView.hidden = NO;
    self.footLoadMoreDataBtn.textLabel.text = @"正在加载数据。。。";
    [self.footLoadMoreDataBtn.animationView startAnimating];
    
    [manager GET:LXHBaiSiUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
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
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"data";
    dict[@"type"] = @"31";
    
    [manager GET:LXHBaiSiUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        [responseObject writeToFile:@"/Users/moxuyou/Desktop/responseObject.plist" atomically:YES];
        //获取加载更多数据时候的KEY，可防止数据请求重复或者错误
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *itemArray = [LXHEssenceItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.itemArray = itemArray;
        
        //创建底部加载数据的View
        [self loadMoreDataView];
        //重新加载tableVie的数据
        [self.tableView reloadData];
        [self headEndLoadNewData];
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
    self.tableView.tableFooterView = footView;
    footView.LXHWidth = [UIScreen mainScreen].bounds.size.width;
    //一开始不显示小菊花
    footView.animationView.hidden = YES;
    footView.backgroundColor = [UIColor grayColor];
    footView.textLabel.text = @"点击或者上拉加载更多数据";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMoreData)];
    //添加点击手势
    [footView addGestureRecognizer:tap];
    self.footLoadMoreDataBtn = footView;
    
    //添加上面的加载按钮
    
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
    
    [self footBeginLoadMoreData];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self headBeginLoadNewData];
}

- (void)headBeginLoadNewData
{
    //判断是否正在更新数据
    if (self.isLoadingNewData) return;
    
    //判断是否满足拖拽条件
    if (self.tableView.contentOffset.y < (-self.tableView.contentInset.top - self.headLoadMoreDataBtn.LXHHeight)) {
        self.isLoadingNewData = YES;
        
        //加载新数据
        [self loadNewData];
        
        self.headLoadMoreDataBtn.textLabel.text = @"正在加载更多数据";
        self.headLoadMoreDataBtn.animationView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += self.headLoadMoreDataBtn.LXHHeight;
            self.tableView.contentInset = inset;
        }];
        
        NSLog(@"下拉刷新");
    }
}

- (void)headEndLoadNewData
{
    //还原请求数据状态
    self.isLoadingNewData = NO;
    
    //还原请求头View的状态
    self.headLoadMoreDataBtn.textLabel.text = @"下拉加载更多数据";
    self.headLoadMoreDataBtn.animationView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(LXHHeadViewHeigth + LXHNavigationBarHeigth, 0, 0, 0);
    }];
}

- (void)footBeginLoadMoreData
{
    //判断tableView是否有数据
    if (self.itemArray.count <= 0) return;
    CGFloat offset = self.tableView.contentSize.height + LXHTabBarHeigth - ([UIScreen mainScreen].bounds.size.height + self.tableView.contentOffset.y);
    //判断是否已经拖拉到末尾
    if (offset >= 0) return;
    
    //判断是否正在加载数据
    if (self.isLoadingMoreData) return;
    //设置状态为正在加载数据
    self.isLoadingMoreData = YES;
    //    NSLog(@"%s--offset%lf",__func__, offset);
    [self loadMoreData];
}

- (void)footEndLoadMoreData
{
    //恢复底部按钮的状态
    self.footLoadMoreDataBtn.animationView.hidden = YES;
    self.footLoadMoreDataBtn.textLabel.text = @"点击或者下拉加载更多数据";
    [self.footLoadMoreDataBtn.animationView stopAnimating];
    //还原数据请求状态
    self.isLoadingMoreData = NO;
}

@end
