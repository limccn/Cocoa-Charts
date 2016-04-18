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

#define LINE_COLORS                                     @[[@"#ED4D4D" str2Color], [@"#52BA27" str2Color], [@"#00A0E9" str2Color],[UIColor lightGrayColor]]

@interface NSArray (CCSTACompute)

- (CCSTitledLine *)computeMAData:(NSInteger)period;

- (CCSTitledLine *)computeVOLMAData:(NSInteger)period;

- (NSMutableArray *)computeMACDData: (NSInteger)optInFastPeriod optInSlowPeriod:(NSInteger)optInSlowPeriod optInSignalPeriod:(NSInteger)optInSignalPeriod;

- (NSMutableArray *)computeKDJData:(NSInteger)optInFastK_Period optInSlowK_Period:(NSInteger)optInSlowK_Period optInSlowD_Period:(NSInteger)optInSlowD_Period;

- (CCSTitledLine *)computeRSIData:(NSInteger)period;

- (NSMutableArray *)computeWRData:(NSInteger)period;

- (NSMutableArray *)computeCCIData:(NSInteger)period;

- (NSMutableArray *)computeBOLLData:(NSInteger)optInTimePeriod optInNbDevUp:(NSInteger)optInNbDevUp optInNbDevDn:(NSInteger)optInNbDevDn;

- (NSArray *)convertCandleStickData;
- (NSArray *)convertCandleStickLinesData;
- (NSArray *)convertCandleStickBollingerBandData;

- (NSArray *)convertStickData;

- (NSArray *)convertStickMAData;

- (NSArray *)convertMacdStickData;

- (NSArray *)convertKDJLinesData;

- (NSArray *)convertRSILinesData;

- (NSArray *)convertWRLinesData;

- (NSArray *)convertCCILinesData;

- (NSArray *)convertBOLLLinesData;

@end
