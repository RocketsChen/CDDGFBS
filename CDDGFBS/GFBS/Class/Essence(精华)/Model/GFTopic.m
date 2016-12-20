//
//  GFTopic.m
//  GFBS
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFTopic.h"
#import "GFUser.h"

#import <MJExtension.h>

@implementation GFTopic

/*全局变量 */
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

//+ (NSDictionary *)mj_objectClassInArray {
//
//    return @{@"top_cmt" : [GFComment class]
//             };
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]",
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

-(CGFloat)cellHeight
{
    //如果cell高度已经计算处理 就直接返回 
    if (_cellHeight) return _cellHeight;
    //头像
    _cellHeight = GFiconH;
    
    //文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * GFMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    _cellHeight += textSize.height + GFMargin;
    
    //中间
    if (self.type != GFTopicTypeWord) {
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= GFScreenHeight) {//超长图片
            contentH = GFLargImageCompressH;
            self.is_largeImage = YES;
        }
        //中间内容的Frame
        CGRect middleF = CGRectMake(GFMargin, _cellHeight, textMaxW, contentH);
        self.middleF = middleF;
        
        _cellHeight += contentH + GFMargin;
        
    }
   
    //最热评论
    if (self.top_cmt) {
        _cellHeight += GFHotCommentLabel ;
        //展示评论数据
        NSString *content = self.top_cmt.content;
        if(self.top_cmt.voiceuri.length)
        {
            content = @"语言评论''";
        }
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, content];

        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + GFMargin;
        
    }
    //底部工具条
    _cellHeight += GFDcrcH + GFMargin;
    
    return _cellHeight;
}


/**
 只调用一次
 */
+(void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar gf_calendar];
}

/**
 日期处理get方法
 */
-(NSString *)created_at
{
    //将服务器返回的数据进行处理
    fmt_.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creatAtDate = [fmt_ dateFromString:_created_at];
    
    //判断
    if (creatAtDate.isThisYear) {//今年
        if ([calendar_ isDateInToday:creatAtDate]) {//今天
            //当前时间
            NSDate *nowDate = [NSDate date];
            
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comps = [calendar_ components:unit fromDate:creatAtDate toDate:nowDate options:0];
            
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else
            {
                return @"刚刚";
            }
            
        }else if ([calendar_ isDateInYesterday:creatAtDate]){//昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:creatAtDate];
            
        }else{//其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:creatAtDate];
            
        }
        
    }else{//非今年
        return _created_at;
    }
    
    return _created_at;
}

/**
 今年
    今天
       时间间隔 >= 一个小时 @“5小时前”
       1分钟 > 时间间隔 >= 1分钟  @"10分钟前"
       1分钟 < 时间间隔  @“刚刚”
    昨天
       @“昨天 23:13:02”
    其他
       @“10-13 12:13:02”
 
 
 非今年 
       @“2015-02-10 08:09:10”
 */


@end
