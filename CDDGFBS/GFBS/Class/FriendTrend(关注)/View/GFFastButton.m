//
//  GFFastButton.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFFastButton.h"

@implementation GFFastButton

-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.gf_y = 0;
    self.imageView.gf_centerX = self.gf_width * 0.5;
    
    //自己计算文字的宽
    [self.titleLabel sizeToFit];
    //设置lable
    self.titleLabel.gf_centerX = self.gf_width * 0.5;
    self.titleLabel.gf_y = self.gf_height - self.titleLabel.gf_height;
    
    
}
@end
