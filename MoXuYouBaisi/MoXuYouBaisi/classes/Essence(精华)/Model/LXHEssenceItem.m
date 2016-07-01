//
//  LXHEssenceItem.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/26.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHEssenceItem.h"

@implementation LXHEssenceItem

- (CGFloat)cellHeigth
{
    if (_cellHeigth <= 0) {
        _cellHeigth = 0.0;
        
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - LXHSpace * 2, 0);
        //顶部高度
        _cellHeigth += 50 + LXHSpace;
        //底部高度
        _cellHeigth += 44 + LXHSpace;
        
        //中间内容高度
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        CGFloat textHeigth = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict  context:nil].size.height;
        _cellHeigth += textHeigth;
        
        //最热评论高度
        if (self.top_cmt.count > 0) {
            //最热评论标题
            _cellHeigth += 21;
            //最热评论内容

            NSDictionary *dict = self.top_cmt[0];
            NSString *userName = dict[@"user"][@"username"];
            NSString *content = dict[@"content"];
            NSString *allContent = nil;
            NSMutableDictionary *top_cmtDict = [NSMutableDictionary dictionary];
            top_cmtDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
            if (content.length > 0) {
                allContent = [NSString stringWithFormat:@"%@:%@", userName, content];
            }else
            {
                allContent = [NSString stringWithFormat:@"%@:语音文件", userName];
            }
            
            CGFloat top_cmtHeigth = [allContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:top_cmtDict  context:nil].size.height;
            _cellHeigth += top_cmtHeigth + LXHSpace;
            
        }
        //cell里面设置了LXHSpace的间距
        _cellHeigth += LXHSpace;
    }

    return _cellHeigth;
}

@end
