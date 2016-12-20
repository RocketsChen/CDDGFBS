//
//  GFLoginRegisterView.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFLoginRegisterView.h"

@interface GFLoginRegisterView()
@property (weak, nonatomic) IBOutlet UIButton *memberBtn;


@end

@implementation GFLoginRegisterView

+ (instancetype)LoginViewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
+ (instancetype)RegisterViewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *image = _memberBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    //设置button不拉伸的图片
    [_memberBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_memberBtn setBackgroundImage:image forState:UIControlStateHighlighted];
}
@end
