//
//  JWLunarDate.m
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/15.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWLunarDate.h"
#import "JWLunarCalendarDB.h"
#import "JWDateUtil.h"
@implementation JWLunarDate

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day isLeap:(BOOL)isLeap
{
    JWLunarDate *date = [JWLunarDate new];
    date.year           = year;
    date.month          = month;
    date.day            = day;
    date.isLeap         = isLeap;
    date.yearStr        = [JWLunarCalendarDB lunarYearWithYear:year];
    date.monthStr       = [[JWLunarCalendarDB lunarMonthsInYear:year]objectAtIndex:month - 1];
    date.dayStr         = [[JWDateUtil lunarCalendarDayArrWithYear:year month:month]objectAtIndex:day - 1];
    return date;
}

- (void)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day isLeap:(BOOL)isLeap
{
    _year   = year;
    _month  = month;
    _day    = day;
    _isLeap = isLeap;
}
@end
