//
//  JWDate.h
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/4.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWSolarDate : NSObject

@property (nonatomic, assign) BOOL isLunar;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;

@property (nonatomic, assign) NSInteger weekDay;

+ (instancetype)dateWithDate:(NSDate *)date;
+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
- (void)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
@end
