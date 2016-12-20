//
//  GFTabBarController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTabBarController.h"
#import "GFNavigationController.h"

#import "GFMeViewController.h"
#import "GFEssenceViewController.h"
#import "GFPublishViewController.h"
#import "GFNewViewController.h"
#import "GFFriendTrendViewController.h"

#import "GFTabBar.h"


@interface GFTabBarController ()

@end

@implementation GFTabBarController

//只加载一次
#pragma mark - 设置tabBar字体格式
+(void)load
{
    UITabBarItem *titleItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //正常
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    //选中
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setUpAllChildView];
    //添加所有按钮内容
    [self setUpTabBarBtn];
    //更换系统tabbar
    [self setUpTabBar];
}

#pragma mark - 更换系统tabbar
-(void)setUpTabBar
{
    GFTabBar *tabBar = [[GFTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    //把系统换成自定义
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 添加所有按钮内容
-(void)setUpTabBarBtn
{
    GFNavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精选";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    GFNavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
    
    GFNavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    
    GFNavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
}

#pragma mark - 添加子控制器
-(void)setUpAllChildView
{
    //精华
    GFEssenceViewController *essence = [[GFEssenceViewController alloc] init];
    GFNavigationController *nav = [[GFNavigationController alloc]initWithRootViewController:essence];
    [self addChildViewController:nav];
    
    //新帖
    GFNewViewController *new = [[GFNewViewController alloc] init];
    GFNavigationController *nav1 = [[GFNavigationController alloc]initWithRootViewController:new];
    [self addChildViewController:nav1];
    
    //关注
    GFFriendTrendViewController *firend = [[GFFriendTrendViewController alloc] init];
    GFNavigationController *nav2 = [[GFNavigationController alloc]initWithRootViewController:firend];
    [self addChildViewController:nav2];
    
    //我
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([GFMeViewController class]) bundle:nil];
    GFMeViewController *me = [storyBoard instantiateInitialViewController];
    GFNavigationController *nav3 = [[GFNavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:nav3];
    
}

@end
