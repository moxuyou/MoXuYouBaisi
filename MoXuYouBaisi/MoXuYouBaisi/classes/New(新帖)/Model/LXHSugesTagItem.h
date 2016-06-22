//
//  LXHSugesTagItem.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHSugesTagItem : NSObject

/**  */
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *image;
@property (nonatomic , strong)NSString *count;
+ (instancetype)sugesTagItemWithDict:(NSDictionary *)dict;

@end
