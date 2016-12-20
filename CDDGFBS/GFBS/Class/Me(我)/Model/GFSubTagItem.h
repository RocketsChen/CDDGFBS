//
//  GFSubTagItem.h
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFSubTagItem : NSObject


/**
 图片
 */
@property (strong , nonatomic)NSString *image_list;

/**
 订阅数
 */
@property (strong , nonatomic)NSString *sub_number;

/**
 名字
 */
@property (strong , nonatomic)NSString *theme_name;

@end
