//
//  CCSGroupChart.h
//  CocoaChartsSample
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

@interface OHLCVDGroupData : NSObject

@property(strong, nonatomic) NSString *open;
@property(strong, nonatomic) NSString *high;
@property(strong, nonatomic) NSString *low;
@property(strong, nonatomic) NSString *close;
@property(strong, nonatomic) NSString *vol;
@property(strong, nonatomic) NSString *date;
@property(strong, nonatomic) NSString *current;
@property(strong, nonatomic) NSString *change;
@property(strong, nonatomic) NSString *preclose;

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
@property(strong, nonatomic) NSMutableArray *chartData;
@property(strong, nonatomic) OHLCVDGroupData *oHLCVDData;

@property(weak, nonatomic) UIViewController<CCSChartDelegate> *chartDelegate;

/*******************************************************************************
 * Public Methods
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index;
- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number;

@end
