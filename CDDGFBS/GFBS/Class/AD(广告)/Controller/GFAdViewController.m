//
//  GFAdViewController.m
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFAdViewController.h"
#import "GFTabBarController.h"

#import "GFAdItem.h"

#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"



@interface GFAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContent;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (weak ,nonatomic) UIImageView *adView;
@property (weak ,nonatomic) NSTimer *timer;
@property (strong ,nonatomic) GFAdItem *item;



@end

@implementation GFAdViewController

-(UIImageView *)adView
{
    if (!_adView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        [self.adContent addSubview:imageView];
        _adView = imageView;
        [imageView sizeToFit];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
        [imageView addGestureRecognizer:tap];
    }
    return _adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片
    [self setUpLaunchImage];
    
    //加载网络数据
    [self setUpAd];
    
    //创建定时器
    [self setUpNsTimer];
    
}
#pragma mark - 定时器
-(void)setUpNsTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
}

#pragma mark - 定时器运作和销毁广告界面
-(void)timerChange
{
    static NSInteger i = 3;
    
    if (i == 0) {
        GFTabBarController *tabVc = [[GFTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
        
        //去掉定时器
        [_timer invalidate];
    }
    
    --i;
    
    //设置跳转文字
    [self.jumpBtn setTitle:[NSString stringWithFormat:@" 跳转 (%zd) ",i] forState:UIControlStateNormal];
}

- (IBAction)jumpDismiss:(id)sender {
    
    GFTabBarController *tabVc = [[GFTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVc;
    
    //去掉定时器
    [_timer invalidate];
}

#pragma mark - 跳转
-(void)jump
{
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

#pragma mark - 加载网络数据
-(void)setUpAd
{
    GFHTTPSessionManager *manager = [GFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [manager GET:GFBSADURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSDictionary *adDict = [responseObject[@"ad"]lastObject];
        GFAdItem *item = [GFAdItem mj_objectWithKeyValues:adDict];
        
        self.item = item;
//        CGFloat W = GFScreenWidth;
//        CGFloat H = (GFScreenWidth / item.w) * item.h;
        self.adView.frame = CGRectMake(0, 0 , GFScreenWidth, GFScreenHeight);
        
        [self.adView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 设置启动图片
-(void)setUpLaunchImage
{
    if (iphone6p) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iphone6){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if (iphone5){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
    }else if (iphone4){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage"];
    }
}

@end
