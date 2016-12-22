//
//  GFPlaceholderTextView.h
//  GFBS
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//  占位文字（TextView）

#import <UIKit/UIKit.h>

@interface GFPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
