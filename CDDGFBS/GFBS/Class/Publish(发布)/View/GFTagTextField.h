//
//  GFTagTextField.h
//  GFBS
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTagTextField : UITextField

/** block 按了删除键后回调 */
@property (nonatomic, copy) void(^deleteBlock)();

@end
