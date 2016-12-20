//
//  GFSubTagViewController.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFSubTagViewController.h"
#import "GFSubTagItem.h"
#import "GFSubTagViewCell.h"

#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>

static NSString *const ID = @"tag";

@interface GFSubTagViewController ()

@property (weak ,nonatomic) GFHTTPSessionManager *manager;

@property (strong , nonatomic)NSArray *tagArray;

@end

@implementation GFSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    
    //注册Cell
    [self regeistCell];

}

#pragma mark - 注册Cell
-(void)regeistCell
{
    
    self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GFSubTagViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:221/255.0 alpha:1.0];
    
    //提示用户正在加载
    [SVProgressHUD showWithStatus:@"正在加载"];
}

#pragma mark - 加载数据
-(void)loadData
{
    //创建请求对话管理者
    GFHTTPSessionManager *manager = [GFHTTPSessionManager manager];
    self.manager = manager;
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [manager GET:GFBSURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        _tagArray = [GFSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self .tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
    }];
    
    
}

#pragma mark - TabView 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tagArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFSubTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    GFSubTagItem *item = self.tagArray[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark - cell行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //消除指示器
    [SVProgressHUD dismiss];
    
    //取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

@end
