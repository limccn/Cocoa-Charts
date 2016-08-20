//
//  NSDate+Convert.m
//  FinanceInfo
//
//  Created by zhourr_ on 16/1/18.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import "NSDate+Convert.h"

@implementation NSDate (Convert)

/**
 * 日期格式转换
 */
- (NSString *)convertDateWithFormat:(NSString *)format{
    // 实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    // 返回转换后的字符
    return [dateFormatter stringFromDate:self];
}
/**
 * 时间是否早于 compareDate
 */
- (BOOL)earlierThan:(NSDate *) compareDate{
    return [self timeIntervalSince1970] < [compareDate timeIntervalSince1970];
}

/**
 * 时间是否晚于 compareDate
 */
- (BOOL)laterThan:(NSDate *) compareDate{
    return [self timeIntervalSince1970] > [compareDate timeIntervalSince1970];
}

@end

