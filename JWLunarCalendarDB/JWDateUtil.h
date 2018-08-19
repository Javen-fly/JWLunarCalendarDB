//
//  JWDateUtil.h
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/2/24.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMinYear 1901

@interface JWDateUtil : NSObject

/** 公历年份数据 */
+ (NSArray *)gregorianCalendarYearArr;

/** 公历月份数据 */
+ (NSArray *)gregorianCalendarMonthArr;

/** 公历日数据 */
+ (NSArray *)gregorianCalendarDayArrWithYear:(NSInteger)year month:(NSInteger)month;

/** 农历年份数据 */
+ (NSArray *)lunarCalendarYearArr;

/** 农历月份数据 */
+ (NSArray *)lunarCalendarMonthArrWithYear:(NSInteger)year;

/** 农历日数据,month第几个月 */
+ (NSArray *)lunarCalendarDayArrWithYear:(NSInteger)year month:(NSInteger)month;

/** 公历与农历混合数据 */
+ (NSArray *)mixCalendarYaerArr;

/** 混合显示时 农历月份数据 */
+ (NSArray *)mixlunarCalendarMonthArrWithYear:(NSInteger)year;


/** 时数据 */
+ (NSArray *)hourArrInDay;
/** 分数据 */
+ (NSArray *)minuteArrInHour;
/** 秒数据 */
+ (NSArray *)secondArrInMinute;

@end
