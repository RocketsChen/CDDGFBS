//
//  GFCommentHeaderFooterView.m
//  GFBS
//
//  Created by apple on 2016/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFCommentHeaderFooterView.h"

@implementation GFCommentHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = GFBgColor;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont systemFontOfSize:13];
}

@end
