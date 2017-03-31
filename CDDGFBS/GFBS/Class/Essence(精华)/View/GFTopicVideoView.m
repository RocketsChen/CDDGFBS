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

//苹果自带播放视频框架
#import <AVFoundation/AVFoundation.h>
#import <AFNetworkReachabilityManager.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

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
    }else if ([topic.playcount integerValue] < 0){
        self.playCountLabel.text = @"暂无播放";
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }

    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    //%02zd - 占据两位 空出来用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

/** 点击按钮开始播放视频 */
- (IBAction)butttonDidClickPlay:(id)sender {
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion integerValue] < 9) {
        /// IOS9之前的做法
        MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:movieVC];
    }else
    {
        /// iOS9的做法
        AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:self.topic.videouri]];
        AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
        playerVC.player = player;
        [playerVC.player play];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerVC animated:YES completion:nil];
    }
}

@end
