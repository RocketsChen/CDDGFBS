//
//  NSDate+GFExtension.h
//  GFBS
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GFExtension)



/**
 是否为今年
 */
-(BOOL)isThisYear;

/**
 是否为今天
 */
-(BOOL)isToday;

/**
 是否为昨天
 */
-(BOOL)isYesterday;

/**
 是否为明天
 */
-(BOOL)isTommorrow;

@end
