//
//  GFMemberViewController.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFMemberViewController.h"

#import "GFLoginRegisterView.h"
#import "GFFastLoginView.h"

@interface GFMemberViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleLeading;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation GFMemberViewController

- (IBAction)CloseViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ExchangeLoginAndRegister:(UIButton *)sender {
    //Btn取反
    sender.selected = !sender.selected;
    
    
    //切换
    self.middleLeading.constant = self.middleLeading.constant == 0 ? -self.middleView.gf_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加登录View
    GFLoginRegisterView *loginView = [GFLoginRegisterView LoginViewFromXib];
    [self.middleView addSubview:loginView];
    
    //添加注册View
    GFLoginRegisterView *registerView = [GFLoginRegisterView RegisterViewFromXib];
    [self.middleView addSubview:registerView];
    
    //添加快速登录View
    GFFastLoginView *fastLoginView = [GFFastLoginView FastLoginViewFromXib];
    [self.bottomView addSubview:fastLoginView];
    
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //设置登录viewFram
    GFLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.gf_width * 0.5, self.middleView.gf_height);
    
    //设置注册viewFram
    GFLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.gf_width * 0.5, 0, self.middleView.gf_width * 0.5, self.middleView.gf_height);
    
    //设置快速登录viewFram
    GFFastLoginView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = CGRectMake(0, 0, self.bottomView.gf_width, self.bottomView.gf_height);
    
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
