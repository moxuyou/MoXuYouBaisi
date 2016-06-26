//
//  LXHEssenceCell.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/26.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXHEssenceItem;
@interface LXHEssenceCell : UITableViewCell

/** 模型 */
@property (nonatomic , strong)LXHEssenceItem *item;
+ (instancetype)essenceCell;

@end
