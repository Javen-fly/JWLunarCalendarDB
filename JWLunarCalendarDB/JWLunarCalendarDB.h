//
//  LunarCalendarDB.h
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/12.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JWSolarDate.h"
#import "JWLunarDate.h"

#define kMinYear        1901
#define kYearDruation   200

@interface JWLunarCalendarDB : NSObject

/** 查询农历某年的月数 */
+ (NSInteger)numberOfMonthInYear:(NSInteger)year;

/** 查询农历某年闰月的月份，0表示没有 */
+ (NSInteger)indexOfLeapMonthInYear:(NSInteger)year;

/** 查询某年的农历年份*/
+ (NSString *)lunarYearWithYear:(NSInteger)year;

/** 查询某年农历的月份 */
+ (NSArray *)lunarMonthsInYear:(NSInteger)year;

/** 查询某月有多少天，月为当年第几个月 */
+ (NSInteger)numberOfDayInMonth:(NSInteger)month inYear:(NSInteger)year;

/** 每月完整的天 */
+ (NSArray *)monthDayInMonth:(NSInteger)month inYear:(NSInteger)year;

/** 公历转农历 */
+ (JWLunarDate *)solarToLunar:(JWSolarDate *)date;
/** 农历转公历 */
+ (JWSolarDate *)lunarToSolar:(JWLunarDate *)date;
/** 公历转NSDate */
+ (NSDate *)solarToDate:(JWSolarDate *)date;
/** 农历转NSDate */
+ (NSDate *)lunarToDate:(JWLunarDate *)date;

@end
