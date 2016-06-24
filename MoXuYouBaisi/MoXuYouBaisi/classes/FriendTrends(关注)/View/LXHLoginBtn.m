//
//  LXHLoginBtn.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHLoginBtn.h"

@implementation LXHLoginBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - self.imageView.bounds.size.width * 0.5, 10, self.imageView.bounds.size.width, self.imageView.bounds.size.height);
    self.titleLabel.frame = CGRectMake(self.bounds.size.width * 0.5 - self.titleLabel.bounds.size.width * 0.5, self.bounds.size.height - self.imageView.bounds.size.height + 30, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);

//    [self.titleLabel sizeToFit];
    
}

@end
