//
//  UIView+GFFrame.h
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GFFrame)
/**
 避免冲突：加前缀
 
 */
@property CGSize gf_size;

@property CGFloat gf_width;

@property CGFloat gf_height;

@property CGFloat gf_x;

@property CGFloat gf_y;


@property CGFloat gf_centerX;

@property CGFloat gf_centerY;

+(instancetype)gf_viewFromXib;

- (BOOL)isShowingOnKeyWindow;


@end
