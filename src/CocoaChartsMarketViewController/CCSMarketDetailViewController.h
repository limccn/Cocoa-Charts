//
//  CCSMarketDetailViewController.h
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

#import "CCSSettingDetailViewController.h"

#import "CCSGroupChart.h"

@interface CCSMarketDetailViewController : UIViewController<CCSChartDelegate, UITableViewDataSource, UITableViewDelegate>

/** 商品信息 */
@property (weak, nonatomic) IBOutlet UIView                  *vProductContainer;
@property (weak, nonatomic) IBOutlet UILabel                 *lblCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblChangePrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblChangePercent;
@property (weak, nonatomic) IBOutlet UILabel                 *lblBuyPrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblSellPrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblHighPrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblLowPrice;
@property (weak, nonatomic) IBOutlet UILabel                 *lblTime;

/** 显示功能切换 */
@property (weak, nonatomic) IBOutlet UISegmentedControl      *segTopChartType;
/** K线图 */
@property (weak, nonatomic) IBOutlet CCSGroupChart           *groupChart;
/** 全屏按钮 */
@property (weak, nonatomic) IBOutlet UIButton                *btnHorizontal;
/** 分钟弹出框三角 */
@property (weak, nonatomic) IBOutlet UIView                  *vPopTriangle;
/** 分钟弹出框容器  */
@property (weak, nonatomic) IBOutlet UIView                  *vMinsContainer;
/** 分钟按钮容器 */
@property (weak, nonatomic) IBOutlet UIView                  *vKMinsContainer;

/** 分钟数据切换按钮 */
@property (weak, nonatomic) IBOutlet UIButton                *btn1Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn5Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn15Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn30Mins;
@property (weak, nonatomic) IBOutlet UIButton                *btn1Hours;
@property (weak, nonatomic) IBOutlet UIButton                *btn2Hours;
@property (weak, nonatomic) IBOutlet UIButton                *btn4Hours;

/** 下单按扭 */
@property (weak, nonatomic) IBOutlet UIButton                *btnTrade;
/** 定立买按扭 */
@property (weak, nonatomic) IBOutlet UIButton                *btnPromptlyBuy;
/** 定立卖按扭 */
@property (weak, nonatomic) IBOutlet UIButton                *btnPromptlySell;
/** 调期买按扭 */
@property (weak, nonatomic) IBOutlet UIButton                *btnAdjustmentBuy;
/** 调期卖按扭 */
@property (weak, nonatomic) IBOutlet UIButton                *btnAdjustmentSell;

/** 分钟按钮,分钟tab不包含在 UISegmentedControl 内 */
@property (weak, nonatomic) IBOutlet UIButton                *btnMinutes;

/**
 * 选择分钟
 */
- (IBAction)minutesTouchUpInside:(id)sender;

/**
 * 选择分钟 k线图
 */
- (IBAction)selectMinutesKChartTouchUpInside:(id)sender;

/**
 * 下单
 */
- (IBAction)tradeTouchUpInside:(id)sender;

/** 盘口 */
@property (strong, nonatomic) UIView                           *vHandicap;
/** 卖价 */
@property (strong, nonatomic) UILabel                          *lblHandicapSellPrice;
/** 卖量 */
@property (strong, nonatomic) UILabel                          *lblHandicapSellCount;
/** 买价 */
@property (strong, nonatomic) UILabel                          *lblHandicapBuyPrice;
/** 买量 */
@property (strong, nonatomic) UILabel                          *lblHandicapBuyCount;
/** 最新 */
@property (strong, nonatomic) UILabel                          *lblHandicapCurrentPrice;
/** 涨跌 */
@property (strong, nonatomic) UILabel                          *lblHandicapChangePrice;
/** 最高 */
@property (strong, nonatomic) UILabel                          *lblHandicapHighPrice;
/** 最低 */
@property (strong, nonatomic) UILabel                          *lblHandicapLowPrice;
/** 开盘 */
@property (strong, nonatomic) UILabel                          *lblHandicapOpenPrice;
/** 总量 */
@property (strong, nonatomic) UILabel                          *lblHandicapOpenSumCount;
/** 昨收 */
@property (strong, nonatomic) UILabel                          *lblHandicapClosePrice;
/** 总额 */
@property (strong, nonatomic) UILabel                          *lblHandicapCloseSumCount;
/** 昨结 */
@property (strong, nonatomic) UILabel                          *lblYesterdayClosePrice;
/** 持货 */
@property (strong, nonatomic) UILabel                          *lblYesterdayCloseSumCount;

/** 主题 */
@property (assign, nonatomic) ThemeModeType                   themeMode;
@property (assign, nonatomic) DisplayType                     displayType;

@property (assign, nonatomic) NSUInteger                      scale;

/** 商品数据 */
@property (strong, nonatomic) CCSProductData                 *productData;
/** 盘口数据 */
@property (strong, nonatomic) CCSHandicapData                *handicapData;
/** 分时数据 */
@property (strong, nonatomic) NSArray                        *arrayTickData;
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

/** vma */
@property (assign, nonatomic) NSInteger                       vma1;
@property (assign, nonatomic) NSInteger                       vma2;
@property (assign, nonatomic) NSInteger                       vma3;

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

/**
 * 更新K线图,根据指标参数
 */
- (void)updateChartsWithIndicatorType:(IndicatorType) indicatorType;

/**
 * 初始化变量
 */
- (void)initValue;

/**
 * 初始化控件
 */
- (void)initView;

/**
 * 初始化盘口
 */
- (void)initHandicap;

/**
 * 全屏事件
 */
- (void)horizontal:(UIButton *) sender;

/**
 * 更新商品信息中的当前时间
 */
- (void)updateTime;

/**
 * UISegmentedControl 监听事件
 */
- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl;

@end
