//
//  UIImage+GFImage.h
//  GFBS
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GFImage)


/**
 圆形图片对象方法
 */
-(instancetype)gf_circleImage;



/**
 圆形图片类方法
 */
+(instancetype)gf_circleWithImage:(NSString *)imageName;

@end
