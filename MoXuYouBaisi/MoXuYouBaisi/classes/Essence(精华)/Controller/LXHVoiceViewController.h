//
//  LXHVoiceViewController.h
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/24.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^voiceViewLoadMoreDataBlock)(NSString *);
@interface LXHVoiceViewController : UITableViewController

/**  */
@property (nonatomic , strong) voiceViewLoadMoreDataBlock loadMoreBlock;

@end
