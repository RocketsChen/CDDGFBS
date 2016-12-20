//
//  GFSquareCell.m
//  GFBS
//
//  Created by apple on 2016/11/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFSquareCell.h"
#import "GFSquareItem.h"

#import <UIImageView+WebCache.h>

@interface GFSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation GFSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setItem:(GFSquareItem *)item
{
    _item = item;
    
    
    self.titleLable.text = item.name;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:nil];
    
}


@end
