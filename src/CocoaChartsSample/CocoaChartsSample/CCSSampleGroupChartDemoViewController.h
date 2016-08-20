//
//  CCSSampleGroupChartDemoViewController.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSSettingDetailViewController.h"

#import "CCSGroupChart.h"

@interface CCSSampleGroupChartDemoViewController : UIViewController<CCSChartDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl      *segTopChartType;
@property (weak, nonatomic) IBOutlet CCSGroupChart           *groupChart;
@property (weak, nonatomic) IBOutlet CCSSlipAreaChart        *areachart;

@property (weak, nonatomic) IBOutlet UILabel                 *lblTime;

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
