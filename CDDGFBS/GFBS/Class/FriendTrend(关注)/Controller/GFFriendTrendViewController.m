//
//  GFFriendTrendViewController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFFriendTrendViewController.h"
#import "GFMemberViewController.h"
#import "GFRecommendViewController.h"

@interface GFFriendTrendViewController ()

@end

@implementation GFFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavBar];
}

#pragma mark - 跳转到登录界面
- (IBAction)JumpLoginViewController {
    
    //跳转到GFMemberViewController
    GFMemberViewController *memberVc = [[GFMemberViewController alloc] init];
    
    [self presentViewController:memberVc animated:YES completion:nil];
    
}
#pragma mark - 跳转到注册界面
- (IBAction)JumpRegisterViewController {
    
    
    
}
#pragma mark - 设置导航条
-(void)setUpNavBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] WithHighlighted:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(friendsRecommentIcon)];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"Search"] WithHighlighted:[UIImage imageNamed:@"Search-click"] Target:self action:@selector(Search)];
    
    
    //Titie
    self.navigationItem.title = @"关注";
}

-(void)friendsRecommentIcon
{
    GFRecommendViewController *recommendVc = [[GFRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVc animated:YES];
}

-(void)Search
{
    
}

@end
