//
//  LXHEssenceCell.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/26.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHEssenceCell.h"
#import "LXHEssenceItem.h"
#import <UIImageView+WebCache.h>

@interface LXHEssenceCell ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTime;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIView *hotTopicView;
@property (weak, nonatomic) IBOutlet UILabel *hotTopicTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *massageButton;



@end
@implementation LXHEssenceCell

+ (instancetype)essenceCell
{
    LXHEssenceCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LXHEssenceCell" owner:nil options:nil] lastObject];
    
    return cell;
}

- (void)setItem:(LXHEssenceItem *)item
{
    _item = item;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.name;
    self.passTime.text = item.created_at;
    self.text_label.text = item.text;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%lu", item.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%lu", item.cai] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%lu", item.repost] forState:UIControlStateNormal];
    [self.massageButton setTitle:[NSString stringWithFormat:@"%lu", item.comment] forState:UIControlStateNormal];
    if (self.item.top_cmt.count > 0) {
    #warning 只是默认一种，后期还要处理
        self.hotTopicView.hidden = NO;
        for (NSDictionary *dict in item.top_cmt) {
            NSString *userName = dict[@"user"][@"username"];
            NSString *content = dict[@"content"];
            if (content.length > 0) {
                content = [NSString stringWithFormat:@"%@:%@", userName, content];
            }else
            {
                content = [NSString stringWithFormat:@"%@:语音文件", userName];
            }
            self.hotTopicTextLabel.text = content;
        }
    }else{
        self.hotTopicView.hidden = YES;
    }

}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= LXHSpace;
    [super setFrame:frame];
    
}

@end
