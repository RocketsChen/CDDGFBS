//
//  GFAddToolBar.m
//  GFBS
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFAddToolBar.h"

@interface GFAddToolBar()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation GFAddToolBar

+(instancetype)gf_toolbar
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    //添加一个加号
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.gf_size = addButton.currentImage.size;
    addButton.gf_x = GFMargin;
    [self.topView addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addButtonClick
{
    GFBSLogFunc;
}

@end
