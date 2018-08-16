//
//  JWDate.m
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/4.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWSolarDate.h"

@implementation JWSolarDate


+ (instancetype)dateWithDate:(NSDate *)date
{
    JWSolarDate *jw_date    = [JWSolarDate new];
    NSCalendar *calendar    = [NSCalendar currentCalendar];
    jw_date.year            = [calendar component:NSCalendarUnitYear fromDate:date];
    jw_date.month           = [calendar component:NSCalendarUnitMonth fromDate:date];
    jw_date.day             = [calendar component:NSCalendarUnitDay fromDate:date];
    return jw_date;
}

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    JWSolarDate *date   = [JWSolarDate new];
    date.year           = year;
    date.month          = month;
    date.day            = day;
    return date;
}



@end
