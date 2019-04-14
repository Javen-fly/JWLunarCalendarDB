//
//  LunarCalendarDB.m
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/12.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "JWLunarCalendarDB.h"
#import <objc/message.h>
#import "JWSolarDate.h"
#import "JWLunarDate.h"

static __inline__ __attribute__((always_inline)) NSArray* heavenlyStem()
{
    return @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
}
static __inline__ __attribute__((always_inline)) NSArray* earthlyBranch()
{
    return @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
}
static __inline__ __attribute__((always_inline)) NSArray* lunarMonth()
{
    return @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月"];
};
static __inline__ __attribute__((always_inline)) NSArray* monthDay()
{
    return @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
             @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
             @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
};


//static __inline__ __attribute__((always_inline)) NSString *lunarMonthPre
static int jw_leapMonth[kYearDruation] = {
    0x00, 0x00, 0x05, 0x00, 0x00, 0x04, 0x00, 0x00, 0x02, 0x00, //1910
    0x06, 0x00, 0x00, 0x05, 0x00, 0x00, 0x02, 0x00, 0x07, 0x00, //1920
    0x00, 0x05, 0x00, 0x00, 0x04, 0x00, 0x00, 0x02, 0x00, 0x06, //1930
    0x00, 0x00, 0x05, 0x00, 0x00, 0x03, 0x00, 0x07, 0x00, 0x00, //1940
    0x06, 0x00, 0x00, 0x04, 0x00, 0x00, 0x02, 0x00, 0x07, 0x00, //1950
    0x00, 0x05, 0x00, 0x00, 0x03, 0x00, 0x08, 0x00, 0x00, 0x06, //1960
    0x00, 0x00, 0x04, 0x00, 0x00, 0x03, 0x00, 0x07, 0x00, 0x00, //1970
    0x05, 0x00, 0x00, 0x04, 0x00, 0x08, 0x00, 0x00, 0x06, 0x00, //1980
    0x00, 0x04, 0x00, 0x0A, 0x00, 0x00, 0x06, 0x00, 0x00, 0x05, //1990
    0x00, 0x00, 0x03, 0x00, 0x08, 0x00, 0x00, 0x05, 0x00, 0x00, //2000
    0x04, 0x00, 0x00, 0x02, 0x00, 0x07, 0x00, 0x00, 0x05, 0x00, //2010
    0x00, 0x04, 0x00, 0x09, 0x00, 0x00, 0x06, 0x00, 0x00, 0x04, //2020
    0x00, 0x00, 0x02, 0x00, 0x06, 0x00, 0x00, 0x05, 0x00, 0x00, //2030
    0x03, 0x00, 0x0B, 0x00, 0x00, 0x06, 0x00, 0x00, 0x05, 0x00, //2040
    0x00, 0x02, 0x00, 0x07, 0x00, 0x00, 0x05, 0x00, 0x00, 0x03, //2050
    0x00, 0x08, 0x00, 0x00, 0x06, 0x00, 0x00, 0x04, 0x00, 0x00, //2060
    0x03, 0x00, 0x07, 0x00, 0x00, 0x05, 0x00, 0x00, 0x04, 0x00, //2070
    0x08, 0x00, 0x00, 0x06, 0x00, 0x00, 0x04, 0x00, 0x00, 0x03, //2080
    0x00, 0x07, 0x00, 0x00, 0x05, 0x00, 0x00, 0x04, 0x00, 0x08, //2090
    0x00, 0x00, 0x06, 0x00, 0x00, 0x04, 0x00, 0x00, 0x02, 0x00, //2100
};

static int jw_numberOfDayInMonth[kYearDruation] = {
    0x0752, 0x0EA5, 0x164A, 0x064B, 0x0A9B, 0x1556, 0x056A, 0x0B59, 0x1752, 0x0752,//1910
    0x1B25, 0x0B25, 0x0A4B, 0x12AB, 0x0AAD, 0x056A, 0x0B69, 0x0DA9, 0x1D92, 0x0D92,//1920
    0x0D25, 0x1A4D, 0x0A56, 0x02B6, 0x15B5, 0x06D4, 0x0EA9, 0x1E92, 0x0E92, 0x0D26,//1930
    0x052B, 0x0A57, 0x12B6, 0x0B5A, 0x06D4, 0x0EC9, 0x0749, 0x1693, 0x0A93, 0x052B,//1940
    0x0A5B, 0x0AAD, 0x056A, 0x1B55, 0x0BA4, 0x0B49, 0x1A93, 0x0A95, 0x152D, 0x0536,//1950
    0x0AAD, 0x15AA, 0x05B2, 0x0DA5, 0x1D4A, 0x0D4A, 0x0A95, 0x0A97, 0x0556, 0x0AB5,//1960
    0x0AD5, 0x06D2, 0x0EA5, 0x0EA5, 0x064A, 0x0C97, 0x0A9B, 0x155A, 0x056A, 0x0B69,//1970
    0x1752, 0x0B52, 0x0B25, 0x164B, 0x0A4B, 0x14AB, 0x02AD, 0x056D, 0x0B69, 0x0DA9,//1980
    0x0D92, 0x1D25, 0x0D25, 0x1A4D, 0x0A56, 0x02B6, 0x05B5, 0x06D5, 0x0EA9, 0x1E92,//1990
    0x0E92, 0x0D26, 0x0A56, 0x0A57, 0x14D6, 0x035A, 0x06D5, 0x16C9, 0x0749, 0x0693,//2000
    0x152B, 0x052B, 0x0A5B, 0x155A, 0x056A, 0x1B55, 0x0BA4, 0x0B49, 0x1A93, 0x0A95,//2010
    0x052D, 0x0AAD, 0x0AB5, 0x15AA, 0x05D2, 0x0DA5, 0x1D4A, 0x0D4A, 0x0C95, 0x152E,//2020
    0x0556, 0x0AB5, 0x15B2, 0x06D2, 0x0EA5, 0x0725, 0x064B, 0x0C97, 0x0CAB, 0x055A,//2030
    0x0AD6, 0x0B69, 0x1752, 0x0B52, 0x0B25, 0x1A4B, 0x0A4B, 0x04AB, 0x055B, 0x05AD,//2040
    0x0B6A, 0x1B52, 0x0D92, 0x1D25, 0x0D25, 0x0A55, 0x14AD, 0x04B6, 0x05B5, 0x0DAA,//2050
    0x0EC9, 0x1E92, 0x0E92, 0x0D26, 0x0A56, 0x0A57, 0x0456, 0x06D5, 0x0755, 0x0749,//2060
    0x0E93, 0x0693, 0x152B, 0x052B, 0x0A5B, 0x155A, 0x056A, 0x0B65, 0x174A, 0x0B4A,//2070
    0x1A95, 0x0A95, 0x052D, 0x0AAD, 0x0AB5, 0x05AA, 0x0BA5, 0x0DA5, 0x0D4A, 0x1C95,//2080
    0x0C96, 0x194E, 0x0556, 0x0AB5, 0x15B2, 0x06D2, 0x0EA5, 0x0E4A, 0x068B, 0x0C97,//2090
    0x04AB, 0x055B, 0x0AD6, 0x0B6A, 0x0752, 0x1725, 0x0B05, 0x0A8B, 0x149B, 0x04AB //2100
};

static int jw_lunarFirstDayInYear[kYearDruation] = {
    0x0EDA53, 0x0EDC48, 0x0EDE3D, 0x0EE050, 0x0EE244, 0x0EE439, 0x0EE64D, 0x0EE842, 0x0EEA36, 0x0EEC4A,//1910
    0x0EEE3E, 0x0EF052, 0x0EF246, 0x0EF43A, 0x0EF64E, 0x0EF844, 0x0EFA37, 0x0EFC4B, 0x0EFE41, 0x0F0054,//1920
    0x0F0248, 0x0F043C, 0x0F0650, 0x0F0845, 0x0F0A38, 0x0F0C4D, 0x0F0E42, 0x0F1037, 0x0F124A, 0x0F143E,//1930
    0x0F1651, 0x0F1846, 0x0F1A3A, 0x0F1C4E, 0x0F1E44, 0x0F2038, 0x0F224B, 0x0F243F, 0x0F2653, 0x0F2848,//1940
    0x0F2A3B, 0x0F2C4F, 0x0F2E45, 0x0F3039, 0x0F324D, 0x0F3442, 0x0F3636, 0x0F384A, 0x0F3A3D, 0x0F3C51,//1950
    0x0F3E46, 0x0F403B, 0x0F424E, 0x0F4443, 0x0F4638, 0x0F484C, 0x0F4A3F, 0x0F4C52, 0x0F4E48, 0x0F503C,//1960
    0x0F524F, 0x0F5445, 0x0F5639, 0x0F584D, 0x0F5A42, 0x0F5C35, 0x0F5E49, 0x0F603E, 0x0F6251, 0x0F6446,//1970
    0x0F663B, 0x0F684F, 0x0F6A43, 0x0F6C37, 0x0F6E4B, 0x0F703F, 0x0F7252, 0x0F7447, 0x0F763C, 0x0F7850,//1980
    0x0F7A45, 0x0F7C39, 0x0F7E4D, 0x0F8042, 0x0F8254, 0x0F8449, 0x0F863D, 0x0F8851, 0x0F8A46, 0x0F8C3B,//1990
    0x0F8E4F, 0x0F9044, 0x0F9237, 0x0F944A, 0x0F963F, 0x0F9853, 0x0F9A47, 0x0F9C3C, 0x0F9E50, 0x0FA045,//2000
    0x0FA238, 0x0FA44C, 0x0FA641, 0x0FA836, 0x0FAA49, 0x0FAC3D, 0x0FAE52, 0x0FB047, 0x0FB23A, 0x0FB44E,//2010
    0x0FB643, 0x0FB837, 0x0FBA4A, 0x0FBC3F, 0x0FBE53, 0x0FC048, 0x0FC23C, 0x0FC450, 0x0FC645, 0x0FC839,//2020
    0x0FCA4C, 0x0FCC41, 0x0FCE36, 0x0FD04A, 0x0FD23D, 0x0FD451, 0x0FD646, 0x0FD83A, 0x0FDA4D, 0x0FDC43,//2030
    0x0FDE37, 0x0FE04B, 0x0FE23F, 0x0FE453, 0x0FE648, 0x0FE83C, 0x0FEA4F, 0x0FEC44, 0x0FEE38, 0x0FF04C,//2040
    0x0FF241, 0x0FF436, 0x0FF64A, 0x0FF83E, 0x0FFA51, 0x0FFC46, 0x0FFE3A, 0x10004E, 0x100242, 0x100437,//2050
    0x10064B, 0x100841, 0x100A53, 0x100C48, 0x100E3C, 0x10104F, 0x101244, 0x101438, 0x10164C, 0x101842,//2060
    0x101A35, 0x101C49, 0x101E3D, 0x102051, 0x102245, 0x10243A, 0x10264E, 0x102843, 0x102A37, 0x102C4B,//2070
    0x102E3F, 0x103053, 0x103247, 0x10343B, 0x10364F, 0x103845, 0x103A38, 0x103C4C, 0x103E42, 0x104036,//2080
    0x104249, 0x10443D, 0x104651, 0x104846, 0x104A3A, 0x104C4E, 0x104E43, 0x105038, 0x10524A, 0x10543E,//2090
    0x105652, 0x105847, 0x105A3B, 0x105C4F, 0x105E45, 0x106039, 0x10624C, 0x106441, 0x106635, 0x106849 //2100
};

long GetbitInt(long data, long length, long shift)
{
    return (data & (((1 << length) - 1) << shift)) >> shift;
}

long GetDateData(long year, long month, long day)
{
    return (year << 9 | month << 5 | day);
}


@implementation JWLunarCalendarDB

+ (NSInteger)numberOfMonthInYear:(NSInteger)year
{
    return 0;
}

//查询某年的农历年份
+ (NSString *)lunarYearWithYear:(NSInteger)year
{
    NSInteger index = (year - 4) % 60;
    NSArray *heavenlyStemArr = heavenlyStem();
    NSArray *earthlyBranchArr = earthlyBranch();
    return [NSString stringWithFormat:@"%@%@",heavenlyStemArr[index % heavenlyStemArr.count], earthlyBranchArr[index % earthlyBranchArr.count]];
}

//某年闰月的月份
+ (NSInteger)indexOfLeapMonthInYear:(NSInteger)year
{
    return jw_leapMonth[year - kMinYear];
}

//查询某年农历的月份
+ (NSArray *)lunarMonthsInYear:(NSInteger)year
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:lunarMonth()];
    NSInteger indexOfLeapYear = [self indexOfLeapMonthInYear:year];
    if (indexOfLeapYear) {
        NSString *leapMonth = [NSString stringWithFormat:@"闰%@",lunarMonth()[indexOfLeapYear - 1]];
        [array insertObject:leapMonth atIndex:indexOfLeapYear];
    }
    return array;
}

+ (NSInteger)numberOfDayInMonth:(NSInteger)month inYear:(NSInteger)year
{
    NSInteger yearDay = jw_numberOfDayInMonth[year - kMinYear];
    return yearDay & (1 << (month - 1)) ? 30 : 29;
}

+ (NSArray *)monthDayInMonth:(NSInteger)month inYear:(NSInteger)year
{
    NSInteger numberOfDay = [self numberOfDayInMonth:month inYear:year];
    NSMutableArray *array = [NSMutableArray arrayWithArray:monthDay()];
    if (numberOfDay == 29) {
        [array removeLastObject];
    }
    return array;
}

+ (JWLunarDate *)solarToLunar:(JWSolarDate *)date
{
    NSInteger index = date.year - kMinYear;
    long data       = GetDateData(date.year, date.month, date.day);
    int firstData   = jw_lunarFirstDayInYear[index];
    if (firstData > data) {
        index--;
    }
    firstData       = jw_lunarFirstDayInYear[index];
    
    NSInteger year  = GetbitInt(firstData, 12, 9);
    NSInteger month = GetbitInt(firstData, 4, 5);
    NSInteger day   = GetbitInt(firstData, 5, 0);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDayStr   = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",year, month, day];
    NSString *targetDayStr  = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",date.year, date.month, date.day];
    NSDate *firstDay        = [dateFormatter dateFromString:firstDayStr];
    NSDate *targetDay       = [dateFormatter dateFromString:targetDayStr];
    NSTimeInterval interval = [targetDay timeIntervalSinceDate:firstDay];
    NSInteger dayToFirst    = interval / (24 *60 *60);
    NSInteger indexOfLeap   = jw_leapMonth[index];
    NSInteger numberOfMonth = indexOfLeap ? 13 : 12;
    long monthDayData       = jw_numberOfDayInMonth[index];
    NSInteger currentDays   = 0;
    NSInteger indexOfYear   = year;
    NSInteger indexOfMonth  = 1;
    NSInteger indexOfDay    = 1;
    BOOL isLeap             = NO;
    for (; indexOfMonth <= numberOfMonth; indexOfMonth++) {
        NSInteger numberOfDays  = (monthDayData & (1 << (indexOfMonth-1))) ? 30 : 29;
        if (currentDays + numberOfDays > dayToFirst) {
            indexOfDay  = dayToFirst - currentDays + 1;
            if (indexOfLeap && indexOfLeap < indexOfMonth) {
                indexOfMonth --;
                if (indexOfMonth == indexOfLeap) {
                    isLeap = YES;
                }
            }
            break;
        }
        else
        {
            currentDays += numberOfDays;
        }
    }
    JWLunarDate *lunarDate = [JWLunarDate dateWithYear:indexOfYear month:indexOfMonth day:indexOfDay isLeap:isLeap];
    return lunarDate;
}

+ (JWSolarDate *)lunarToSolar:(JWLunarDate *)date
{
    NSInteger monthDay    = jw_numberOfDayInMonth[date.year - kMinYear];
    NSInteger firstDay    = jw_lunarFirstDayInYear[date.year - kMinYear];
    NSInteger leapMonth   = jw_leapMonth[date.year - kMinYear];
    
    NSInteger indexOfMonth= date.month;
    if (leapMonth) {
        if (leapMonth < date.month) {
            indexOfMonth++;
        }
        else if (leapMonth == date.month && date.isLeap)
        {
            indexOfMonth++;
        }
    }
    NSInteger days  = 0;
    
    for (int i = 0; i < indexOfMonth-1; i++) {
        NSInteger numberOfDays = (monthDay & (1 << i)) ? 30 : 29;
        days += numberOfDays;
    }
    days += date.day - 1;
    
    NSInteger year  = firstDay >> 9;
    NSInteger month = (firstDay >> 5 & ((1 << 4) - 1));
    NSInteger day   = firstDay & ((1 << 5) - 1);
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDate = [dateformatter dateFromString:[NSString stringWithFormat:@"%04zd-%02zd-%02zd",year, month, day]];
    NSDate *todayDate = [firstDate dateByAddingTimeInterval:days * 24 * 3600];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    JWSolarDate *solarDate = [JWSolarDate new];
    solarDate.year  = [calendar component:NSCalendarUnitYear fromDate:todayDate];
    solarDate.month = [calendar component:NSCalendarUnitMonth fromDate:todayDate];
    solarDate.day   = [calendar component:NSCalendarUnitDay fromDate:todayDate];
    return solarDate;
}

+ (NSDate *)solarToDate:(JWSolarDate *)date
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateformatter dateFromString:[NSString stringWithFormat:@"%04zd-%02zd-%02zd %02zd:%02zd:%02zd",date.year,date.month,date.day,date.hour,date.minute,date.second]];
}

+ (NSDate *)lunarToDate:(JWLunarDate *)date
{
    JWSolarDate *solarDate = [self lunarToSolar:date];
    return [self solarToDate:solarDate];
}
@end
