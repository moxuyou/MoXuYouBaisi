//
//  LXHLoginViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHLoginViewController.h"
#import "LXHLoginView.h"

@interface LXHLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeadingConstain;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@end

@implementation LXHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LXHLoginView *loginView  = [LXHLoginView loginView];
    loginView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.loginView.bounds.size.height);
    [self.loginView addSubview:loginView];
    
    LXHLoginView *registerView  = [LXHLoginView registerView];
    registerView.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.loginView.bounds.size.height);
    [self.loginView addSubview:registerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)siginClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        self.loginViewLeadingConstain.constant = -self.view.bounds.size.width;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else{
        self.loginViewLeadingConstain.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

//退出编辑
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:NO];
}

@end
