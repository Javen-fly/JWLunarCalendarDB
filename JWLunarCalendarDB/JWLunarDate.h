//
//  JWLunarDate.h
//  JWPickerViewDemo
//
//  Created by 吴建文 on 2018/3/15.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWLunarDate : NSObject

@property (nonatomic, copy) NSString* yearStr;
@property (nonatomic, copy) NSString* monthStr;
@property (nonatomic, copy) NSString* dayStr;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) BOOL isLeap;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day isLeap:(BOOL)isLeap;
- (void)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day isLeap:(BOOL)isLeap;

@end
