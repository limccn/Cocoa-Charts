//
//  CCSSampleGroupChartDemoViewController.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSSettingDetailViewController.h"

#import "CCSGroupChart.h"

@interface CCSSampleGroupChartDemoViewController : UIViewController<CCSChartDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl      *segTopChartType;
@property (weak, nonatomic) IBOutlet CCSGroupChart           *groupChart;
@property (weak, nonatomic) IBOutlet UIButton                *btnHorizontal;
@property (weak, nonatomic) IBOutlet UIView                  *vPopTriangle;
@property (weak, nonatomic) IBOutlet UIView                  *vMinsContainer;
@property (weak, nonatomic) IBOutlet UIView                  *vKMinsContainer;
@property (weak, nonatomic) IBOutlet UIButton                *btn1Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn5Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn15Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn30Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn1Hours;
@property (weak, nonatomic) IBOutlet UIButton                *btn2Hours;
@property (weak, nonatomic) IBOutlet UIButton                *btn4Hours;

@property (weak, nonatomic) IBOutlet UILabel                 *lblTime;

@property (weak, nonatomic) IBOutlet UIButton                *btnMinutes;

/**
 * 选择分钟
 */
- (IBAction)minutesTouchUpInside:(id)sender;

/**
 * 选择分钟 k线图
 */
- (IBAction)selectMinutesKChartTouchUpInside:(id)sender;

/** 盘口数据 */
@property (strong, nonatomic) NSArray                        *arrayHandicapData;
/** 分时数据 */
@property (strong, nonatomic) NSArray                        *arrayTickData;
/** 明细数据 */
@property (strong, nonatomic) NSArray                        *arrayDetailData;
/** 日数据 */
@property (strong, nonatomic) CCSGroupChartData              *chartDayData;
/** 周数据 */
@property (strong, nonatomic) CCSGroupChartData              *chartWeekData;
/** 月数据 */
@property (strong, nonatomic) CCSGroupChartData              *chartMonthData;
/** 1分钟数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart1MinData;
/** 5分钟数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart5MinData;
/** 15分钟数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart15MinData;
/** 30分钟数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart30MinData;
/** 1小时数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart1HourData;
/** 2小时数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart2HourData;
/** 4小时数据 */
@property (strong, nonatomic) CCSGroupChartData              *chart4HourData;

/** macd */
@property (assign, nonatomic) NSInteger                       macdS;
@property (assign, nonatomic) NSInteger                       macdL;
@property (assign, nonatomic) NSInteger                       macdM;

/** ma */
@property (assign, nonatomic) NSInteger                       ma1;
@property (assign, nonatomic) NSInteger                       ma2;
@property (assign, nonatomic) NSInteger                       ma3;

/** kdj */
@property (assign, nonatomic) NSInteger                       kdjN;

/** rsi */
@property (assign, nonatomic) NSInteger                       rsiN1;
@property (assign, nonatomic) NSInteger                       rsiN2;

/** wr */
@property (assign, nonatomic) NSInteger                       wrN;

/** cci */
@property (assign, nonatomic) NSInteger                       cciN;

/** boll */
@property (assign, nonatomic) NSInteger                       bollN;

- (void)updateChartsWithIndicatorType:(IndicatorType) indicatorType;

@end
