//
//  UIImage+GFImage.m
//  GFBS
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+GFImage.h"

@implementation UIImage (GFImage)

-(instancetype)gf_circleImage
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.width)];
    //设置裁剪区域
    [path addClip];
    //画图形
    [self drawAtPoint:CGPointZero];
    //取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

+(instancetype)gf_circleWithImage:(NSString *)name
{
    return [[self imageNamed:name]gf_circleImage];
}

@end
