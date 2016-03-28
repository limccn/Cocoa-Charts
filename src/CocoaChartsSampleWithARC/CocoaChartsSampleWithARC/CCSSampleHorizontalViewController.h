//
//  CCSSampleHorizontalViewController.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/3/27.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSSimpleDemoViewController.h"

@interface CCSSampleHorizontalViewController : UIViewController<UIScrollViewDelegate, CCSChartDelegate>{
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
    
    CCSCandleStickStyle _topChartType;
    ChartViewType _bottomChartType;
    NSMutableArray *_chartData;
    OHLCVDData *_oHLCVDData;

}

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
@property(strong, nonatomic) UISegmentedControl *segChartType;
@property(strong, nonatomic) UISegmentedControl *segBottomChartType;
@property(strong, nonatomic) UIScrollView *scrollViewBottomChart;

@property(assign, nonatomic) CCSCandleStickStyle topChartType;
@property(assign, nonatomic) ChartViewType bottomChartType;
@property(strong, nonatomic) NSMutableArray *chartData;
@property(strong, nonatomic) OHLCVDData *oHLCVDData;

@end
