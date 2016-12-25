//
//  GFPublishView.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFPublishView.h"

#import "GFPostWordViewController.h"
#import "GFNavigationController.h"
#import "GFFastButton.h" 
#import <POP.h>

#define  GFrootView [UIApplication sharedApplication].keyWindow.rootViewController.view

@interface GFPublishView ()

@end

@implementation GFPublishView

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    //窗口View不可以点击
    GFrootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    //中间按钮
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
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算Frame
        NSInteger row = i / maxCols;
        NSInteger col = i % maxCols;
        CGFloat buttonX = buttonStratX + col * (buttonW + buttonXMargin);
        CGFloat buttonEndY = buttonStratY + row * (buttonH + buttonYMargin);
        CGFloat buttonBeginY = buttonEndY - GFScreenHeight;
        [self addSubview:button];
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //标语
    UIImageView *titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    titleImageView.gf_y = GFScreenHeight * 0.15 - GFScreenHeight;
    [self addSubview:titleImageView];
    
    CGFloat centerX = GFScreenWidth * 0.5;
    CGFloat titleStartY = titleImageView.gf_y;
    CGFloat titleEndY = GFScreenHeight * 0.15;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    [titleImageView pop_addAnimation:anim forKey:nil];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, titleStartY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, titleEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;

    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //动画结束，恢复点击事件
        GFrootView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
    
}

#pragma mark - 点击取消
- (IBAction)cancel:(id)sender {
    [self cancelWithCompletionBlock:nil];
}

#define 回调点击动画
- (void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    GFrootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO; 
    
    NSInteger beginI = 2;
    for (NSInteger i = beginI; i < self.subviews.count; i++) {
        
        UIView *currentView = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat endY = currentView.gf_y + GFScreenHeight;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(currentView.gf_centerX, endY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginI) * 0.1;
        [currentView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.subviews.count - 1) {

            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {

                GFrootView.userInteractionEnabled =YES;
                self.userInteractionEnabled = YES;
                [self removeFromSuperview];
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

#pragma mark - 按钮点击
- (void)buttonClick:(GFFastButton *)button
{
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖子",@"离线下载"];
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            GFBSLog(@"点击%@",titles[button.tag]);
        }else if (button.tag == 1){
            GFBSLog(@"点击%@",titles[button.tag]);
        }else if (button.tag == 2){
            //点击了发段子
            GFPostWordViewController *postWord = [[GFPostWordViewController alloc] init];
            GFNavigationController *nav = [[GFNavigationController alloc]initWithRootViewController:postWord];
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
            
            GFBSLog(@"点击%@",titles[button.tag]);
        }else if (button.tag == 3){
            GFBSLog(@"点击%@",titles[button.tag]);
        }else if (button.tag == 4){
            GFBSLog(@"点击%@",titles[button.tag]);
        }else if (button.tag == 5){
            GFBSLog(@"点击%@",titles[button.tag]);
        }
    }];
    
}


/**
 点击屏幕空白处，退出界面
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}


+(instancetype)gf_publishView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
