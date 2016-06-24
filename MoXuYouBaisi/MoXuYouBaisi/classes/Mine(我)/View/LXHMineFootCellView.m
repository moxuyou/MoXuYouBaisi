//
//  LXHMineFootCellView.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMineFootCellView.h"
#import <UIImageView+WebCache.h>
#import "LXHMineFootCellItem.h"

@interface LXHMineFootCellView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation LXHMineFootCellView

+ (instancetype)mineFootCellView
{
    LXHMineFootCellView *view = [[[NSBundle mainBundle] loadNibNamed:@"LXHMineFootCellView" owner:nil options:nil] lastObject];
    
    return view;
}

- (void)setItem:(LXHMineFootCellItem *)item
{
    _item = item;
    NSURL *url = [NSURL URLWithString:item.image];
    [self.imageView sd_setImageWithURL:url];
    self.nameLabel.text = item.name;
}

@end
