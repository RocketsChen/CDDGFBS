//
//  GFRefreshFooter.m
//  GFBS
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFRefreshFooter.h"

@implementation GFRefreshFooter

-(void)prepare
{
    [super prepare];
    
    //上拉刷新，友情提醒
    [self setTitle:@"已帮您加载完全部数据" forState:MJRefreshStateNoMoreData];
}


@end
