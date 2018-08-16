//
//  ViewController.m
//  JWLunarCalendarDBDemo
//
//  Created by 吴建文 on 2018/3/26.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "ViewController.h"
#import "JWLunarCalendarDB.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *yearTF;
@property (weak, nonatomic) IBOutlet UITextField *monthTF;
@property (weak, nonatomic) IBOutlet UITextField *dayTF;
@property (weak, nonatomic) IBOutlet UILabel *resultLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




- (IBAction)solarToLunar:(id)sender {
    NSInteger year  = 0;
    NSInteger month = 0;
    NSInteger day   = 0;
    if (!_yearTF.text.length || [_yearTF.text integerValue] < kMinYear || [_yearTF.text integerValue] > kMaxYear) {
        return;
    }
    else if (!_monthTF.text.length || [_monthTF.text integerValue] < 1 || [_monthTF.text integerValue] > 12)
    {
        return;
    }
    else if (!_dayTF.text.length || [_dayTF.text integerValue] < 1)
    {
        return;
    }
    else
    {
        year = [_yearTF.text integerValue];
        month = [_monthTF.text integerValue];
        switch (month) {
            case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            {
                if (day > 31) {
                    return;
                }
            }
            break;
            case 4:case 6:case 9:case 11:
            {
                if (day > 30) {
                    return;
                }
            }
            break;
            case 2:
            {
                if (!(day%400) || (!(day % 4) && (day % 100))) {
                    if (day > 29) {
                        return;
                    }
                }
                else
                {
                    if (day > 28) {
                        return;
                    }
                }
            }
            default:
            break;
        }
        day = [_dayTF.text integerValue];
    }
    
    JWSolarDate *solarDate = [JWSolarDate dateWithYear:year month:month day:day];
    JWLunarDate *lunarDate = [JWLunarCalendarDB solarToLunar:solarDate];
    _resultLab.text = [NSString stringWithFormat:@"农历:%04zd%@%@",lunarDate.year,lunarDate.monthStr,lunarDate.dayStr];
    
}



@end
