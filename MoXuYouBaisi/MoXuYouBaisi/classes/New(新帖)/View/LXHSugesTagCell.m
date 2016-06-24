//
//  LXHSugesTagCell.m
//  MoXuYouBaisi
//
//  Created by moxuyou on 16/6/22.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHSugesTagCell.h"
#import "LXHSugesTagItem.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageDownloader.h>

@interface LXHSugesTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;


@end
@implementation LXHSugesTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (IBAction)addLoveTag {
    NSLog(@"%s",__func__);
    
}

+ (instancetype)sugesTagCell
{
    LXHSugesTagCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"LXHSugesTagCell" owner:nil options:nil] lastObject];
    
    return cell;
}

- (void)setItem:(LXHSugesTagItem *)item
{
    _item = item;
    self.nameLabel.text = item.name;
    self.detailNameLabel.text = item.count;
    NSURL *url = [NSURL URLWithString:item.image];
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image !=nil) {
            UIGraphicsBeginImageContextWithOptions(image.size, NO , 0);
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            [path addClip];
            [image drawAtPoint:CGPointZero];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            self.iconView.image = newImage;
        }
        
    }];
    
}

@end
