//
//  GFAddToolBar.m
//  GFBS
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFAddToolBar.h"
#import "GFAddTagsViewController.h"
#import "GFNavigationController.h"

@interface GFAddToolBar()

@property (weak, nonatomic) IBOutlet UIView *topView;

/*按钮*/
@property (weak ,nonatomic) UIButton *addButton;

/*存放tagLabel数组*/
@property (strong , nonatomic)NSMutableArray *tagLabels;

@end

@implementation GFAddToolBar

#pragma mark - 懒加载
-(NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

#pragma mark - 初始化
-(void)awakeFromNib
{
    [super awakeFromNib];
    //添加一个加号
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    _addButton = addButton;
    addButton.gf_size = addButton.currentImage.size;
    addButton.gf_x = GFMargin;
    [self.topView addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatTags:@[@"吐槽",@"糗事"]]; //创建默认两个标签
}

#pragma mark - 添加按钮点击
- (void)addButtonClick
{
    GFAddTagsViewController *addTagsVc = [[GFAddTagsViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    addTagsVc.tagsBlock = ^(NSArray *tags){
        [weakSelf creatTags:tags];
    };
    addTagsVc.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addTagsVc animated:YES];
    
}

#pragma mark - 计算布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < self.tagLabels.count; i++) {
        UILabel *tagsLabel = self.tagLabels[i];
        //设置位置
        if (i == 0) { //第一个标签Label
            tagsLabel.gf_x = 0;
            tagsLabel.gf_y = 0;
        }else{
            UILabel *lastTagLabel = _tagLabels[i - 1];
            //当前行左边宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + GFTagMargin;
            //当前行右边宽度
            CGFloat rightWidth = self.topView.gf_width - leftWidth;
            if (rightWidth >= tagsLabel.gf_width) { // 显示当前行
                tagsLabel.gf_y = lastTagLabel.gf_y;
                tagsLabel.gf_x = leftWidth;
            }else{// 显示下一行
                tagsLabel.gf_x = 0;
                tagsLabel.gf_y = CGRectGetMaxY(lastTagLabel.frame) + GFTagMargin;
            }
        }
    }
    //更新addButtonFrame
    //最后一个lastTagLabel
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + GFTagMargin;
    if (self.topView.gf_width - leftWidth >= self.addButton.gf_width) {//更新addButton的frame(本行)
        
        self.addButton.gf_x = leftWidth;
        self.addButton.gf_y = lastTagLabel.gf_y;
        
    }else{//更新addButton的frame(下一行)
        
        self.addButton.gf_x = 0;
        self.addButton.gf_y = CGRectGetMaxY(lastTagLabel.frame) + GFTagMargin;
    }
    
    //整体高度 (防止之前通过y算出后中间留有空白)
    CGFloat oldHeight = self.gf_height;
    self.gf_height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.gf_y -= self.gf_height - oldHeight;
}

#pragma mark - 创建tagLabel
- (void)creatTags:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (NSInteger i = 0; i < tags.count; i++) {
        UILabel *tagsLabel = [[UILabel alloc] init];
        tagsLabel.backgroundColor = GFTagBgColor;
        tagsLabel.text = tags[i];
        tagsLabel.textColor = [UIColor whiteColor];
        tagsLabel.textAlignment = NSTextAlignmentCenter;
        tagsLabel.font = GFTagFont;
        [tagsLabel sizeToFit];
        tagsLabel.gf_height = self.addButton.gf_height;
        tagsLabel.gf_width += 2 * GFTagMargin;
        [self.topView addSubview:tagsLabel];
        [self.tagLabels addObject:tagsLabel];
    }
    //重新计算Frame （layoutSubviews 只调用一次）
    [self setNeedsLayout];

}


+(instancetype)gf_toolbar
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
/**
 a model b
 a.presentedViewController -> b
 b.presentingViewController -> a
 */

@end
