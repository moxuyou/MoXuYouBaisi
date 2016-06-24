//
//  LXHMineFootCellItem.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHMineFootCellItem.h"

@implementation LXHMineFootCellItem

+ (instancetype)mineFootCellItemWithDict:(NSDictionary *)dict
{
    LXHMineFootCellItem *item = [[LXHMineFootCellItem alloc] init];
    item.image = dict[@"icon"];
    item.name = dict[@"name"];
    item.url = dict[@"url"];
    
    return item;
}

@end
