//
//  GFComment.h
//  GFBS
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GFUser;
@interface GFComment : NSObject



/** id */
@property (nonatomic, copy) NSString *ID;

/** 内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (strong , nonatomic)GFUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频路径 */
@property (nonatomic, copy) NSString *voiceuri;

@end
