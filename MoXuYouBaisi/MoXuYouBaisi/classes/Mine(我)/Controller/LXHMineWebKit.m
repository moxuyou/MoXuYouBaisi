//
//  LXHMineWebKit.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMineWebKit.h"

@interface LXHMineWebKit ()

/**  */
@property (nonatomic , weak)WKWebView *webView;
/**  */
@property (nonatomic , weak)UIProgressView *progress;

@end
@implementation LXHMineWebKit

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
    [webView loadRequest:request];
    
    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.LXHWidth, 10)];
    progress.progress = 0;
    progress.progressTintColor = [UIColor redColor];
    progress.trackTintColor = [UIColor blackColor];
    [self.view addSubview:progress];
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [webView addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.LXHWidth, 64)];
    view.backgroundColor = [UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1];
    backBtn.frame = CGRectMake(0, 20, backBtn.LXHWidth, backBtn.LXHHeight);
    [view addSubview:backBtn];
    [webView addSubview:view];
    
    self.webView = webView;
    self.progress = progress;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }else if ([keyPath isEqualToString:@"URL"]) {
        
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progress setProgress:self.webView.estimatedProgress animated:YES];
        self.progress.hidden = (self.progress.progress == 1.0 )? YES : NO;
    }
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"URL"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionViewDidAppear" object:self];
    }];
    
}

@end
