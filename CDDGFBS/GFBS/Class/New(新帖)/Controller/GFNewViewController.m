//
//  GFNewViewController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFNewViewController.h"
#import "GFSubTagViewController.h"

#import "GFMemberViewController.h"

@interface GFNewViewController ()

@end

@implementation GFNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavBar];
    
    self.view.backgroundColor = GFBgColor;
}


#pragma mark - 设置导航条
-(void)setUpNavBar
{
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] WithHighlighted:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(MainTagSubIcon)];
    
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"careful"] WithHighlighted:[UIImage imageNamed:@"careful_click"] Target:self action:@selector(jumpCarefulViewController)];
    
    
    //TitieView
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

-(void)MainTagSubIcon
{
    GFSubTagViewController *subTagVc = [[GFSubTagViewController alloc]init];
    [self.navigationController pushViewController:subTagVc animated:YES];
    
}

-(void)jumpCarefulViewController
{
    GFMemberViewController *memberVc = [[GFMemberViewController alloc]init];
    [self presentViewController:memberVc animated:YES completion:nil];
    
}
@end
