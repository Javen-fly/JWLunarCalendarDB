//
//  JWDateUtil.m
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/2/24.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWDateUtil.h"
#import "JWLunarCalendarDB.h"
#define kYearNumber 200

@implementation JWDateUtil
//公历年数据
+ (NSArray *)gregorianCalendarYearArr
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:kYearNumber];
    int i = 1;
    while (i <= kYearNumber) {
        [array addObject:[NSString stringWithFormat:@"%04d",1900 + i]];
        i++;
    }
    return [NSArray arrayWithArray:array];
}
//公历月数据
+ (NSArray *)gregorianCalendarMonthArr
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:12];
    int i = 0;
    while (i < 12) {
        [array addObject:[NSString stringWithFormat:@"%d",++i]];
    }
    return array;
}
//公历日数据
+ (NSArray *)gregorianCalendarDayArrWithYear:(NSInteger)year month:(NSInteger)month
{
    NSInteger numberOfDay = 0;
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            numberOfDay = 31;
            break;
        case 4:case 6:case 9:case 11:
            numberOfDay = 30;
            break;
        case 2:
        {
            if (!(year%400) || (!(year %4) && (year % 100))) {
                numberOfDay = 29;
            }
            else
            {
                numberOfDay = 28;
            }
        }
        default:
            break;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:12];
    int i = 0;
    while (i < numberOfDay) {
        [array addObject:[NSString stringWithFormat:@"%d",++i]];
    }
    return array;
}

//农历年数据
+ (NSArray *)lunarCalendarYearArr
{
    NSArray *gregorizanYearArr = [self gregorianCalendarYearArr];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:gregorizanYearArr.count];
    for (int i = 0; i < gregorizanYearArr.count; i++) {
        NSInteger year = [gregorizanYearArr[i] integerValue];
        NSString *lunarY = [JWLunarCalendarDB lunarYearWithYear:year];
        NSString *lyear = [NSString stringWithFormat:@"%@(%04zd~%04zd)",lunarY, year, year + 1];
        [array addObject:lyear];
    }
    return array;
}

//农历月数据
+ (NSArray *)lunarCalendarMonthArrWithYear:(NSInteger)year
{
    return [JWLunarCalendarDB lunarMonthsInYear:year];
}

+ (NSArray *)lunarCalendarDayArrWithYear:(NSInteger)year month:(NSInteger)month
{
    return [JWLunarCalendarDB monthDayInMonth:month inYear:year];
}


//时数据
+ (NSArray *)hourArrInDay
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:24];
    int i = 0;
    while (i < 24) {
        [array addObject:[NSString stringWithFormat:@"%02d",i++]];
    }
    return array;
}
//分数据
+ (NSArray *)minuteArrInHour
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:60];
    int i = 0;
    while (i < 60) {
        [array addObject:[NSString stringWithFormat:@"%02d",i++]];
    }
    return array;
}
//秒数据
+ (NSArray *)secondArrInMinute
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:60];
    int i = 0;
    while (i < 60) {
        [array addObject:[NSString stringWithFormat:@"%02d",i++]];
    }
    return array;
}
//待完善
+ (NSArray *)mixCalendarYaerArr
{
    return nil;
}

+ (NSArray *)mixlunarCalendarMonthArrWithYear:(NSInteger)year
{
    return nil;
}
@end
