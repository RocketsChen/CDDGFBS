//
//  GFCommentCell.m
//  GFBS
//
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFCommentCell.h"
#import "GFUser.h"
#import "GFComment.h"
#import <UIImageView+WebCache.h>

@interface GFCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceUrl;

@end

@implementation GFCommentCell


-(void)setComment:(GFComment *)comment
{
    _comment = comment;
    
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"]gf_circleImage];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.iconImageView.image = [image gf_circleImage];
    }];
    
    self.nameLabel.text = comment.user.username;
    self.text_label.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    NSString *sexImageSexName = [comment.user.sex isEqualToString:GFBoy] ? @"Profile_manIcon" : @"Profile_womanIcon";
//    NSString *sexImageSexName = [comment.user.sex isEqualToString:GFBoy] ? @"Profile_manIcon" : "Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageSexName];
    
    if (comment.voiceuri.length) {
        self.voiceUrl.hidden = NO;
        [self.voiceUrl setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceUrl.hidden = YES;
    }
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

@end
