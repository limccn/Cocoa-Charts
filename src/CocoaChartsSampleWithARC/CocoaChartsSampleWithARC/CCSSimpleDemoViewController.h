//
//  CCSSimpleDemoViewController.h
//  CocoaChartsSample
//
//  Created by limc on 12/26/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSColoredStickChart.h"
#import "CCSMACDChart.h"
#import "CCSSlipLineChart.h"
#import "CCSBOLLMASlipCandleStickChart.h"

typedef enum {
    CandleStickChartTypeCandle = 101,
    CandleStickChartTypeBar = 102,
    CandleStickChartTypeLine = 103
} CandleStickChartType;

typedef enum {
    ChartViewTypeVOL  = 101,
    ChartViewTypeMACD = 102,
    ChartViewTypeKDJ  = 103,
    ChartViewTypeRSI  = 104,
    ChartViewTypeWR   = 105,
    ChartViewTypeCCI  = 106,
    ChartViewTypeBOLL = 107
} ChartViewType;

@interface OHLCVDData:NSObject{
    NSString *_open;
    NSString *_high;
    NSString *_low;
    NSString *_close;
    NSString *_vol;
    NSString *_date;
    NSString *_current;
    NSString *_change;
    NSString *_preclose;
    
}
@property(retain ,nonatomic) NSString *open;
@property(retain ,nonatomic) NSString *high;
@property(retain ,nonatomic) NSString *low;
@property(retain ,nonatomic) NSString *close;
@property(retain ,nonatomic) NSString *vol;
@property(retain ,nonatomic) NSString *date;
@property(retain ,nonatomic) NSString *current;
@property(retain ,nonatomic) NSString *change;
@property(retain ,nonatomic) NSString *preclose;

@end

@interface CCSSimpleDemoViewController : UIViewController<NSXMLParserDelegate,UIScrollViewDelegate,CCSChartDelegate> {
    UILabel *_lblTitle;
    UILabel *_lblOpen;
    UILabel *_lblHigh;
    UILabel *_lblLow;
    UILabel *_lblClose;
    UILabel *_lblVolume;
    UILabel *_lblDate;
    UILabel *_lblChange;
    UILabel *_lblPreClose;
    UILabel *_lblSubTitle1;
    UILabel *_lblSubTitle2;
    UILabel *_lblSubTitle3;
    UILabel *_lblSubTitle4;
    UILabel *_lblSubTitle5;
    UILabel *_lblSubTitle6;
    UILabel *_lblSubTitle7;
    UILabel *_lblSubTitle8;
    UILabel *_lblSubTitle9;
    UILabel *_lblSubTitle10;
    CCSColoredStickChart *_stickChart;
    CCSBOLLMASlipCandleStickChart *_candleStickChart;
    CCSMACDChart *_macdChart;
    CCSSlipLineChart *_kdjChart;
    CCSSlipLineChart *_rsiChart;
    CCSSlipLineChart *_wrChart;
    CCSSlipLineChart *_cciChart;
    CCSSlipLineChart *_bollChart;
    UISegmentedControl *_segChartType;
    UISegmentedControl *_segBottomChartType;
    UIScrollView *_scrollViewBottomChart;
    
    CandleStickChartType _topChartType;
    ChartViewType _bottomChartType;
    NSMutableArray *_chartData;
    OHLCVDData *_oHLCVDData;
}

@property(retain, nonatomic) UILabel *lblTitle;
@property(retain, nonatomic) UILabel *lblOpen;
@property(retain, nonatomic) UILabel *lblHigh;
@property(retain, nonatomic) UILabel *lblLow;
@property(retain, nonatomic) UILabel *lblClose;
@property(retain, nonatomic) UILabel *lblVolume;
@property(retain, nonatomic) UILabel *lblDate;
@property(retain, nonatomic) UILabel *lblChange;
@property(retain, nonatomic) UILabel *lblPreClose;
@property(retain, nonatomic) UILabel *lblSubTitle1;
@property(retain, nonatomic) UILabel *lblSubTitle2;
@property(retain, nonatomic) UILabel *lblSubTitle3;
@property(retain, nonatomic) UILabel *lblSubTitle4;
@property(retain, nonatomic) UILabel *lblSubTitle5;
@property(retain, nonatomic) UILabel *lblSubTitle6;
@property(retain, nonatomic) UILabel *lblSubTitle7;
@property(retain, nonatomic) UILabel *lblSubTitle8;
@property(retain, nonatomic) UILabel *lblSubTitle9;
@property(retain, nonatomic) UILabel *lblSubTitle10;
@property(retain, nonatomic) CCSColoredStickChart *stickChart;
@property(retain, nonatomic) CCSBOLLMASlipCandleStickChart *candleStickChart;
@property(retain, nonatomic) CCSMACDChart *macdChart;
@property(retain, nonatomic) CCSSlipLineChart *kdjChart;
@property(retain, nonatomic) CCSSlipLineChart *rsiChart;
@property(retain, nonatomic) CCSSlipLineChart *wrChart;
@property(retain, nonatomic) CCSSlipLineChart *cciChart;
@property(retain, nonatomic) CCSSlipLineChart *bollChart;
@property(retain, nonatomic) UISegmentedControl *segChartType;
@property(retain, nonatomic) UISegmentedControl *segBottomChartType;
@property(retain, nonatomic) UIScrollView *scrollViewBottomChart;

@property(assign, nonatomic) CandleStickChartType topChartType;
@property(assign, nonatomic) ChartViewType bottomChartType;
@property(retain, nonatomic) NSMutableArray *chartData;
@property(retain, nonatomic) OHLCVDData *oHLCVDData;



@end
