//
//  JWLunarDate.m
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/15.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWLunarDate.h"
#import "JWLunarCalendarDB.h"

@implementation JWLunarDate

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day isLeap:(BOOL)isLeap
{
    JWLunarDate *date = [JWLunarDate new];
    date.year           = year;
    date.month          = month;
    date.day            = day;
    date.isLeap         = isLeap;
    return date;
}


- (void)setDay:(NSInteger)day
{
    _day = day;
    _dayStr = [JWLunarCalendarDB lunarDayStrWithDayIndex:day];
}

- (void)setMonth:(NSInteger)month
{
    _month      = month;
    _monthStr   = [JWLunarCalendarDB lunarMonthStrWithMonthIndex:month isLeap:_isLeap];
}

- (void)setIsLeap:(BOOL)isLeap
{
    _isLeap     = isLeap;
    _monthStr   = [JWLunarCalendarDB lunarMonthStrWithMonthIndex:_month isLeap:isLeap];
}
@end
