//
//  GFAddTagsViewController.h
//  GFBS
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFAddTagsViewController : UIViewController

//获取tagsBlock
@property (nonatomic, copy) void(^tagsBlock)(NSArray *tags);

/*所有标签*/
@property (strong , nonatomic)NSArray *tags;

@end
