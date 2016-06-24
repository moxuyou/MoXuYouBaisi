//
//  LXHMineFootCellItem.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/23.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHMineFootCellItem : NSObject

/** image */
@property (nonatomic , strong)NSString *image;
/** name */
@property (nonatomic , strong)NSString *name;
/** url */
@property (nonatomic , strong)NSString *url;
+ (instancetype)mineFootCellItemWithDict:(NSDictionary *)dict;

@end
