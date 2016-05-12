//
//  CocoaChartsHeader.h
//  Cocoa-Charts
//
//  Created by zhourr on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#ifndef CocoaChartsHeader_h
#define CocoaChartsHeader_h

// Data
#import "CCSTimeData.h"
#import "CCSHandicapData.h"
#import "CCSTickData.h"
#import "CCSProductData.h"
#import "CCSKLineData.h"

// Utils
#import "NSArray+CCSTACompute.h"
#import "CCSStringUtils.h"
#import "NSString+UserDefault.h"
#import "NSString+UIColor.h"
#import "UIView+AutoLayout.h"

/** 白天模式,背景色 */
#define CONTENT_BACKGROUND_DAY                      [@"#FFFFFF" str2Color]
/** 夜间模式,背景色 */
#define CONTENT_BACKGROUND_NIGHT                    [@"#16181E" str2Color]

/**
 * 主题
 */
typedef NS_ENUM(NSInteger, ThemeModeType) {
    ThemeDayMode,
    ThemeNightMode
};

/**
 * K线图数据类型
 */
typedef enum {
    ChartDayData = 0,
    ChartWeekData = 1,
    ChartMonthData = 2,
    Chart1minuteData = 3,
    Chart5minuteData = 4,
    Chart15minuteData = 5,
    Chart30minuteData = 6,
    Chart1hourData = 7,
    Chart2hourData = 8,
    Chart4hourData = 9
} ChartDataType;

/**
 * 当前显示什么功能
 */
typedef NS_ENUM(NSInteger, DisplayType) {
    DisplayNoneType,
    DisplayHandicapType,
    DisplayTickType,
    Display2DaysType,
    Display3DaysType,
    DisplayDetailType,
    DisplayDayKLineType,
    DisplayWeekKLineType,
    DisplayMonthKLineType,
    Display1MinKLineType,
    Display5MinKLineType,
    Display15MinKLineType,
    Display30MinKLineType,
    Display1HourKLineType,
    Display2HourKLineType,
    Display4HourKLineType
};

/**
 * 指标参数类型
 */
typedef NS_ENUM(NSInteger, IndicatorType) {
    IndicatorMACD,
    IndicatorVMA,
    IndicatorMA,
    IndicatorKDJ,
    IndicatorRSI,
    IndicatorWR,
    IndicatorCCI,
    IndicatorBOLL
};

// IIF
#if !defined(IIF)
#define IIF_IMPL(condition,true_,false_) (condition)?true_:false_
#define IIF(condition,true_,false_) IIF_IMPL(condition,true_,false_)
#endif

// 在主线程中执行
#define DO_IN_MAIN_QUEUE(action) dispatch_async(dispatch_get_main_queue(), action)
// 在主线程中延迟执行
#define DO_IN_MAIN_QUEUE_AFTER(seconds, action) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), action)

// 在子线程中执行
#define DO_IN_BACKGROUND(action) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), action)
// 在子线程中延迟执行
#define DO_IN_BACKGROUND_AFTER(seconds, action) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), action)

#endif /* CocoaChartsHeader_h */
