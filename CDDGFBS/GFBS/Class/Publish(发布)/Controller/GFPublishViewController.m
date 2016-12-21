//
//  GFPublishViewController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFPublishViewController.h"
#import "GFFastButton.h" 

@interface GFPublishViewController ()

@end

@implementation GFPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标语slogan
    UIImageView *titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    titleImageView.gf_y = GFScreenHeight * 0.15;
    titleImageView.gf_centerX = GFScreenWidth * 0.5;
    [self.view addSubview:titleImageView];
    
    
    //中间按钮处理
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖子",@"离线下载"];
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    NSInteger maxCols = 3;
    CGFloat buttonStratX = 2 * GFMargin;
    CGFloat buttonXMargin = (GFScreenWidth - 2 * buttonStratX - maxCols * buttonW) / (maxCols - 1);
    CGFloat buttonYMargin = GFMargin;
    
    CGFloat buttonStratY = (GFScreenHeight - 2 * buttonH) * 0.5;
    for (NSInteger i = 0 ; i < titles.count; i++) {
        GFFastButton *button = [GFFastButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        NSInteger row = i / maxCols;
        NSInteger col = i % maxCols;
        button.frame = CGRectMake(buttonStratX + col * (buttonW + buttonXMargin), buttonStratY + row * (buttonH + buttonYMargin), buttonW, buttonH);
        [self.view addSubview:button];
    }
    
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
