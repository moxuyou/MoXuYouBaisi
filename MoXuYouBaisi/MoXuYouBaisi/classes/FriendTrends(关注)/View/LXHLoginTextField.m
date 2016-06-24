//
//  LXHLoginTextField.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHLoginTextField.h"

@implementation LXHLoginTextField

- (void)awakeFromNib
{
    //tintColor
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];
}
     
- (void)beginEdit
{
    UILabel *text = [self valueForKey:@"placeholderLabel"];
    text.textColor = [UIColor whiteColor];
    
//    self.placeholderColor = [UIColor whiteColor];
}

- (void)endEdit
{
    UILabel *text = [self valueForKey:@"placeholderLabel"];
    text.textColor = [UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1];
//    self.placeholderColor = [UIColor colorWithRed:215 / 255.0 green:215 / 255.0 blue:215 / 255.0 alpha:1];
}

@end
