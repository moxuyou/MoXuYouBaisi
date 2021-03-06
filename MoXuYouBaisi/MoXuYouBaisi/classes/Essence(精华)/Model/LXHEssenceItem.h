//
//  LXHEssenceItem.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/26.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHEssenceItem : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *content;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** cell */
@property (nonatomic, assign) CGFloat cellHeigth;

@end
