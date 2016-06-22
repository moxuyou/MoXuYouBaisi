//
//  LXHSugesTagViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHSugesTagViewController.h"
#import <AFNetworking.h>
#import "LXHSugesTagItem.h"
#import "LXHSugesTagCell.h"

@interface LXHSugesTagViewController ()<UITableViewDelegate,UITableViewDataSource>

/** data */
@property (nonatomic , strong)NSArray *dataArray;

@end

@implementation LXHSugesTagViewController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    http://api.budejie.com/api/api_open.php?a=tag_recommend&c=topic&action=sub
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"tag_recommend";
    dict[@"c"] = @"topic";
    dict[@"action"] = @"sub";
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            LXHSugesTagItem *item = [LXHSugesTagItem sugesTagItemWithDict:dict];
            [arrayM addObject:item];
        }
        self.dataArray = arrayM;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"sugesTagCell";
    LXHSugesTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [LXHSugesTagCell sugesTagCell];
    }
    LXHSugesTagItem *item = self.dataArray[indexPath.row];
    cell.item = item;
    
    return cell;
}


@end
