//
//  LXHloadMoreDataView.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/27.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXHloadMoreDataView : UIView

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *animationView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

+ (instancetype)loadMoreDataView;

@end
