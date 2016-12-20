//
//  GFUser.h
//  GFBS
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;  // m： 男    f： 女
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
