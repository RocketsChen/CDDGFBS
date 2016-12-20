//
//  GFMeViewController.m
//  GFBS
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFMeViewController.h"
#import "GFWebViewController.h"
#import "GFSettingViewController.h"

#import "GFSquareItem.h"
#import "GFSquareCell.h"

#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <AFNetworking.h>

static NSString *const ID = @"ID";
static NSInteger const cols = 4;
static CGFloat  const margin = 1;
#define itemHW  (GFScreenWidth - (cols - 1) * margin ) / cols


@interface GFMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/*数据*/
@property (strong , nonatomic)NSMutableArray *squareItems;

/**
 collectionView
 */
@property (weak ,nonatomic) UICollectionView *collectionView;

@end

@implementation GFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNavBar];
    
    //设置tableview底部视图
    [self setUpFooterView];
    
    //请求数据
    [self loadData];
    
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}


#pragma mark - 请求数据
-(void)loadData
{
    //1.创建请求对话管理者
    GFHTTPSessionManager *manager = [GFHTTPSessionManager manager];
    
    //2.凭借请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //发送请求
    [manager GET:GFBSURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        
        NSArray *dictArray = responseObject[@"square_list"];
        //字典数组转成模型数组
        _squareItems = [GFSquareItem mj_objectArrayWithKeyValuesArray:dictArray];
        
        //处理数据
        [self resoveData];
        
        //设置collectionview高度 = rows * itemWH
        //Rows = (count - 1) / cols + 1
        NSInteger rows = (_squareItems.count - 1) /  cols + 1;
        self.collectionView.gf_height = rows * itemHW + cols * margin ;
        
        //设置tableview滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 数据处理
-(void)resoveData
{
    NSInteger count = _squareItems.count;
    NSInteger exter = count % cols;
    
    if (exter) {
        exter = cols - exter;
        for (NSInteger i = 0; i<exter; i++) {
            GFSquareItem *item = [[GFSquareItem alloc]init];
            [self.squareItems addObject:item];
        }
    }
}

#pragma mark - 设置tableview底部视图
-(void)setUpFooterView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置尺寸
    layout.itemSize = CGSizeMake(itemHW, itemHW);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.collectionView = collectionView;
    self.tableView.tableFooterView = collectionView;
    //关闭滚动
    collectionView.scrollEnabled = NO;
    
    //设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GFSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _squareItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFSquareItem *item = _squareItems[indexPath.item];
    //判断
    if (![item.url containsString:@"http"]) return;

    NSURL *url = [NSURL URLWithString:item.url];
    GFWebViewController *webVc = [[GFWebViewController alloc]init];
    [self.navigationController pushViewController:webVc animated:YES];
    
    //给Url赋值
    webVc.url = url;

}



#pragma mark - 设置导航条
-(void)setUpNavBar
{
    //右边
    UIBarButtonItem *item1 = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] WithHighlighted:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(setting)];
    UIBarButtonItem *item2 = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] WithSelected:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(moon:)];

    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    
    //Titie
    self.navigationItem.title = @"我的";
}


-(void)setting
{
    //XIB加载
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([GFSettingViewController class]) bundle:nil];
    
    GFSettingViewController *settingVc = [storyBoard instantiateInitialViewController];
    [self.navigationController pushViewController:settingVc animated:YES];
}

-(void)moon:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
@end
