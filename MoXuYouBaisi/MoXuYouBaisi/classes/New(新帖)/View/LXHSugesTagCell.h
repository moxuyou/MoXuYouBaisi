//
//  LXHSugesTagCell.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXHSugesTagItem;
@interface LXHSugesTagCell : UITableViewCell

/** 模型 */
@property (nonatomic , strong)LXHSugesTagItem *item;
+ (instancetype)sugesTagCell;

@end
