//
//  GFTopicVideoView.m
//  GFBS
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopicVideoView.h"

#import "GFTopic.h"
#import <UIImageView+WebCache.h>
#import "GFSeeBigImageViewController.h"

@interface GFTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;


@end

@implementation GFTopicVideoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //从Xib中加载进来的控件默认 UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage)];
    self.videoImageView.userInteractionEnabled = YES;
    [self.videoImageView addGestureRecognizer:gesture];
    
}

/**
 查看大图
 */
-(void)seeBigImage
{
    GFSeeBigImageViewController *seeBigVc = [[GFSeeBigImageViewController alloc] init];
    seeBigVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigVc animated:YES completion:nil];
}


-(void)setTopic:(GFTopic *)topic
{
    _topic = topic;
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    if ([topic.playcount integerValue]>10000) {
       self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",[topic.playcount integerValue] / 10000.0];
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }

    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    //%02zd - 占据两位 空出来用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    
}


@end
