//
//  LXHSugesTagItem.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHSugesTagItem.h"

@implementation LXHSugesTagItem

+ (instancetype)sugesTagItemWithDict:(NSDictionary *)dict
{
    LXHSugesTagItem *item = [[LXHSugesTagItem alloc] init];
    NSString *nameStr = dict[@"theme_name"];
    item.name = nameStr;
    item.image = dict[@"image_list"];
    item.count = dict[@"sub_number"];
    
    return item;
}

@end
