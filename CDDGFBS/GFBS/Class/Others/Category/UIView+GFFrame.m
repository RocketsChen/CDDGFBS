//
//  UIView+GFFrame.m
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+GFFrame.h"

@implementation UIView (GFFrame)

-(CGSize)gf_size
{
    return self.frame.size;
}

-(void)setGf_size:(CGSize)gf_size
{
    CGRect gf = self.frame;
    gf.size = gf_size;
    self.frame = gf;
}


-(CGFloat)gf_height
{
    return self.frame.size.height;
}

-(void)setGf_height:(CGFloat)gf_height
{
    CGRect gf = self.frame;
    gf.size.height = gf_height;
    self.frame = gf;
}


-(CGFloat)gf_width
{
    return self.frame.size.width;
}

-(void)setGf_width:(CGFloat)gf_width
{
    CGRect gf = self.frame;
    gf.size.width = gf_width;
    self.frame = gf;
}


-(CGFloat)gf_x
{
    return self.frame.origin.x;
}

-(void)setGf_x:(CGFloat)gf_x
{
    CGRect gf = self.frame;
    gf.origin.x = gf_x;
    self.frame = gf;
}



-(CGFloat)gf_y
{
    return self.frame.origin.y;
}

-(void)setGf_y:(CGFloat)gf_y
{
    CGRect gf = self.frame;
    gf.origin.y = gf_y;
    self.frame = gf;
}


-(CGFloat)gf_centerX
{
    return self.center.x;
}

-(void)setGf_centerX:(CGFloat)gf_centerX
{
    CGPoint rect = self.center;
    rect.x = gf_centerX;
    self.center = rect;
}


-(CGFloat)gf_centerY
{
    return self.center.y;
}

-(void)setGf_centerY:(CGFloat)gf_centerY
{
    CGPoint rect = self.center;
    rect.y = gf_centerY;
    self.center = rect;
}


+(instancetype)gf_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}


@end
