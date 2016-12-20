//
//  GFSubTagViewCell.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFSubTagViewCell.h"
#import "GFSubTagItem.h"

#import <UIImageView+WebCache.h>

@interface GFSubTagViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;

@end

@implementation GFSubTagViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

/**
 设置数据

 */
-(void)setItem:(GFSubTagItem *)item
{
    _item = item;
    
    self.nameView.text = item.theme_name;
    
    //判断有没有超过一万
    NSString *numS = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    NSInteger num = [item.sub_number integerValue];
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numS = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        [numS stringByReplacingOccurrencesOfString:@".0" withString:@""];
        self.numView.text = numS;
        [self.numView setFont:[UIFont systemFontOfSize:15]];
        [self.numView setTextColor:[UIColor grayColor]];
        
    }
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage gf_circleWithImage:@"defaultUserIcon"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!image) return ; // 图片下载失败直接返回
        
        self.iconView.image = [image gf_circleImage];
        
    }];
    

}


/**
 通过这个方法可以设置cell下面的条 间隔多少都可以
 */
-(void)setFrame:(CGRect)frame
{
    //给cell赋值
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
