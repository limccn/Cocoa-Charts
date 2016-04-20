//
//  NSArray+CCSTACompute.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/1.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCSTitledLine.h"

@interface NSArray (CCSTACompute)

- (CCSTitledLine *)computeMAData:(int)period;

- (NSMutableArray *)computeMACDData: (NSInteger)optInFastPeriod optInSlowPeriod:(NSInteger)optInSlowPeriod optInSignalPeriod:(NSInteger)optInSignalPeriod;

- (NSMutableArray *)computeKDJData:(NSInteger)optInFastK_Period optInSlowK_Period:(NSInteger)optInSlowK_Period optInSlowD_Period:(NSInteger)optInSlowD_Period;

- (CCSTitledLine *)computeRSIData:(int)period;

- (NSMutableArray *)computeWRData:(int)period;

- (NSMutableArray *)computeCCIData:(int)period;

- (NSMutableArray *)computeBOLLData:(NSInteger)optInTimePeriod optInNbDevUp:(NSInteger)optInNbDevUp optInNbDevDn:(NSInteger)optInNbDevDn;


- (NSArray *)convertCandleStickData;
- (NSArray *)convertCandleStickLinesData;
- (NSArray *)convertCandleStickBollingerBandData;

- (NSArray *)convertStickData;

- (NSArray *)convertMacdStickData;

- (NSArray *)convertKDJLinesData;

- (NSArray *)convertRSILinesData;

- (NSArray *)convertWRLinesData;

- (NSArray *)convertCCILinesData;

- (NSArray *)convertBOLLLinesData;

@end
