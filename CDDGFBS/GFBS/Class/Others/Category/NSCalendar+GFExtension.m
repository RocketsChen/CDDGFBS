//
//  NSCalendar+GFExtension.m
//  GFBS
//
//  Created by apple on 2016/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSCalendar+GFExtension.h"

@implementation NSCalendar (GFExtension)

+(instancetype)gf_calendar
{
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        return  [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else
    {
        return [NSCalendar currentCalendar];
    }
}

@end
