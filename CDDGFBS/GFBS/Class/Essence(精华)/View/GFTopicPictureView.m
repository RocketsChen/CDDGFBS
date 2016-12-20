//
//  GFTopicPictureView.m
//  GFBS
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopicPictureView.h"
#import "GFTopic.h"

#import "GFSeeBigImageViewController.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>


@interface GFTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView  *progressView;


@end

@implementation GFTopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //从Xib中加载进来的控件默认 UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //圆角
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigImage)];
    self.pictureImageView.userInteractionEnabled = YES;
    [self.pictureImageView addGestureRecognizer:gesture];
    
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

    self.progressView.hidden = NO;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //receivedSize已接受  expectedSize总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
    
    //gif的判断
    self.gifView.hidden = !topic.is_gif;
    
    if (topic.is_largeImage) {
        self.seeBigButton.hidden = NO;
        self.pictureImageView.contentMode = UIViewContentModeTop;
        self.pictureImageView.clipsToBounds = YES;
        
    }else{
        self.seeBigButton.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
        self.pictureImageView.clipsToBounds = NO;
    }
    
    //提示
    

}




//    //网络判断
//    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
//    [netManager startMonitoring];
//    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
//
//        if (status == AFNetworkReachabilityStatusNotReachable)
//        {
//            [[[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil]show];
//            NSLog(@"没有网络");
//
//        }else if (status == AFNetworkReachabilityStatusUnknown){
//
//            NSLog(@"未知网络");
//
//        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
//
//            NSLog(@"WiFi");
//
//        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//
//            NSLog(@"手机网络");
//        }
//
//    }];
@end
