//
//  GFFastLoginView.m
//  GFBS
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFFastLoginView.h"

@implementation GFFastLoginView

+ (instancetype)FastLoginViewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
