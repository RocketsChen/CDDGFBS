//
//  GFRefreshHeader.m
//  GFBS
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFRefreshHeader.h"

@implementation GFRefreshHeader


/**
 初始化
 */
-(void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor orangeColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    
    [self setTitle:@"下拉精彩不断" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"精彩推送中" forState:MJRefreshStateRefreshing];
    
    
}

@end
