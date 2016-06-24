//
//  LXHMineFootCellView.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXHMineFootCellItem;
@interface LXHMineFootCellView : UICollectionViewCell

/** LXHMineFootCellItem */
@property (nonatomic , strong)LXHMineFootCellItem *item;
+ (instancetype)mineFootCellView;

@end
