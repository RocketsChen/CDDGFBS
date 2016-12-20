//
//  NSDate+GFExtension.m
//  GFBS
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDate+GFExtension.h"

@implementation NSDate (GFExtension)

/**
 判断时间是否为今年
 */
-(BOOL)isThisYear
{
    //self 调用这个方法的时间
    NSCalendar *calender = [NSCalendar gf_calendar];
    
    NSInteger selfYear = [calender component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calender component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    //判断是否为今年
    return selfYear == nowYear;
}


/**
 是否为今天
 */
-(BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowDay = [fmt stringFromDate:[NSDate date]];
    
    return [selfString isEqualToString:nowDay];
}

/**
 是否为昨天
 */
-(BOOL)isYesterday
{
    //转两次
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowDay = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowDay];
    
    NSCalendar *calendar = [NSCalendar gf_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];  
    
    return comps.year == 0 &&
    comps.month == 0 &&
    comps.day == -1 ;
}

/**
 是否为明天
 */
-(BOOL)isTommorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyy-MM-dd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowDay = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowDay];
    
    NSCalendar *calendar = [NSCalendar gf_calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0 &&
    comps.month == 0 &&
    comps.day == 1 ;
}

@end
