//
//  GFAdItem.h
//  GFBS
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFAdItem : NSObject

/*广告地址*/
@property (nonatomic ,strong)NSString *w_picurl;
/*广告跳转界面*/
@property (nonatomic ,strong)NSString *ori_curl;
/*广告宽*/
@property (nonatomic ,assign)CGFloat w;
/*广告高*/
@property (nonatomic ,assign)CGFloat h;

@end
