//
//  GFAddTagsViewController.m
//  GFBS
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFAddTagsViewController.h"

#import "GFTagButton.h"
#import "GFTagTextField.h"

#import <SVProgressHUD.h>

@interface GFAddTagsViewController ()<UITextFieldDelegate>

/* 内容View */
@property (weak , nonatomic)UIView *contentView;
/* 文本输入框 */
@property (weak , nonatomic)GFTagTextField *textField;
/* 添加Button */
@property (weak , nonatomic)UIButton *addButton;

/*tags数组(所有标签按钮)*/
@property (strong , nonatomic)NSMutableArray *tagButtons;


@end

@implementation GFAddTagsViewController

#pragma mark - 懒加载
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.gf_width = self.contentView.gf_width;
        addButton.gf_height = 35;
        addButton.backgroundColor = GFTagBgColor;
        addButton.titleLabel.font = GFTagFont;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, GFTagMargin, 0, GFTagMargin);
        //让按钮内部的文字和图片左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpContentView];
    
    [self setUpTextField];
    
    [self setUpTags];

}

#pragma mark - 初始化传过来Tag的标签
- (void)setUpTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
}

#pragma mark - 基本设置

- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

#pragma mark - 初始化ContentView和TextField
- (void)setUpContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(GFMargin, 64 + GFMargin, self.view.gf_width - 2 * GFMargin, GFScreenHeight);
    [self.view addSubview:contentView];
    _contentView = contentView;
}

- (void)setUpTextField
{
    GFTagTextField *textField = [[GFTagTextField alloc] init];
    textField.gf_width = self.contentView.gf_width;
    [textField becomeFirstResponder];
    textField.delegate = self;
    __weak typeof(self)weakSelf = self;
    textField.deleteBlock = ^{//删除Block
        if (weakSelf.textField.hasText) return; //未成标签原样删除
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
    [textField addTarget:self action:@selector(textFieldContentDidChange) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:textField];
    _textField = textField;

}


#pragma mark - 点击完成按钮事件
- (void)done
{
    //传递按钮(传递数组)【kvc】
    NSArray *tags = [_tagButtons valueForKeyPath:@"currentTitle"];
    !_tagsBlock ? : _tagsBlock(tags); //Block传递
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听文字的改变
- (void)textFieldContentDidChange
{
    //判断是否有文字hasText属性
    if (_textField.hasText) {
        _addButton.hidden = NO;
        _addButton.gf_y = CGRectGetMaxY(self.textField.frame) + GFTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",_textField.text] forState:UIControlStateNormal];
        
        //获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger length = text.length;
        NSString *lastNsstring = [text substringFromIndex:length - 1];
        if (([lastNsstring isEqualToString:@","] || [lastNsstring isEqualToString:@"，"]) && length > 1)  {
            //去除逗号
            self.textField.text = [text substringToIndex:length - 1];
            [self addButtonClick];
        }
        
    }else{//没有文字
        //隐藏添加标签按钮
        _addButton.hidden = YES;
    }
    //每次改变文字都需要更新一下
    [self updateTagButtonAndTextFieldFrame];
}

#pragma mark - 监听添加标签按钮点击
- (void)addButtonClick
{
    if (_tagButtons.count == 5) {//最多五个
        [SVProgressHUD showErrorWithStatus:@"最多添加五个标签哦！"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    //添加标签按钮
    GFTagButton *tagButton = [GFTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.gf_height = self.textField.gf_height;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    //更新标签按钮ButtonFrame
    [self updateTagButtonAndTextFieldFrame];
    
    //清空textField内容 隐藏添加标签按钮
    self.textField.text = nil;
    self.addButton.hidden = YES;
}

#pragma mark - 更新标签按钮Frame和textField的frame
- (void)updateTagButtonAndTextFieldFrame
{
    //更新标签按钮Frame
    for (NSInteger i = 0; i < _tagButtons.count; i++ ) {
        UIButton *tagButton = self.tagButtons[i];
        if (i == 0) { //第一个标签按钮
            tagButton.gf_x = 0;
            tagButton.gf_y = 0;
        }else{
            UIButton *lastTagButton = self.tagButtons[i - 1];
            //当前行左边宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + GFTagMargin;
            //当前行右边宽度
            CGFloat rightWidth = self.contentView.gf_width - leftWidth;
            if (rightWidth >= tagButton.gf_width) { // 显示当前行
                tagButton.gf_y = lastTagButton.gf_y;
                tagButton.gf_x = leftWidth;
            }else{// 显示下一行
                tagButton.gf_x = 0;
                tagButton.gf_y = CGRectGetMaxY(lastTagButton.frame) + GFTagMargin;
            }
        }
    }
    
    //更新textFieldFrame
    //最后一个tagButton
    UIButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + GFTagMargin;
    if (self.contentView.gf_width - leftWidth >= [self textFieldWidth]) {//更新textField的frame(本行)
        
        self.textField.gf_x = leftWidth;
        self.textField.gf_y = lastTagButton.gf_y;

    }else{//更新textField的frame(下一行)
        
        self.textField.gf_x = 0;
        self.textField.gf_y = CGRectGetMaxY(lastTagButton.frame) + GFTagMargin;
    }
}


#pragma mark - 标签按钮的点击
- (void)tagButtonClick:(GFTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    [UIView animateWithDuration:0.25 animations:^{
        //更新frame
        [self updateTagButtonAndTextFieldFrame];
    }];

}



#pragma mark - <UITextFieldDelegate>

/**
 监听键盘右下角按键点击 returnKey
 */
- (BOOL)textFieldShouldReturn:(GFTagTextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

#pragma mark - textField文字宽度
- (CGFloat)textFieldWidth
{
    CGFloat textWidth =  [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(150, textWidth);
}


#pragma mark - 键盘弹出和退出
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 先退出之前的键盘
    [self.view endEditing:YES];
    // 再叫出键盘
    [self.textField becomeFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}


@end
