//
//  CCSGroupChart.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSColoredStickChart.h"
#import "CCSMACDChart.h"
#import "CCSSlipLineChart.h"
#import "CCSCandleStickChart.h"
#import "CCSBOLLMASlipCandleStickChart.h"
#import "CCSOHLCVDData.h"

#import "JSONModelLib.h"

typedef enum {
    GroupChartViewTypeVOL = 101,
    GroupChartViewTypeMACD = 102,
    GroupChartViewTypeKDJ = 103,
    GroupChartViewTypeRSI = 104,
    GroupChartViewTypeWR = 105,
    GroupChartViewTypeCCI = 106,
    GroupChartViewTypeBOLL = 107
} GroupChartViewType;

typedef enum {
    GroupChartHorizontalType,
    GroupChartverticalType
} GroupChartOrientationType;

@interface CCSGroupChartData : NSObject

@property(strong, nonatomic) NSArray *ohlcvdDatas;

/** CandleStickChartData */
@property(strong, nonatomic) NSArray *candleStickData;
@property(strong, nonatomic) NSArray *candleStickLinesData;
@property(strong, nonatomic) NSArray *candleStickBollingerBandData;

/** StickChart */
@property(strong, nonatomic) NSArray *stickData;

/** MacdChart */
@property(strong, nonatomic) NSArray *macdStickData;

/** KDJChart */
@property(strong, nonatomic) NSArray *kdjLinesData;

/** RSIChart */
@property(strong, nonatomic) NSArray *rsiLinesData;

/** WRChart */
@property(strong, nonatomic) NSArray *wrLinesData;

/** CCIChart */
@property(strong, nonatomic) NSArray *cciLinesData;

/** BOLLChart */
@property(strong, nonatomic) NSArray *bollLinesData;

- (id)initWithCCSOHLCVDDatas:(NSArray *)ohlcvdDatas;

- (void)updateMACDStickData:(NSInteger)macdS l:(NSInteger)macdL m:(NSInteger)macdM;
- (void)updateCandleStickLinesData:(NSInteger)ma1 ma2:(NSInteger)ma2 ma3:(NSInteger)ma3;
- (void)updateCandleStickBollingerBandData:(NSInteger) bollN;
- (void)updateKDJData:(NSInteger)macdN;
- (void)updateRSIData:(NSInteger) n1 n2:(NSInteger) n2;
- (void)updateWRData:(NSInteger) wrN;
- (void)updateCCIData:(NSInteger) cciN;
- (void)updateBOLLData:(NSInteger) bollN;

@end

@interface CCSGroupChart : UIView<UIScrollViewDelegate>

/*******************************************************************************
 * initialize
 *******************************************************************************/

- (void)initialize;

/*******************************************************************************
 * Public Properties
 *******************************************************************************/

@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UILabel *lblOpen;
@property(strong, nonatomic) UILabel *lblHigh;
@property(strong, nonatomic) UILabel *lblLow;
@property(strong, nonatomic) UILabel *lblClose;
@property(strong, nonatomic) UILabel *lblVolume;
@property(strong, nonatomic) UILabel *lblDate;
@property(strong, nonatomic) UILabel *lblChange;
@property(strong, nonatomic) UILabel *lblPreClose;
@property(strong, nonatomic) UILabel *lblSubTitle1;
@property(strong, nonatomic) UILabel *lblSubTitle2;
@property(strong, nonatomic) UILabel *lblSubTitle3;
@property(strong, nonatomic) UILabel *lblSubTitle4;
@property(strong, nonatomic) UILabel *lblSubTitle5;
@property(strong, nonatomic) UILabel *lblSubTitle6;
@property(strong, nonatomic) UILabel *lblSubTitle7;
@property(strong, nonatomic) UILabel *lblSubTitle8;
@property(strong, nonatomic) UILabel *lblSubTitle9;
@property(strong, nonatomic) UILabel *lblSubTitle10;
@property(strong, nonatomic) CCSColoredStickChart *stickChart;
@property(strong, nonatomic) CCSBOLLMASlipCandleStickChart *candleStickChart;
@property(strong, nonatomic) CCSMACDChart *macdChart;
@property(strong, nonatomic) CCSSlipLineChart *kdjChart;
@property(strong, nonatomic) CCSSlipLineChart *rsiChart;
@property(strong, nonatomic) CCSSlipLineChart *wrChart;
@property(strong, nonatomic) CCSSlipLineChart *cciChart;
@property(strong, nonatomic) CCSSlipLineChart *bollChart;
@property(strong, nonatomic) UISegmentedControl *segBottomChartType;
@property(strong, nonatomic) UIScrollView *scrollViewBottomChart;

@property(assign, nonatomic) GroupChartViewType bottomChartType;
@property(strong, nonatomic) CCSOHLCVDData *oHLCVDData;
@property(strong, nonatomic) NSMutableArray *chartData;

@property(strong, nonatomic) CCSGroupChartData *groupChartData;

@property(weak, nonatomic) UIViewController<CCSChartDelegate> *chartDelegate;

@property(assign, nonatomic) GroupChartOrientationType orientationType;

/** 设置 */
@property (nonatomic, copy) void (^setting)();

/*******************************************************************************
 * Public Methods
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index;
- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number;

- (void)setChartsBackgroundColor:(UIColor *)backgroundColor;

- (void)updateCandleStickChart;
- (void)updateMACDChart;
- (void)updateKDJChart;
- (void)updateRSIChart;
- (void)updateWRChart;
- (void)updateCCIChart;
- (void)updateBOLLChart;

@end
