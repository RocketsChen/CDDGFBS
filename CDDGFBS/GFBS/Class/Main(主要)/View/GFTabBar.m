//
//  GFTabBar.m
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTabBar.h"
#import "GFPublishView.h"

@interface GFTabBar()
@property (nonatomic,weak)UIButton *publishBtn;
/** 上一次点击的按钮 */
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation GFTabBar

/**
 懒加载
 */
-(UIButton *)publishBtn
{
    if (!_publishBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        [button addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        /*******自适应**********/
        [button sizeToFit];
        _publishBtn = button;
    }
    return _publishBtn;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnH = self.gf_height;
    CGFloat btnW = self.gf_width / (self.items.count + 1);
    
    CGFloat X = 0;
    NSInteger i = 0;
    //遍历
    for (UIControl *tabBar in self.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i += 1;
            }
            
            X = i * btnW;
            tabBar.frame = CGRectMake(X, 0, btnW, btnH);
            
            i++;
            
            // 监听点击
            [tabBar addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.publishBtn.center = CGPointMake(self.gf_width * 0.5, self.gf_height * 0.5);
}
/**
 *  tabBarButton的点击
 */
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickedTabBarButton == tabBarButton) {
        // 发出通知，告知外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:GFTabBarButtonDidRepeatShowClickNotificationCenter object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}
/**
 *  弹出发布控制器
 */
- (void)publishButtonClick
{
    GFPublishView *publishView = [GFPublishView gf_publishView];
    [[UIApplication sharedApplication].keyWindow addSubview:publishView];
    publishView.frame = [UIApplication sharedApplication].keyWindow.bounds;
}
@end
