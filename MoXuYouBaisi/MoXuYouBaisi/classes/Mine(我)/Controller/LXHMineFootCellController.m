//
//  LXHMineFootCellController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMineFootCellController.h"
#import "LXHMineFootCellView.h"
#import <AFNetworking.h>
#import "LXHMineFootCellItem.h"
#import "LXHMineFootCellView.h"
#import <SVProgressHUD.h>
#import "LXHMineWebKit.h"

static int const cols = 4;
static CGFloat const margin = 0.5;
static NSString *ID = @"mineFootCell";
#define BSCellW (BSScreenW - (cols - 1) * margin) / cols
@interface LXHMineFootCellController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;
/** data */
@property (nonatomic , strong)NSMutableArray *dataArray;

@end

@implementation LXHMineFootCellController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)setUpFootView
{
    
    // 创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //单个cell的宽高
    layout.itemSize = CGSizeMake(BSCellW, BSCellW);
    //竖直间距
    layout.minimumInteritemSpacing = margin;
    //水平间距
    layout.minimumLineSpacing = margin;
    //添加限制
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //不给他滚动
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LXHMineFootCellView" bundle:nil] forCellWithReuseIdentifier:ID];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化collectionView属性
    [self setUpFootView];
    
    //添加遮盖
    [SVProgressHUD showWithStatus:@"正在加载..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"square";
    dict[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSArray *array = responseObject[@"square_list"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            LXHMineFootCellItem *item = [LXHMineFootCellItem mineFootCellItemWithDict:dict];
            [arrayM addObject:item];
        }
        self.dataArray = arrayM;
        
        // 计算总行数 rows = (count - 1) / cols + 1
        NSInteger rows = (self.dataArray.count - 1) / cols + 1;
        
        CGFloat collectionH = rows * BSCellW;
        
        //补齐空缺cell
        [self addEmptyCell];
        
        // 计算collectionView高度
        self.collectionView.LXHHeight = collectionH;
        self.view.LXHHeight = collectionH + 10;
        
        NSLog(@"%lf", self.collectionView.LXHHeight);
        
        [self.collectionView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionViewDidAppear" object:self];
        [SVProgressHUD dismiss];
//        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
    }];
    
}

//设置cell的数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXHMineFootCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    LXHMineFootCellItem *item = self.dataArray[indexPath.row];
    cell.item = item;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

//补齐空缺的cell
- (void)addEmptyCell
{
    if (self.dataArray.count > 0) {
        NSInteger count = self.dataArray.count;
        NSInteger empty = count % cols;
        if (empty) {
            for (int i = 0; i < (cols - empty); ++i)
                [self.dataArray addObject:[[LXHMineFootCellItem alloc] init]];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXHMineFootCellItem *item = self.dataArray[indexPath.row];
    NSLog(@"点击了%lu", indexPath.row);
    if ([item.url containsString:@"http://"]) {
        //UIApplication
//        NSURL *url = [NSURL URLWithString:item.url];
//        [[UIApplication sharedApplication] openURL:url];
        
        //UIApplication
//        LXHMineWebKit *webView = [[LXHMineWebKit alloc] init];
//        ;
//        NSURL *url = [NSURL URLWithString:item.url];
//        webView.url = url;
//        [self presentViewController:webView animated:YES completion:nil];
    
        
    }
    
}

@end
