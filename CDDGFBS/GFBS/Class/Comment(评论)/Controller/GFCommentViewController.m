//
//  GFCommentViewController.m
//  GFBS
//
//  Created by apple on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFCommentViewController.h"

#import "GFCommentHeaderFooterView.h"
#import "GFCommentCell.h"
#import "GFTopicCell.h"
#import "GFTopic.h"
#import "GFComment.h"

#import "GFRefreshHeader.h"
#import "GFRefreshFooter.h"

#import <MJExtension.h>


static NSString *const commentID = @"commnet";
static NSString *const headID = @"head";
@interface GFCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*请求管理者*/
@property (weak ,nonatomic) GFHTTPSessionManager *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<GFComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<GFComment *> *latestComments;

/** 最热评论 */
@property (nonatomic, strong) GFComment *savedTopCmt;
@end

@implementation GFCommentViewController

#pragma mark - 懒加载
-(GFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [GFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpBase];
    
    [self setUpTableView];

    [self setUpRefresh];
    
    [self setUpHeadView];

}

-(void)setUpHeadView
{
    // 模型数据处理：把最热评论影藏
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    //注册
    [self.tableView registerClass:[GFCommentHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headID];
    //嵌套一个View
    UIView *head = [[UIView alloc] init];
    GFTopicCell *topicCell = [GFTopicCell gf_viewFromXib];
    topicCell.backgroundColor = [UIColor whiteColor];
    topicCell.topic = self.topic;
    
    topicCell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    
    // 设置header的高度
    head.gf_height = topicCell.gf_height + GFMargin * 2;
    
    self.tableView.tableHeaderView = head;
    [head addSubview:topicCell];

    //头部View高度
    self.tableView.sectionHeaderHeight = [UIFont systemFontOfSize:13].lineHeight + GFMargin;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(GFNavMaxY, 0, 0, 0);
}

-(void)setUpRefresh
{
    self.tableView.mj_header = [GFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [GFRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
}

#pragma mark - 加载网络数据
-(void)loadNewComment
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @1; 
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:GFBSURL parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        // 字典数组转模型数组
        weakSelf.latestComments = [GFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [GFComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) { // 全部加载完毕
            // 隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];

}

-(void)loadMoreComment
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:GFBSURL parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            return;
        }
        // 字典数组转模型数组
        NSArray *moreComment = [GFComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComment];
        
        [weakSelf.tableView reloadData];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        if (weakSelf.latestComments.count ==  total) {
            
            //结束刷新
            weakSelf.tableView.mj_footer.hidden = YES;
            
        }else
        {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)setUpTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GFBgColor;

    
    //cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}


-(void)setUpBase
{
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

#pragma mark - 监听
-(void)KeyboardWillChangeFrame:(NSNotification *)not
{
    //修改约束
    CGFloat kbY = [not.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat screenH = GFScreenHeight;
    
    self.bottomMargin.constant = screenH - kbY;
    
    CGFloat duration = [not.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //最热评论  这样返回到之前界面会出现最热评论
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

/**
 当用户开始拖拽就会调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - tableview代理和数据源

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GFCommentHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headID];
    //第0组 并且 有最热评论数
    if (section == 0 && self.hotestComments.count) {
        headView.textLabel.text = @"最热评论";
    }else{
    headView.textLabel.text = @"最新评论";
    }
    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //最热和最新评论数据判断
    if (self.hotestComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //第0组 并且 有最热评论数
    if (section == 0 && self.hotestComments.count) {
       return self.hotestComments.count;
    }
    return self.latestComments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID forIndexPath:indexPath];
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = _hotestComments[indexPath.row];
    }else{
        cell.comment = _latestComments[indexPath.row];
    }
    
    
    return cell;
}



//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    //第0组 并且 有最热评论数
//    if (section == 0 && self.hotestComments.count) {
//        return @"最热评论";
//    }
//    return @"最新评论";
//
//}

@end
