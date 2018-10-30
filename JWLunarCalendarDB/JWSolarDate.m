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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [self dateWithYear:components.year month:components.month day:components.day];
}

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    JWSolarDate *date   = [JWSolarDate new];
    date.year           = year;
    date.month          = month;
    date.day            = day;
    return date;
}

- (void)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    _year   = year;
    _month  = month;
    _day    = day;
}
@end
