//
//  LXHADViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/21.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHADViewController.h"
#import "LXHTabBarController.h"
#import <AFNetworking.h>
#import "SDWebImageManager.h"

#define getUrl @"http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface LXHADViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (weak, nonatomic) IBOutlet UIView *adView;
/** adUrl */
@property (nonatomic , strong)NSString *adUrl;
/**timer */
@property (nonatomic , weak)NSTimer *timer;

@end

@implementation LXHADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加定时器跳过广告界面
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    //设置获取的格式添加text/html格式的获取
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSSet<NSString *> *set = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet<NSString *> *setM = [NSMutableSet setWithSet:set];
    [setM addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = setM;
    //设置参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"demo"] = @"1";
    dict[@"entrytype"] = @"1";
    //开始发送请求
    [manager GET:getUrl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@", responseObject);
        //图片w_picurl 超链接 ori_curl 宽w 高h
        NSDictionary *dict = responseObject;
        dict = dict[@"ad"][0];
        //获取图片的地址
        NSString *path = dict[@"w_picurl"];
        //获取图片URL点击跳转的地址
        NSString *adUrl = dict[@"ori_curl"];
        self.adUrl = adUrl;
        if (adUrl != nil) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [self.adView addGestureRecognizer:tap];
        }
        [self setADImage:path];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}
- (IBAction)jumpBtnClick {
    LXHTabBarController *vc = [[LXHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)timerChange
{
    static int count = 3;
    
    if (count <= 0) {
        [self jumpBtnClick];
        
    }
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过（%d）", count - 1] forState:UIControlStateNormal];
    count--;
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [self.timer invalidate];
}

- (void)setADImage:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.image = image;
            imageV.frame = self.view.bounds;
            [self.adView addSubview:imageV];
        });
        
    }];
    
}

- (void)tap:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:self.adUrl];
    [[UIApplication sharedApplication] openURL:url];
}

@end
