//
//  GFCommentViewController.h
//  GFBS
//
//  Created by apple on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFTopic;
@interface GFCommentViewController : UIViewController

/** 帖子模型数据 */
@property (nonatomic, strong) GFTopic *topic;

@end
