//
//  GFTagButton.m
//  GFBS
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTagButton.h"

@implementation GFTagButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = GFTagBgColor;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    //sizeToFit算完后加三倍的间距
    self.gf_width += 3  * GFTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.gf_x = GFTagMargin;
    self.imageView.gf_x = CGRectGetMaxX(self.titleLabel.frame) + GFTagMargin;
}

@end
