//
//  LXHEssenceCell.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/26.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHEssenceCell.h"
#import "LXHEssenceItem.h"

@implementation LXHEssenceCell

+ (instancetype)essenceCell
{
    LXHEssenceCell *cell = [[LXHEssenceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"essenceCell"];
    
    return cell;
}

@end
