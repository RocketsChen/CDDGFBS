//
//  GFMemberField.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFMemberField.h"
#import "UITextField+GFPlaceholder.h"

@implementation GFMemberField


/**
 1.文本框光标为白色
 2.输入时占位文字为白色
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //设置光标变为白色
    self.tintColor = [UIColor whiteColor];
    
    //开始编辑
    [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
    
    //结束编辑
    [self addTarget:self action:@selector(finishEdit) forControlEvents:UIControlEventEditingDidEnd];
    
    
    //利用工具类方法直接设置颜色
    self.placeholderColor = [UIColor lightGrayColor];
        
}

#pragma mark - 开始编辑
-(void)beginEdit
{
    self.placeholderColor = [UIColor whiteColor];
}

#pragma mark - 结束编辑
-(void)finishEdit
{
    self.placeholderColor = [UIColor lightGrayColor];
}



@end
