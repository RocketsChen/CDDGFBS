//
//  GFTopicViewController.h
//  GFBS
//
//  Created by apple on 2016/11/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFTopic.h"

@interface GFTopicViewController : UITableViewController

/*类型判断*/
//@property (assign ,nonatomic) GFTopicType type;

/**
 产生get方法
 限时成员访问和任意修改 使.(点)语法失效
 */
-(GFTopicType)type;

@end
