//
//  GFTopWindow.m
//  GFBS
//
//  Created by apple on 2016/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopWindow.h"
#import "GFTopViewController.h"

@implementation GFTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[self alloc] init];
}

+ (void)gf_show
{
    window_.hidden = NO;
    window_.backgroundColor = [UIColor clearColor];
}

+ (void)gf_hide
{
    window_.hidden = YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert;
        self.rootViewController = [[GFTopViewController alloc] init];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame = [UIApplication sharedApplication].statusBarFrame;
    [super setFrame:frame];
}


@end
