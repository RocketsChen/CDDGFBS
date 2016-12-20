//
//  GFRecommendViewController.m
//  GFBS
//
//  Created by apple on 2016/12/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFRecommendViewController.h"
#import "GFConst.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "GFHTTPSessionManager.h"

@interface GFRecommendViewController ()

@end

static NSString *const categoryID = @"category";
@implementation GFRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTab];

    
}


-(void)setUpTab
{
    self.title = @"推荐关注";
    self.view.backgroundColor = GFBgColor;

}


@end
