//
//  GFTopicCell.m
//  GFBS
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopicCell.h"
#import "GFTopic.h"
#import "GFComment.h"
#import "GFUser.h"

#import "GFTopicVideoView.h"
#import "GFTopicVoiceView.h"
#import "GFTopicPictureView.h"

#import <UIImageView+WebCache.h>


@interface GFTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;


/*图片View*/
@property (weak ,nonatomic) GFTopicPictureView *pictureView;
/*声音View*/
@property (weak ,nonatomic) GFTopicVoiceView *voiceView;
/*视频View*/
@property (weak ,nonatomic) GFTopicVideoView *videoView;

@end

@implementation GFTopicCell

#pragma mark - 懒加载
-(GFTopicPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [GFTopicPictureView gf_viewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

-(GFTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [GFTopicVideoView gf_viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

-(GFTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [GFTopicVoiceView gf_viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

#pragma mark - 初始化

/**
 弹框
 */
- (IBAction)more:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GFBSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        GFBSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        GFBSLog(@"点击了[取消]按钮");
    }]];
    
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    
}

-(void)setTopic:(GFTopic *)topic
{
    _topic = topic;
    
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"]gf_circleImage];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.profileImageView.image = [image gf_circleImage];
    }];
    self.nameLabel.text = topic.name;
    
    //日期处理
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    /*数量显示以万为界*/
    [self setUpButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setUpButton:self.commentButton number:topic.comment placeholder:@"评论"];
    [self setUpButton:self.repostButton number:topic.repost placeholder:@"分享"];
    
    //最热评论显示或者隐藏
    if (topic.top_cmt) {//有最热评论
        self.topCommentView.hidden = NO;
        
        //展示评论数据
        NSString *content = topic.top_cmt.content;
        NSString *username = topic.top_cmt.user.username;
        
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
        
    }else{//没有最热评论
        
        self.topCommentView.hidden = YES;
    }
    
#pragma mark - 根据类型判断
    if (topic.type == GFTopicTypeWord) {//段子
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == GFTopicTypePicture){//图片
        
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.middleF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == GFTopicTypeVideo){//声音
        
        self.videoView.hidden = NO;
        self.videoView.frame = topic.middleF;
        self.videoView.topic = topic;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }else if (topic.type == GFTopicTypeVoice){//视频
        
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.middleF;
        self.voiceView.topic = topic;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

/**
 设置按钮数字
 */
-(void)setUpButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else
    {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackgroung"]];
}

/**
 重写这个方法：拦截所有cell frame的设置
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= GFMargin;
    frame.origin.y += GFMargin;
    //    frame.origin.x += GFMargin * 0.5;
    //    frame.size.width -= GFMargin;
    
    [super setFrame:frame];
}


@end
