//
//  GFTagTextField.m
//  GFBS
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTagTextField.h"

@implementation GFTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.placeholder = @"多个标签用换行或者逗号隔开!";
        //修改占位文字颜色(kvc)[注意：苹果内部懒加载：设置了占位文字以后才能设置或修改颜色]
        [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.gf_height = GFTagHeight;
    }
    return self;
}

- (void)deleteBackward
{
    //监听删除点击(block一旦有值调用)
    !_deleteBlock ? : _deleteBlock();
    
     [super deleteBackward];
}

@end
