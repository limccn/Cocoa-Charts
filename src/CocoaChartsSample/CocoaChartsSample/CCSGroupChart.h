//
//  CCSGroupChart.h
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

#import <UIKit/UIKit.h>

#import "CCSColoredStickChart.h"
#import "CCSMACDChart.h"
#import "CCSSlipLineChart.h"
#import "CCSCandleStickChart.h"
#import "CCSBOLLMASlipCandleStickChart.h"
#import "CCSMAColoredStickChart.h"

#import "CCSOHLCVDData.h"

#define BORDER_COLOR                                    [@"#E8E9EA" str2Color]
#define GRID_LINE_COLOR                                 [@"#E8E9EA" str2Color]

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

typedef enum {
    MergeFrontType,
    MergeBackType,
    MergeReplaceType
} MergeDataType;

@interface CCSGroupChartData : NSObject

/** 源时间格式 */
@property(copy, nonatomic) NSString                   *sourceDateFormat;
/** 转换成的时间格式 */
@property(copy, nonatomic) NSString                   *targetDateFormat;

/** 当前显示的指标类型 */
@property(assign, nonatomic) GroupChartViewType        displayChartType;
/** 合并的数据的数量 */
@property(assign, nonatomic) CCInt                     mergeCount;
/** 是否可以加载更多条数据 */
@property(assign, nonatomic) BOOL                      canLoadMore;

@property(assign, nonatomic) CCInt                     displayFrom;
@property(assign, nonatomic) CCInt                     displayNumber;

@property(strong, nonatomic) NSMutableArray           *ohlcvdDatas;

/** CandleStickChartData */
@property(strong, nonatomic) NSMutableArray           *candleStickData;
@property(strong, nonatomic) NSMutableArray           *candleStickLinesData;
@property(strong, nonatomic) NSMutableArray           *candleStickBollingerBandData;

/** StickChart */
@property(strong, nonatomic) NSMutableArray           *stickData;
@property(strong, nonatomic) NSMutableArray           *stickMAData;

/** MacdChart */
@property(strong, nonatomic) NSMutableArray           *macdStickData;

/** KDJChart */
@property(strong, nonatomic) NSMutableArray           *kdjLinesData;

/** RSIChart */
@property(strong, nonatomic) NSMutableArray           *rsiLinesData;

/** WRChart */
@property(strong, nonatomic) NSMutableArray           *wrLinesData;

/** CCIChart */
@property(strong, nonatomic) NSMutableArray           *cciLinesData;

/** BOLLChart */
@property(strong, nonatomic) NSMutableArray           *bollLinesData;

/**
 * 初始化数据
 */
- (id)initWithCCSOHLCVDDatas:(NSArray *)ohlcvdDatas displayChartType:(GroupChartViewType) displayChartType sourceDateFormat:(NSString *) sourceDateFormat targetDateFormat:(NSString *)targetDateFormat;

/**
 * 合并数据
 */
- (void)mergeWithCCSOHLCVDDatas:(NSArray *)ohlcvdDatas mergeType:(MergeDataType) mergeType;

/**
 * 更新某个指标
 */
- (void)updateMACDStickData:(CCInt)macdS l:(CCInt)macdL m:(CCInt)macdM;
- (void)updateCandleStickLinesData:(CCInt)ma1 ma2:(CCInt)ma2 ma3:(CCInt)ma3;
- (void)updateStickData;
- (void)updateCandleStickBollingerBandData:(CCInt) bollN;
- (void)updateStickLinesData:(CCInt)ma1 ma2:(CCInt)ma2 ma3:(CCInt)ma3;
- (void)updateKDJData:(CCInt)macdN;
- (void)updateRSIData:(CCInt) n1 n2:(CCInt) n2;
- (void)updateWRData:(CCInt) wrN;
- (void)updateCCIData:(CCInt) cciN;
- (void)updateBOLLData:(CCInt) bollN;

@end

@interface CCSGroupChart : UIView<UIScrollViewDelegate>

/*******************************************************************************
 * initialize
 *******************************************************************************/

- (void)initialize;

/*******************************************************************************
 * Public Properties
 *******************************************************************************/

/** K线图 */
@property(strong, nonatomic) CCSBOLLMASlipCandleStickChart *candleStickChart;
/** VOL 图 */
@property(strong, nonatomic) CCSMAColoredStickChart *stickChart;
/** MACD 图 */
@property(strong, nonatomic) CCSMACDChart *macdChart;
/** KDJ 图 */
@property(strong, nonatomic) CCSSlipLineChart *kdjChart;
/** RSI 图 */
@property(strong, nonatomic) CCSSlipLineChart *rsiChart;
/** WR 图 */
@property(strong, nonatomic) CCSSlipLineChart *wrChart;
/** CCI 图 */
@property(strong, nonatomic) CCSSlipLineChart *cciChart;
/** BOLL 图 */
@property(strong, nonatomic) CCSSlipLineChart *bollChart;
/** 图表类型切换 UISegmentedControl */
@property(strong, nonatomic) UISegmentedControl *segBottomChartType;
/** 底部图表容器 */
@property(strong, nonatomic) UIScrollView *scrollViewBottomChart;

/** 当前显示的图表类型 */
@property(assign, nonatomic) GroupChartViewType bottomChartType;

/** 图表数据源,还未计算 */
@property(strong, nonatomic) NSMutableArray *chartData;
/** 图表数据源,已经计算好 */
@property(strong, nonatomic) CCSGroupChartData *groupChartData;

@property(weak, nonatomic) UIViewController<CCSChartDelegate> *chartDelegate;

/** 图表是否全屏 */
@property(assign, nonatomic) GroupChartOrientationType orientationType;

/** 设置 */
@property (nonatomic, copy) void (^setting)();

/** 长按 */
@property (nonatomic, copy) void (^longPress)(NSString *date, CCFloat open, CCFloat high, CCFloat low, CCFloat close, CCFloat percent, BOOL isRise, CCFloat vol);

/*******************************************************************************
 * Public Methods
 *******************************************************************************/

/**
 * 图表 ontouch 事件
 */
- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index;
- (void)CCSChartBeLongPressDown:(id)chart;
- (void)CCSChartBeLongPressUp:(id)chart;
/**
 *
 */
- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number;

/**
 * 设置背景色
 */
- (void)setChartsBackgroundColor:(UIColor *)backgroundColor;

/**
 * 设置按钮颜色
 */
- (void)setButtonTextColor: (UIColor *)normalColor selectedColor: (UIColor *)selectedColor;

/**
 * 更新某个图表,直接对数据源进行重新计算
 */
- (void)updateCandleStickChart;
- (void)updateStickChart;
- (void)updateMACDChart;
- (void)updateKDJChart;
- (void)updateRSIChart;
- (void)updateWRChart;
- (void)updateCCIChart;
- (void)updateBOLLChart;

/**
 * 刷新图表,直接对数据源进行修改
 */
- (void)refreshGroupChart;

@end
