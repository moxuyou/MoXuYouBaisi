//
//  rrrViewController.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/25.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "rrrViewController.h"

@interface rrrViewController ()

@end

@implementation rrrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
