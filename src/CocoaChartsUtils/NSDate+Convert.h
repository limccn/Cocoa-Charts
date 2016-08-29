//
//  NSDate+Convert.h
//  FinanceInfo
//
//  Created by zhourr_ on 16/1/18.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convert)

/**
 * 日期格式转换
 */
- (NSString *)convertDateWithFormat:(NSString *)format;

/**
 * 时间是否早于 compareDate
 */
- (BOOL)earlierThan:(NSDate *) compareDate;

/**
 * 时间是否晚于 compareDate
 */
- (BOOL)laterThan:(NSDate *) compareDate;

@end
