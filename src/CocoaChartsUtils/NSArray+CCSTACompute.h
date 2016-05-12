//
//  NSArray+CCSTACompute.h
//  CocoaChartsUtils
//
//  Created by zhourr on 12/27/13.
//
//  Copyright (C) 2013 ShangHai Okasan-Huada computer system CO.,LTD. All Rights Reserved.
//  See LICENSE.txt for this file’s licensing information
//

#import <Foundation/Foundation.h>

#import "CCSTitledLine.h"

/** 图表中线的颜色 */
#define LINE_COLORS             @[[@"#EA484E" str2ColorWithAlpha:0.9f], [@"#48BF35" str2ColorWithAlpha:0.9f], [@"#00A0E9" str2ColorWithAlpha:0.9f],[UIColor lightGrayColor]]

/** K线图填充色 */
#define CANDLE_STICK_COLORS     @[[@"#F55687" str2Color], [@"#89D326" str2Color]]
/** 指标图填充色 */
#define VOL_STICK_COLORS        @[[@"#F8643F" str2Color], [@"#A9E167" str2Color]]

@interface NSArray (CCSTACompute)

/**
 * 计算MA均线
 */
- (CCSTitledLine *)computeMAData:(CCInt)period;

/**
 * 计算成交量MA均线
 */
- (CCSTitledLine *)computeVOLMAData:(CCInt)period;

/**
 * 计算MACD指标
 */
- (NSMutableArray *)computeMACDData: (CCInt)optInFastPeriod optInSlowPeriod:(CCInt)optInSlowPeriod optInSignalPeriod:(CCInt)optInSignalPeriod;

/**
 * 计算KDJ指标
 */
- (NSMutableArray *)computeKDJData:(CCInt)optInFastK_Period optInSlowK_Period:(CCInt)optInSlowK_Period optInSlowD_Period:(CCInt)optInSlowD_Period;

/**
 * 计算RSI指标
 */
- (CCSTitledLine *)computeRSIData:(CCInt)period;

/**
 * 计算WR指标
 */
- (NSMutableArray *)computeWRData:(CCInt)period;

/**
 * 计算CCI指标
 */
- (NSMutableArray *)computeCCIData:(CCInt)period;

/**
 * 计算BOLL指标
 */
- (NSMutableArray *)computeBOLLData:(CCInt)optInTimePeriod optInNbDevUp:(CCInt)optInNbDevUp optInNbDevDn:(CCInt)optInNbDevDn;

/**
 * 将高开低收等数据转换成图表使用的数据
 */
- (NSArray *)convertCandleStickData;
- (NSArray *)convertCandleStickLinesData:(CCInt)ma1 ma2:(CCInt)ma2 ma3:(CCInt)ma3;
- (NSArray *)convertCandleStickBollingerBandData:(CCInt) bollN;

- (NSArray *)convertStickData;
- (NSArray *)convertStickMAData:(CCInt)ma1 ma2:(CCInt)ma2 ma3:(CCInt)ma3;

- (NSArray *)convertMacdStickData:(CCInt)macdS l:(CCInt)macdL m:(CCInt)macdM;

- (NSArray *)convertKDJLinesData:(CCInt)kdjN;

- (NSArray *)convertRSILinesData:(CCInt) n1 n2:(CCInt) n2;

- (NSArray *)convertWRLinesData:(CCInt) wrN;

- (NSArray *)convertCCILinesData:(CCInt) cciN;

- (NSArray *)convertBOLLLinesData:(CCInt) bollN;

@end

@interface NSMutableArray (Merge)

/**
 * 在前面合并 NSArray
 */
- (void)insertNSArrayToFront:(NSArray *) array;

/**
 * 在后面合并 NSArray
 */
- (void)insertNSArrayToBack:(NSArray *) array;

/**
 * 在前面循环合并线数据 NSArray
 */
- (void)insertLineDataToFront:(NSArray *) array;

@end
