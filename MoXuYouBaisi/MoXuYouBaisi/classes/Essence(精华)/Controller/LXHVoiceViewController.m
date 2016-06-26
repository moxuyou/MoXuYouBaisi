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
/** 判断是否正在加载数据 */
@property (nonatomic , assign)BOOL isLoadingData;
/** 加载更多数据的label */
@property (nonatomic , weak)LXHloadMoreDataView *loadMoreDataBtn;
/** 加载更多数据的小菊花 */
@property (nonatomic , weak)UIActivityIndicatorView *indicatorView;

@end

@implementation LXHVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableView
    [self setTableView];
    
    //加载数据
    [self loadData];
    
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
    dict[@"maxtime"] = self.maxtime;
    
    //设置底部按钮的状态
    self.loadMoreDataBtn.animationView.hidden = NO;
    self.loadMoreDataBtn.textLabel.text = @"正在加载数据。。。";
    [self.loadMoreDataBtn.animationView startAnimating];
    
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
        self.loadMoreDataBtn.animationView.hidden = YES;
        self.loadMoreDataBtn.textLabel.text = @"点击或者下拉加载更多数据";
        [self.loadMoreDataBtn.animationView stopAnimating];
        //还原数据请求状态
        self.isLoadingData = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        //恢复底部按钮的状态
        self.loadMoreDataBtn.animationView.hidden = YES;
        self.loadMoreDataBtn.textLabel.text = @"点击或者下拉加载更多数据";
        [self.loadMoreDataBtn.animationView stopAnimating];
        //还原数据请求状态
        self.isLoadingData = NO;
    }];
    
    
}

//第一次请求数据
- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"list";
    dict[@"c"] = @"data";
    
    
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
        self.isLoadingData = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        self.isLoadingData = NO;
    }];
    
}

//创建加载数据的按钮
- (void)loadMoreDataView
{
    LXHloadMoreDataView *footView = [LXHloadMoreDataView loadMoreDataView];
    self.tableView.tableFooterView = footView;
    footView.LXHWidth = [UIScreen mainScreen].bounds.size.width;
    //一开始不显示小菊花
    footView.animationView.hidden = YES;
    footView.backgroundColor = [UIColor grayColor];
    footView.textLabel.text = @"点击或者下拉加载更多数据";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadMoreData)];
    //添加点击手势
    [footView addGestureRecognizer:tap];
    self.loadMoreDataBtn = footView;
}

#pragma mark - tableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断tableView是否有数据
    if (self.itemArray.count <= 0) return;
    CGFloat offset = self.tableView.contentSize.height + LXHTabBarHeigth - ([UIScreen mainScreen].bounds.size.height + self.tableView.contentOffset.y);
    //判断是否已经拖拉到末尾
    if (offset >= 0) return;
    //判断是否正在加载数据
    if (self.isLoadingData) return;
    
//    NSLog(@"%s--offset%lf",__func__, offset);
    //设置状态为正在加载数据
    self.isLoadingData = YES;
    [self loadMoreData];
    
}

@end
