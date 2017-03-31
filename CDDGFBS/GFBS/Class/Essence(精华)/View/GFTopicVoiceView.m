//
//  GFTopicVoiceView.m
//  GFBS
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopicVoiceView.h"

#import "GFSeeBigImageViewController.h"

#import <UIImageView+WebCache.h>
#import "GFTopic.h"

//苹果自带播放音频
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface GFTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;

/** 上一个按钮 */
@property (weak, nonatomic) UIButton *lastPlayButton;
/** 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voicePlayButton;

@end

static AVPlayer * player_;
static UIButton *lastPlayButton_;
static GFTopic *lastTopic_;

@implementation GFTopicVoiceView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //从Xib中加载进来的控件默认 UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    self.autoresizingMask = UIViewAutoresizingNone;

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage)];
    self.voiceImageView.userInteractionEnabled = YES;
    [self.voiceImageView addGestureRecognizer:gesture];
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
    
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil];
    
    if ([topic.playcount integerValue]>10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",[topic.playcount integerValue] / 10000.0];
    }else if ([topic.playcount integerValue] < 0){
        self.playCountLabel.text = @"暂无播放";
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    }
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    //播放按钮设置
    [self.voicePlayButton setImage:[UIImage imageNamed:topic.voicePlaying ? @"playButtonPause":@"playButtonPlay"] forState:UIControlStateNormal];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化player
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        player_ = [AVPlayer playerWithPlayerItem:playerItem];
    });
    
}

/** 点击按钮开始播放声音 */
- (IBAction)buttonDidClickPlaySound:(UIButton *)playButton {
    playButton.selected = !playButton.isSelected;
    lastPlayButton_.selected = !lastPlayButton_.isSelected;
    if (lastTopic_ != self.topic) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.voiceuri]];
        
        [player_ replaceCurrentItemWithPlayerItem:playerItem];
        [player_ play];
        lastTopic_.voicePlaying = NO;
        self.topic.voicePlaying = YES;
        
        [lastPlayButton_ setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
        
    }else{
        if(lastTopic_.voicePlaying){
            [player_ pause];
            self.topic.voicePlaying = NO;
            [playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        }else{
            [player_ play];
            self.topic.voicePlaying = YES;
            [playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
        }
    }
    lastTopic_ = self.topic;
    lastPlayButton_ = playButton;
}


@end

