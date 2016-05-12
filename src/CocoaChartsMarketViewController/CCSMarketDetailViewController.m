//
//  CCSMarketDetailViewController.m
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

#import "CCSMarketDetailViewController.h"

#import "AppDelegate.h"

#import "CCSMarketDetailHorizontalViewController.h"
#import "CCSChartsSettingViewController.h"
#import "OrderTableViewController.h"

#import "CCSMarketDetailTableViewCell.h"

#import "CocoaChartsHeader.h"

#define AXIS_CALC_PARM  1000

#import "CCSTickChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

/** 协议号 */
#define API_KLINE_PI                                @"10118"
#define API_TICK_PI                                 @"10121"
#define API_DAYS_PI                                 @"10123"
#define API_HANDICAP_PI                             @"10114"
#define API_DETAIL_PI                               @"10119"

/** 自动刷新的时间间隔 */
#define REFRESH_TIME                                30.0
/** 分时图与上下5档比例 */
#define MIN_CHART_LEFT_RIGHT_SCALE                  2.8f

/** self.View 的CGSize */
#define VIEW_SIZE                                   self.view.bounds.size

/** 计时线程的 IDENTIFIER */
#define AUTO_REFRESH_TIMER_IDENTIFIER               @"AUTO_REFRESH_TIMER_IDENTIFIER"
#define LOAD_MORE_TIMER_IDENTIFIER                  @"LOAD_MORE_TIMER_IDENTIFIER"

/** 各主题下颜色 */
#define PRODUCT_BACKGROUND_DAY                      [@"#F44D4D" str2Color]
#define PRODUCT_BACKGROUND_NIGHT                    [@"#1D2330" str2Color]

#define CHART_BACKGROUND_DAY                        [@"#F5F5F5" str2Color]
#define CHART_BACKGROUND_NIGHT                      [@"#16181E" str2Color]

#define BUTTON_NORMAL_TEXT_COLOR_DAY                [@"#88909C" str2Color]
#define BUTTON_NORMAL_TEXT_COLOR_NIGHT              [@"#6F7177" str2Color]

#define BUTTON_SELECTED_TEXT_COLOR_DAY              [@"#323232" str2Color]
#define BUTTON_SELECTED_TEXT_COLOR_NIGHT            [UIColor whiteColor]

/** 精选 Cell */
static NSString *DetailCellIdentifier             = @"CCSMarketDetailTableViewCell";

@interface CCSMarketDetailViewController (){
    /** 当前显示的K线图类型 */
    ChartDataType                                    _displayChartDataType;
    
    /** 当前是否正在刷新 */
    BOOL                                             _isRefreshing;
    /** 当前是否正在加载更多 */
    BOOL                                             _isLoadingMore;
    /** 当前请求的数量 */
    NSUInteger                                       _requestingCount;
    
    /** 分时图相关 */
    UIView                                          *_vMinsChartContainer;
    CCSTickChart                                    *_tickChart;
    CCSTitledLine                                   *_tickLine;
    NSMutableArray                                  *_arrUISellingTimes;
    NSMutableArray                                  *_arrUISellingPrices;
    NSMutableArray                                  *_arrUISellingCounts;
    NSMutableArray                                  *_arrUIBuyingTimes;
    NSMutableArray                                  *_arrUIBuyingPrices;
    NSMutableArray                                  *_arrUIBuyingCounts;
    
    /** 交易节数据 */
    NSMutableArray<CCSTimeData *>                   *_arrTickTimesData;
    /** 买卖数据 */
    NSArray<CCSTickData *>                          *_tickBuySellData;
    
    /** 2日对比图相关 */
    CCSTickChart                                    *_2Dayschart;
    NSMutableArray                                  *_2DaysLinesData;
    NSMutableArray                                  *_lbl2DaysDates;
    NSMutableArray                                  *_2DaysDates;
    
    /** 3日对比图相关 */
    CCSTickChart                                    *_3Dayschart;
    NSMutableArray                                  *_3DaysLinesData;
    NSMutableArray                                  *_lbl3DaysDates;
    NSMutableArray                                  *_3DaysDates;
    
    /** 明细 */
    UIView                                          *_vDetail;
    UITableView                                     *_tbDetail;
    NSArray                                         *_detailData;
    
    /** 明细 */
    UIView                                          *_vSelectTab;
    CGFloat                                          _selectViewWidth;
    
    /** 存储计时相关 */
    NSMutableDictionary                             *_dicTimers;
}

/**
 * 初始化分时图
 */
- (void)initTickChart;

/**
 * 初始化2日对比图
 */
- (void)init2DaysChart;

/**
 * 初始化3日对比图
 */
- (void)init3DaysChart;

/**
 * 初始化明细
 */
- (void)initDetail;

/**
 * 初始化分钟选择
 */
- (void)initKMins;

/**
 * 首次进入画面时加载数据
 */
- (void)loadData;

/**
 * 设置自动刷新
 */
- (void)setAutoRefresh;

/**
 * 根据当前显示的内容刷新数据
 */
- (void)refreshData;

/**
 * 加载K线数据
 */
- (void)loadkLineData: (ChartDataType) chartDataType;

/**
 * 对请求到的K线数据进行处理(放大,缩小显示)
 */
- (void)kLineDataPreProcess:(NSMutableArray *) ohlcDatas;

/**
 * 更新K线图
 */
- (void)updateKLineChart:(ChartDataType) dataType ohlcDatas:(NSMutableArray *) ohlcDatas;

/**
 * 加载分时数据
 */
- (void)loadTickData;

/**
 * 更新交易节
 */
- (void)updateTickTradeNode:(NSString *) strResponse;

/**
 * 获得交易节时间段
 */
- (CCSTimeData *)formatStratEndTime:(NSString *) strTime;

/**
 * 更新分时图X轴
 */
- (void)tickLineDataUpdate:(NSArray *) times chart:(CCSTickChart *) chart;

/**
 * 同步最新分时数据到分时图
 */
- (void)tickLineProcess:(NSArray *)arrData line:(CCSTitledLine *) line;

/**
 * 加载多日数据
 */
- (void)loadTickDaysData:(NSInteger) days;

/**
 * 加载盘口数据
 */
- (void)loadHandicapData;

/**
 * 加载明细数据
 */
- (void)loadDetailData;

/**
 * 发送请求
 */
- (void)doRequest:(NSString *)pi parameters:(NSMutableDictionary *) parameters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

/**
 * 根据K线数据类型获得K线数据请求参数
 */
- (NSString *)findKLineType:(ChartDataType) dataType;

/**
 * 根据K线数据类型获得当前显示的K线数据
 */
- (CCSGroupChartData *)findDisplayGroupChartData:(ChartDataType) dataType;

@end

@implementation CCSMarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initValue];
    
    [self initView];
    [self setRightItem];
    // 延迟操作执行的代码
    [self loadData];
}
-(void)setRightItem{
    
    
    
    UIBarButtonItem* itemBtn = [[UIBarButtonItem alloc] initWithTitle:@"下单"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self action:@selector(onTakeOrder:)];
    
    
    self.navigationItem.rightBarButtonItem = itemBtn;
}
-(void) onTakeOrder:(id)sender
{
    UIStoryboard * stroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    OrderTableViewController * vc
    = [stroryBoard instantiateViewControllerWithIdentifier:@"OrderTableViewController"];
    
    
    vc.title = self.navigationItem.title;
    
    
    
    [self.navigationController pushViewController:vc animated:true];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[self.tabBarController tabBar] setHidden:YES];
    
    // 自动刷新
//    [self setAutoRefresh];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self cancelDisPatchTimerWithName:AUTO_REFRESH_TIMER_IDENTIFIER];
}

- (void)viewDidLayoutSubviews{
    // 当前显示功能 TAG View
    if (!_vSelectTab) {
        _selectViewWidth = self.groupChart.orientationType == GroupChartHorizontalType?[self.groupChart bounds].size.width/15.0f:[self.groupChart bounds].size.width/9.0f;
        _vSelectTab = [[UIView alloc] init];
        CGFloat left = self.displayType == DisplayHandicapType?0:self.displayType == DisplayTickType?1:self.displayType == Display2DaysType?2:self.displayType == Display2DaysType?3:self.displayType == DisplayDetailType?4:self.displayType == DisplayDayKLineType?5:self.displayType == DisplayWeekKLineType?6:self.displayType == DisplayMonthKLineType?7:8;
        [_vSelectTab setFrame:CGRectMake(_selectViewWidth*left, self.segTopChartType.frame.origin.y+self.segTopChartType.frame.size.height - 5.0f, _selectViewWidth, 1.0f)];
        [_vSelectTab setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:_vSelectTab];
    }
    
    // 初始化分时图
    [self initTickChart];
    // 初始化两日对比图
    [self init2DaysChart];
    // 初始化3日对比图
    [self init3DaysChart];
    // 初始化盘口
    [self initHandicap];
    // 初始化明细
    [self initDetail];
    // 初始化分钟图选择按钮及弹窗
    [self initKMins];
    // 更新商品信息
    [self updateProduct];
    // 更新盘口
    [self updateHandicap:self.handicapData];
    // 更新买卖信息
    [self updateTick:_tickBuySellData];
    // 更新明细
    [_tbDetail reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)minutesTouchUpInside:(id)sender{
    // 根据主题设置分钟按钮的颜色
    [self.btnMinutes setTitleColor: self.themeMode == ThemeDayMode? BUTTON_SELECTED_TEXT_COLOR_DAY:BUTTON_SELECTED_TEXT_COLOR_NIGHT forState:UIControlStateNormal];
    // segTopChartType 隐藏选中效果
    [self.segTopChartType setSelectedSegmentIndex:8];
    // 显示分钟图弹窗
    [self showKMinsMenu];
    // 移动显示功能 TAG View 到分钟按钮下
    [UIView animateWithDuration:0.2f animations:^{
        [_vSelectTab setFrame:CGRectMake(_selectViewWidth*8.0f, _vSelectTab.frame.origin.y, _selectViewWidth, _vSelectTab.frame.size.height)];
    }];
}

- (IBAction)selectMinutesKChartTouchUpInside:(id)sender{
    // 设置当前显示功能为 K线图
    self.displayType = DisplayDayKLineType;
    
    // 隐藏非k线图功能,显示K线图
    UIView *view = sender;
    [self.vHandicap setHidden:YES];
    [_vMinsChartContainer setHidden:YES];
    [_2Dayschart setHidden:YES];
    [_3Dayschart setHidden:YES];
    [_vDetail setHidden:YES];
    [self.groupChart setHidden:NO];
    
    // 加载数据
    [self showKLineChartsWithMinutes:view.tag];
    [self showKMinsMenu];
}

- (IBAction)tradeTouchUpInside:(id)sender{
    [self onTakeOrder:sender];
}

- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    // 设置分钟按钮未选中
    [self.btnMinutes setTitleColor:ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY:BUTTON_NORMAL_TEXT_COLOR_NIGHT forState:UIControlStateNormal];
    // 暂停自动刷新
    [self cancelDisPatchTimerWithName:AUTO_REFRESH_TIMER_IDENTIFIER];
    // 滑动选中功能 View
    [UIView animateWithDuration:0.2f animations:^{
        [_vSelectTab setFrame:CGRectMake(_selectViewWidth*segmentedControl.selectedSegmentIndex, _vSelectTab.frame.origin.y, _selectViewWidth, _vSelectTab.frame.size.height)];
    }];
    
    // 根据 segmentedControl 选中切换显示的功能
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.displayType = DisplayHandicapType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:NO];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        [self loadHandicapData];
    }else if (segmentedControl.selectedSegmentIndex == 1) {
        self.displayType = DisplayTickType;
        
        [_vMinsChartContainer setHidden:NO];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        [self loadTickData];
    }else if (segmentedControl.selectedSegmentIndex == 2) {
        self.displayType = Display2DaysType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:NO];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        [self loadTickDaysData:2];
    }else if (segmentedControl.selectedSegmentIndex == 3) {
        self.displayType = Display3DaysType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:NO];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        [self loadTickDaysData:3];
    }else if (segmentedControl.selectedSegmentIndex == 4) {
        self.displayType = DisplayDetailType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:NO];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        [self loadDetailData];
    }else if (segmentedControl.selectedSegmentIndex == 5){
        self.displayType = DisplayDayKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chartDayData) {
            [self loadkLineData:ChartDayData];
        }else{
            [self.groupChart setGroupChartData:self.chartDayData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 6){
        self.displayType = DisplayWeekKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chartWeekData) {
            [self loadkLineData:ChartWeekData];
        }else{
            [self.groupChart setGroupChartData:self.chartWeekData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 7){
        self.displayType = DisplayMonthKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chartMonthData) {
            [self loadkLineData:ChartMonthData];
        }else{
            [self.groupChart setGroupChartData:self.chartMonthData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 8){
        self.displayType = Display1MinKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart1MinData) {
            [self loadkLineData:Chart1minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart1MinData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 9){
        self.displayType = Display5MinKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart5MinData) {
            [self loadkLineData:Chart5minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart5MinData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 10){
        self.displayType = Display15MinKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart15MinData) {
            [self loadkLineData:Chart15minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart15MinData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 11){
        self.displayType = Display30MinKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart30MinData) {
            [self loadkLineData:Chart30minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart30MinData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 12){
        self.displayType = Display1HourKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart1HourData) {
            [self loadkLineData:Chart1hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart1HourData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 13){
        self.displayType = Display2HourKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart2HourData) {
            [self loadkLineData:Chart2hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart2HourData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 14){
        self.displayType = Display4HourKLineType;
        
        [_vMinsChartContainer setHidden:YES];
        [self.vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_2Dayschart setHidden:YES];
        [_3Dayschart setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chart4HourData) {
            [self loadkLineData:Chart4hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart4HourData];
        }
    }else{
    }
}

- (void)initValue{
//    self.themeMode = ThemeNightMode;
    if (self.displayType == DisplayNoneType) {
        self.displayType = DisplayDayKLineType;
    }
    
    // 初始化分时和2日3日的 LineData
    _tickLine = [[CCSTitledLine alloc] init];
    _tickLine.data = @[[[CCSLineData alloc] initWithValue:0.0 date: @"00:00"]];
    _tickLine.color = LINE_COLORS[0];
    _tickLine.title = @"_tickLine";
    
    _2DaysLinesData = [[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {
        CCSTitledLine *titleLine = [[CCSTitledLine alloc] init];
        titleLine.data = @[[[CCSLineData alloc] initWithValue:0.0 date: @"00:00"]];
        titleLine.color = LINE_COLORS[i];
        titleLine.title = [NSString stringWithFormat:@"_2DaysLinesData: %d", i];
        
        [_2DaysLinesData addObject:titleLine];
    }
    
    _3DaysLinesData = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        CCSTitledLine *titleLine = [[CCSTitledLine alloc] init];
        titleLine.data = @[[[CCSLineData alloc] initWithValue:0.0 date: @"00:00"]];
        titleLine.color = LINE_COLORS[i];
        titleLine.title = [NSString stringWithFormat:@"_3DaysLinesData: %d", i];
        
        [_3DaysLinesData addObject:titleLine];
    }
    
    _2DaysDates = [NSMutableArray arrayWithArray:@[@"",@""]];
    _3DaysDates = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
}

- (void)initView{
    // 根据主题设置背景色
    [self.view setBackgroundColor: self.themeMode == ThemeDayMode? CONTENT_BACKGROUND_DAY:CONTENT_BACKGROUND_NIGHT];
    [self.vProductContainer setBackgroundColor:self.themeMode == ThemeDayMode? PRODUCT_BACKGROUND_DAY:PRODUCT_BACKGROUND_NIGHT];
    // 设置 segmentedControl 监听事件
    [self.segTopChartType addTarget:self action:@selector(segTopChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    // 根据 displayType 选中 segmentedControl
    [self.segTopChartType setSelectedSegmentIndex:self.displayType == DisplayHandicapType?0:self.displayType == DisplayTickType?1:self.displayType == Display2DaysType?2:self.displayType == Display2DaysType?3:self.displayType == DisplayDetailType?4:self.displayType == DisplayDayKLineType?5:self.displayType == DisplayWeekKLineType?6:self.displayType == DisplayMonthKLineType?7:8];
    // 根据 displayType 判断是否显示K线图
    if (self.displayType == DisplayHandicapType || self.displayType == DisplayTickType || self.displayType == Display2DaysType || self.displayType == Display3DaysType || self.displayType == DisplayDetailType) {
        [self.groupChart setHidden:YES];
    }else{
        [self.groupChart setHidden:NO];
    }
    
    // 设置颜色
    self.segTopChartType.tintColor = self.themeMode == ThemeDayMode? CONTENT_BACKGROUND_DAY:CONTENT_BACKGROUND_NIGHT;
    [self.segTopChartType setBackgroundColor:self.themeMode == ThemeDayMode? CONTENT_BACKGROUND_DAY:CONTENT_BACKGROUND_NIGHT];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],
                                             NSForegroundColorAttributeName: self.themeMode == ThemeDayMode? BUTTON_SELECTED_TEXT_COLOR_DAY:BUTTON_SELECTED_TEXT_COLOR_NIGHT};
    // 设置文字属性
    [self.segTopChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],
                                               NSForegroundColorAttributeName: self.themeMode == ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY:BUTTON_NORMAL_TEXT_COLOR_NIGHT};
    [self.segTopChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    // 根据主题设置分钟按钮颜色
    [self.btnMinutes setTitleColor:self.themeMode == ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY:BUTTON_NORMAL_TEXT_COLOR_NIGHT forState:UIControlStateNormal];
    
    // 根据主题设置下单按钮颜色
    [self.btnTrade setTitleColor:self.themeMode == ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY:BUTTON_NORMAL_TEXT_COLOR_NIGHT forState:UIControlStateNormal];
    
    [_groupChart setChartDelegate:self];
    [_groupChart setChartsBackgroundColor: self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY: CHART_BACKGROUND_NIGHT];
    [_groupChart setButtonTextColor:self.themeMode == ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY: BUTTON_NORMAL_TEXT_COLOR_NIGHT selectedColor:self.themeMode == ThemeDayMode? BUTTON_SELECTED_TEXT_COLOR_DAY: BUTTON_SELECTED_TEXT_COLOR_NIGHT];
    // 设置按钮监听事件
    [_groupChart setSetting:^{
        CCSChartsSettingViewController *ctrlSetting = [[CCSChartsSettingViewController alloc] init];
        ctrlSetting.ctrlChart = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctrlSetting];
        [self presentViewController:navigationController animated:YES completion:^{
        }];
    }];
    // 全屏按钮监听事件
    [self.btnHorizontal addTarget:self action:@selector(horizontal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnHorizontal setTitleColor:self.themeMode == ThemeDayMode? BUTTON_NORMAL_TEXT_COLOR_DAY:BUTTON_NORMAL_TEXT_COLOR_NIGHT forState:UIControlStateNormal];
    [self.btnHorizontal setTitle:@"" forState:UIControlStateNormal];
    [self.btnHorizontal setImage:[UIImage imageNamed:@"full_screen"] forState:UIControlStateNormal];
    // 更新当前时间
    [self updateTime];
    // 设置分钟弹出框圆角
    [self.vMinsContainer.layer setCornerRadius:5.0f];
    
    [self.btnPromptlyBuy setTitleColor:LINE_COLORS[0] forState:UIControlStateNormal];
    self.btnPromptlyBuy.layer.borderColor = ((UIColor *)LINE_COLORS[0]).CGColor;
    self.btnPromptlyBuy.layer.borderWidth = 0.8f;
    self.btnPromptlyBuy.layer.cornerRadius = 3;
    
    [self.btnPromptlySell setTitleColor:LINE_COLORS[1] forState:UIControlStateNormal];
    self.btnPromptlySell.layer.borderColor = ((UIColor *)LINE_COLORS[1]).CGColor;
    self.btnPromptlySell.layer.borderWidth = 0.8f;
    self.btnPromptlySell.layer.cornerRadius = 3;
    
    [self.btnAdjustmentBuy setTitleColor:LINE_COLORS[0] forState:UIControlStateNormal];
    self.btnAdjustmentBuy.layer.borderColor = ((UIColor *)LINE_COLORS[0]).CGColor;
    self.btnAdjustmentBuy.layer.borderWidth = 0.8f;
    self.btnAdjustmentBuy.layer.cornerRadius = 3;
    
    [self.btnAdjustmentSell setTitleColor:LINE_COLORS[1] forState:UIControlStateNormal];
    self.btnAdjustmentSell.layer.borderColor = ((UIColor *)LINE_COLORS[1]).CGColor;
    self.btnAdjustmentSell.layer.borderWidth = 0.8f;
    self.btnAdjustmentSell.layer.cornerRadius = 3;
}

- (void)initTickChart{
    if (_vMinsChartContainer) {
        return;
    }
    _vMinsChartContainer = [[UIView alloc] init];
    [_vMinsChartContainer setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    
    if (self.displayType != DisplayTickType) {
        [_vMinsChartContainer setHidden:YES];
    }
    
    [self.view addSubview:_vMinsChartContainer];
    
    _tickChart = [[CCSTickChart alloc] init];
    [_tickChart setFrame:CGRectMake(0.0f, 0.0f, _vMinsChartContainer.frame.size.width - _vMinsChartContainer.frame.size.width/MIN_CHART_LEFT_RIGHT_SCALE, _vMinsChartContainer.frame.size.height)];
    
    _tickChart.lineWidth = 1.0f;
    _tickChart.maxValue = 150000;
    _tickChart.minValue = 100000;
    _tickChart.longitudeNum = 4;
    _tickChart.latitudeNum = 4;
    _tickChart.displayFrom = 0;
    _tickChart.maxDisplayNumber = 60*(5.5 + 6)+1;
    _tickChart.minDisplayNumber = 60*(5.5 + 6)+1;
    _tickChart.displayNumber = 60*(5.5 + 6)+1;
    _tickChart.longitudeSplitor = @[@"330",@"360"];
    _tickChart.autoCalcLongitudeTitle = NO;
    _tickChart.balanceRange = YES;
    _tickChart.lastClose = [self.handicapData.closePrice doubleValue];
//    _tickChart.axisCalc = AXIS_CALC_PARM
//    _tickChart.areaAlpha = 0.2;
    [_tickChart setBackgroundColor:self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY: CHART_BACKGROUND_NIGHT];
    
    [_vMinsChartContainer addSubview:_tickChart];
    
    NSMutableArray *linesdata = [[NSMutableArray alloc] init];
    
    [linesdata addObject:_tickLine];
    
    _tickChart.linesData = linesdata;
    
    NSMutableArray *titlesX = [NSMutableArray arrayWithArray:@[@"21:00", @"2:30/9:00", @"15:00"]];
    
    _tickChart.longitudeTitles = titlesX;
    
    [_tickChart setNeedsDisplay];
    
    UIView *vTrade = [[UIView alloc] init];
    [vTrade setFrame:CGRectMake(VIEW_SIZE.width - VIEW_SIZE.width/MIN_CHART_LEFT_RIGHT_SCALE, _tickChart.frame.origin.y, VIEW_SIZE.width/MIN_CHART_LEFT_RIGHT_SCALE, _tickChart.frame.size.height)];
    [_vMinsChartContainer addSubview:vTrade];
    
    CGFloat tradeHeight = 0.0f;
    
    _arrUISellingTimes = [[NSMutableArray alloc] init];
    _arrUISellingPrices = [[NSMutableArray alloc] init];
    _arrUISellingCounts = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIView *vSellingContainer = [[UIView alloc] init];
        [vSellingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, [self.groupChart frame].size.height/10.0f)];
        [vTrade addSubview:vSellingContainer];
        
        UILabel *lblSelling = [[UILabel alloc] init];
        [lblSelling setFrame:CGRectMake(0.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [lblSelling setTextAlignment:NSTextAlignmentCenter];
        [lblSelling setTextColor:LINE_COLORS[1]];
        [lblSelling setFont:[UIFont systemFontOfSize:11.0f]];
        [lblSelling setText:@"09:36"];
        [vSellingContainer addSubview:lblSelling];
        [_arrUISellingTimes addObject:lblSelling];
        
        UIButton *btnSelling = [[UIButton alloc] init];
        [btnSelling setFrame:CGRectMake(vSellingContainer.frame.size.width/3.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [btnSelling.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [btnSelling setTitleColor:LINE_COLORS[1] forState:UIControlStateNormal];
        [btnSelling setTitle:[NSString stringWithFormat:@"%d", 3030] forState:UIControlStateNormal];
        [vSellingContainer addSubview:btnSelling];
        [_arrUISellingPrices addObject:btnSelling];
        
        UILabel *lblSellingCount = [[UILabel alloc] init];
        [lblSellingCount setFrame:CGRectMake(vSellingContainer.frame.size.width/3.0f*2.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [lblSellingCount setTextAlignment:NSTextAlignmentCenter];
        [lblSellingCount setTextColor:LINE_COLORS[1]];
        [lblSellingCount setFont:[UIFont systemFontOfSize:11.0f]];
        [lblSellingCount setText:[NSString stringWithFormat:@"%d", 3]];
        [vSellingContainer addSubview:lblSellingCount];
        [_arrUISellingCounts addObject:lblSellingCount];
        
        tradeHeight += vSellingContainer.frame.size.height;
    }
    
    UIView *vCenterLine = [[UIView alloc] init];
    [vCenterLine setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 0.5f)];
    [vCenterLine setBackgroundColor:[UIColor lightGrayColor]];
    [vCenterLine setAlpha:0.3f];
    [vTrade addSubview:vCenterLine];
    
    _arrUIBuyingTimes = [[NSMutableArray alloc] init];
    _arrUIBuyingPrices = [[NSMutableArray alloc] init];
    _arrUIBuyingCounts = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIView *vBuyingContainer = [[UIView alloc] init];
        [vBuyingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, [self.groupChart frame].size.height/10.0f)];
        [vTrade addSubview:vBuyingContainer];
        
        UILabel *lblBuying = [[UILabel alloc] init];
        [lblBuying setFrame:CGRectMake(0.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [lblBuying setTextAlignment:NSTextAlignmentCenter];
        [lblBuying setTextColor:LINE_COLORS[0]];
        [lblBuying setFont:[UIFont systemFontOfSize:11.0f]];
        [lblBuying setText:@"09:36"];
        [vBuyingContainer addSubview:lblBuying];
        [_arrUIBuyingTimes addObject:lblBuying];
        
        UIButton *btnBuying = [[UIButton alloc] init];
        [btnBuying setFrame:CGRectMake(vBuyingContainer.frame.size.width/3.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [btnBuying.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [btnBuying setTitleColor:LINE_COLORS[0] forState:UIControlStateNormal];
        [btnBuying setTitle:[NSString stringWithFormat:@"%d", 3030] forState:UIControlStateNormal];
        [vBuyingContainer addSubview:btnBuying];
        [_arrUIBuyingPrices addObject:btnBuying];
        
        UILabel *lblBuyingCount = [[UILabel alloc] init];
        [lblBuyingCount setFrame:CGRectMake(vBuyingContainer.frame.size.width/3.0f*2.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [lblBuyingCount setTextAlignment:NSTextAlignmentCenter];
        [lblBuyingCount setTextColor:LINE_COLORS[0]];
        [lblBuyingCount setFont:[UIFont systemFontOfSize:11.0f]];
        [lblBuyingCount setText:[NSString stringWithFormat:@"%d", 3]];
        [vBuyingContainer addSubview:lblBuyingCount];
        [_arrUIBuyingCounts addObject:lblBuyingCount];
        
        tradeHeight += vBuyingContainer.frame.size.height;
    }
}

- (void)init2DaysChart{
    if (_2Dayschart) {
        return;
    }

    _2Dayschart = [[CCSTickChart alloc] init];
    [_2Dayschart setFrame:CGRectMake(self.groupChart.frame.origin.x, self.groupChart.frame.origin.y, self.groupChart.frame.size.width, self.groupChart.frame.size.height)];
    if (self.displayType != Display2DaysType) {
        [_2Dayschart setHidden:YES];
    }
    
    _2Dayschart.lineWidth = 1.0f;
    _2Dayschart.maxValue = 150000;
    _2Dayschart.minValue = 100000;
    _2Dayschart.longitudeNum = 4;
    _2Dayschart.latitudeNum = 4;
    _2Dayschart.maxDisplayNumber = 1;
    _2Dayschart.minDisplayNumber = 1;
    _2Dayschart.displayNumber = 1;
    _2Dayschart.longitudeSplitor = @[@"1"];
    _2Dayschart.autoCalcLongitudeTitle = NO;
    _2Dayschart.balanceRange = YES;
    _2Dayschart.lastClose = [self.handicapData.closePrice doubleValue];
    //    _tickChart.axisCalc = AXIS_CALC_PARM
    //    _tickChart.areaAlpha = 0.2;
    [_2Dayschart setBackgroundColor:self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY: CHART_BACKGROUND_NIGHT];
    
    [self.view addSubview:_2Dayschart];
    
    _2Dayschart.linesData = _2DaysLinesData;
    
    NSMutableArray *titlesX = [NSMutableArray arrayWithArray:@[@"00:00"]];
    
    _2Dayschart.longitudeTitles = titlesX;
    
    _lbl2DaysDates = [[NSMutableArray alloc] init];
    UILabel *lblDateTime = [[UILabel alloc] init];
    [lblDateTime setFrame:CGRectMake(_2Dayschart.frame.size.width - 80.0f, 11.0f, 80.0f, 20.0f)];
    [lblDateTime setText:_2DaysDates[0]];
    [lblDateTime setFont:[UIFont systemFontOfSize:12.0f]];
    [lblDateTime setTextColor:LINE_COLORS[0]];
    [_2Dayschart addSubview:lblDateTime];
    [_lbl2DaysDates addObject:lblDateTime];
    
    UILabel *lblDateTime1 = [[UILabel alloc] init];
    [lblDateTime1 setFrame:CGRectMake(lblDateTime.frame.origin.x, lblDateTime.frame.origin.y + lblDateTime.frame.size.height, lblDateTime.frame.size.width, lblDateTime.frame.size.height)];
    [lblDateTime1 setText:_2DaysDates[1]];
    [lblDateTime1 setFont:[UIFont systemFontOfSize:12.0f]];
    [lblDateTime1 setTextColor:LINE_COLORS[1]];
    [_2Dayschart addSubview:lblDateTime1];
    [_lbl2DaysDates addObject:lblDateTime1];
}

- (void)init3DaysChart{
    if (_3Dayschart) {
        return;
    }
    
    _3Dayschart = [[CCSTickChart alloc] init];
    [_3Dayschart setFrame:CGRectMake(self.groupChart.frame.origin.x, self.groupChart.frame.origin.y, self.groupChart.frame.size.width, self.groupChart.frame.size.height)];
    
    if (self.displayType != Display3DaysType) {
        [_3Dayschart setHidden:YES];
    }
    
    _3Dayschart.lineWidth = 1.0f;
    _3Dayschart.maxValue = 150000;
    _3Dayschart.minValue = 100000;
    _3Dayschart.longitudeNum = 4;
    _3Dayschart.latitudeNum = 4;
    _3Dayschart.maxDisplayNumber = 1;
    _3Dayschart.minDisplayNumber = 1;
    _3Dayschart.displayNumber = 1;
    _3Dayschart.longitudeSplitor = @[@"1"];
    _3Dayschart.autoCalcLongitudeTitle = NO;
    _3Dayschart.balanceRange = YES;
    _3Dayschart.lastClose = [self.handicapData.closePrice doubleValue];
    //    _tickChart.axisCalc = AXIS_CALC_PARM
    //    _tickChart.areaAlpha = 0.2;
    [_3Dayschart setBackgroundColor:self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY: CHART_BACKGROUND_NIGHT];
    
    [self.view addSubview:_3Dayschart];
    _3Dayschart.linesData = _3DaysLinesData;
    
    NSMutableArray *titlesX = [NSMutableArray arrayWithArray:@[@"00:00"]];
    _3Dayschart.longitudeTitles = titlesX;
    
    _lbl3DaysDates = [[NSMutableArray alloc] init];
    UILabel *lblDateTime = [[UILabel alloc] init];
    [lblDateTime setFrame:CGRectMake(_2Dayschart.frame.size.width - 80.0f, 11.0f, 80.0f, 20.0f)];
    [lblDateTime setText:_3DaysDates[0]];
    [lblDateTime setFont:[UIFont systemFontOfSize:12.0f]];
    [lblDateTime setTextColor:LINE_COLORS[0]];
    [_3Dayschart addSubview:lblDateTime];
    [_lbl3DaysDates addObject:lblDateTime];
    
    UILabel *lblDateTime1 = [[UILabel alloc] init];
    [lblDateTime1 setFrame:CGRectMake(lblDateTime.frame.origin.x, lblDateTime.frame.origin.y + lblDateTime.frame.size.height, lblDateTime.frame.size.width, lblDateTime.frame.size.height)];
    [lblDateTime1 setText:_3DaysDates[1]];
    [lblDateTime1 setFont:[UIFont systemFontOfSize:12.0f]];
    [lblDateTime1 setTextColor:LINE_COLORS[1]];
    [_3Dayschart addSubview:lblDateTime1];
    [_lbl3DaysDates addObject:lblDateTime1];
    
    UILabel *lblDateTime2 = [[UILabel alloc] init];
    [lblDateTime2 setFrame:CGRectMake(lblDateTime.frame.origin.x, lblDateTime1.frame.origin.y + lblDateTime.frame.size.height, lblDateTime.frame.size.width, lblDateTime.frame.size.height)];
    [lblDateTime2 setText:_3DaysDates[2]];
    [lblDateTime2 setFont:[UIFont systemFontOfSize:12.0f]];
    [lblDateTime2 setTextColor:LINE_COLORS[2]];
    [_3Dayschart addSubview:lblDateTime2];
    [_lbl3DaysDates addObject:lblDateTime2];
}

- (void)initHandicap{
    if (self.vHandicap) {
        return;
    }
    self.vHandicap = [[UIView alloc] init];
    [self.vHandicap setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    [self.vHandicap setBackgroundColor:self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY: CHART_BACKGROUND_NIGHT];
    [self.vHandicap setHidden:YES];
    [self.view addSubview:self.vHandicap];
    
    CGFloat handicapHeight = 11.0f;
    
    NSMutableArray *arrhandicapsLeftValue = [[NSMutableArray alloc] init];
    NSMutableArray *arrhandicapsRightValue = [[NSMutableArray alloc] init];
    
    CGFloat marginLeft = 25.0f;
//    CGFloat marginRight = 30.0f;
    
    for (int i=0; i<7; i++) {
        UIView *vHandicapContainer = [[UIView alloc] init];
        [vHandicapContainer setFrame:CGRectMake(0.0f, handicapHeight, self.vHandicap.frame.size.width, 38.0f)];
        [self.vHandicap addSubview:vHandicapContainer];
        
        UILabel *lblLeftLabel = [[UILabel alloc] init];
        [lblLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 35.0f, vHandicapContainer.frame.size.height)];
        [lblLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [vHandicapContainer addSubview:lblLeftLabel];
        
        UILabel *lblLeftValue = [[UILabel alloc] init];
        [lblLeftValue setFrame:CGRectMake(marginLeft + lblLeftLabel.frame.size.width, 0.0f, 120.0f, vHandicapContainer.frame.size.height)];
        [lblLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftValue setFont:[UIFont systemFontOfSize:13.0f]];
        [vHandicapContainer addSubview:lblLeftValue];
        
        [arrhandicapsLeftValue addObject:lblLeftValue];
        
        UILabel *lblRightLabel = [[UILabel alloc] init];
        [lblRightLabel setFrame:CGRectMake(vHandicapContainer.frame.size.width + marginLeft - lblLeftLabel.frame.size.width - lblLeftValue.frame.size.width, 0.0f, lblLeftLabel.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [vHandicapContainer addSubview:lblRightLabel];
        
        UILabel *lblRightValue = [[UILabel alloc] init];
        [lblRightValue setFrame:CGRectMake(lblRightLabel.frame.size.width + lblRightLabel.frame.origin.x, 0.0f, lblLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightValue setTextColor:[UIColor lightGrayColor]];
        [lblRightValue setFont:[UIFont systemFontOfSize:13.0f]];
        [vHandicapContainer addSubview:lblRightValue];
        
        [arrhandicapsRightValue addObject:lblRightValue];
        
        switch (i) {
            case 0:
                [lblLeftLabel setText:@"卖价:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"卖量:"];
                [lblRightValue setText:@"2"];
                
                self.lblHandicapSellPrice = lblLeftValue;
                self.lblHandicapSellCount = lblRightValue;
                break;
            case 1:
                [lblLeftLabel setText:@"买价:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"买量:"];
                [lblRightValue setText:@"1"];
                
                self.lblHandicapBuyPrice = lblLeftValue;
                self.lblHandicapBuyCount = lblRightValue;
                break;
            case 2:
                [lblLeftLabel setText:@"最新:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"涨跌:"];
                [lblRightValue setText:@"11"];
                
                self.lblHandicapCurrentPrice = lblLeftValue;
                self.lblHandicapChangePrice = lblRightValue;
                break;
            case 3:
                [lblLeftLabel setText:@"最高:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"最低:"];
                [lblRightValue setText:@"3559"];
                
                self.lblHandicapHighPrice = lblLeftValue;
                self.lblHandicapLowPrice = lblRightValue;
                break;
            case 4:
                [lblLeftLabel setText:@"开盘:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"总量:"];
                [lblRightValue setText:@"3559"];
                
                self.lblHandicapOpenPrice = lblLeftValue;
                self.lblHandicapOpenSumCount = lblRightValue;
                break;
            case 5:
                [lblLeftLabel setText:@"昨收:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"总额:"];
                [lblRightValue setText:@"3559"];
                
                self.lblHandicapClosePrice = lblLeftValue;
                self.lblHandicapCloseSumCount = lblRightValue;
                break;
            case 6:
                [lblLeftLabel setText:@"昨结:"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"持货:"];
                [lblRightValue setText:@"3559"];
                
                self.lblYesterdayClosePrice = lblLeftValue;
                self.lblYesterdayCloseSumCount = lblRightValue;
                break;
            default:
                break;
        }
        
        handicapHeight += vHandicapContainer.frame.size.height;
    }
}

- (void)initDetail{
    if (_vDetail) {
        return;
    }
    
    _vDetail = [[UIView alloc] init];
    [_vDetail setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    [_vDetail setBackgroundColor:self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY:CHART_BACKGROUND_NIGHT];
    
    if (self.displayType != DisplayDetailType) {
        [_vDetail setHidden:YES];
    }
    
    [self.view addSubview:_vDetail];
    
    UILabel *lblTime = [[UILabel alloc] init];
    [lblTime setFrame:CGRectMake(0.0f, 0.0f, _vDetail.frame.size.width/3.0f, 44.0f)];
    [lblTime setTextAlignment:NSTextAlignmentCenter];
    [lblTime setTextColor:[UIColor lightGrayColor]];
    [lblTime setFont:[UIFont systemFontOfSize:14.0f]];
    [lblTime setText:@"时间"];
    [_vDetail addSubview: lblTime];
    
    UILabel *lblPrice = [[UILabel alloc] init];
    [lblPrice setFrame:CGRectMake(_vDetail.frame.size.width/3.0f, 0.0f, _vDetail.frame.size.width/3.0f, 44.0f)];
    [lblPrice setTextAlignment:NSTextAlignmentCenter];
    [lblPrice setTextColor:[UIColor lightGrayColor]];
    [lblPrice setFont:[UIFont systemFontOfSize:14.0f]];
    [lblPrice setText:@"价格"];
    [_vDetail addSubview: lblPrice];
    
    UILabel *lblCount = [[UILabel alloc] init];
    [lblCount setFrame:CGRectMake(_vDetail.frame.size.width/3.0f*2.0f, 0.0f, _vDetail.frame.size.width/3.0f, 44.0f)];
    [lblCount setTextAlignment:NSTextAlignmentCenter];
    [lblCount setTextColor:[UIColor lightGrayColor]];
    [lblCount setFont:[UIFont systemFontOfSize:14.0f]];
    [lblCount setText:@"现量"];
    [_vDetail addSubview: lblCount];
    
    _tbDetail = [[UITableView alloc] init];
    [_tbDetail setFrame:CGRectMake([self.groupChart frame].origin.x, [lblTime frame].size.height, [self.groupChart frame].size.width, [self.groupChart frame].size.height - 44.0f)];
    _tbDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    // scrollbar 不显示
    _tbDetail.showsVerticalScrollIndicator = NO;
    _tbDetail.bounces = NO;
    _tbDetail.backgroundColor = self.themeMode == ThemeDayMode? CHART_BACKGROUND_DAY:CHART_BACKGROUND_NIGHT;
    
    // horizontalセルのdelegate等を設定
    _tbDetail.delegate = self;
    _tbDetail.dataSource = self;
    
    // 注册 METOEmptyTableViewCell
    UINib *nibDetail = [UINib nibWithNibName:DetailCellIdentifier bundle:nil];
    [_tbDetail registerNib:nibDetail forCellReuseIdentifier:DetailCellIdentifier];
    
    [_vDetail addSubview: _tbDetail];
}

- (void)initKMins{
    self.vPopTriangle.layer.cornerRadius = 3.0f;
    self.vKMinsContainer.layer.cornerRadius = 3.0f;
    
    // 移到画面最前方
    [self.vMinsContainer.superview bringSubviewToFront:self.vMinsContainer];
    
    // 旋转45度
    [self.vPopTriangle setTransform:CGAffineTransformMakeRotation(45 *M_PI / 180.0)];
    NSArray *arrayKMins = @[self.btn1Mins,self.btn5Mins,self.btn15Mins,self.btn30Mins,self.btn1Hours,self.btn2Hours];
    for (UIButton *btnKMin in arrayKMins) {
        BOOL haveLine = NO;
        for (UIView *vSubView in btnKMin.subviews) {
            if (vSubView.tag == 1000) {
                haveLine = YES;
                break;
            }
        }
        
        if (haveLine) {
            continue;
        }
        
        UIView *vLine = [[UIView alloc] init];
        [vLine setFrame:CGRectMake(0.0f, btnKMin.frame.size.height, btnKMin.frame.size.width, 0.5f)];
        [vLine setTag:1000];
        [vLine setBackgroundColor:[UIColor lightGrayColor]];
        [btnKMin addSubview:vLine];
    }
}

- (void)loadData{
    [self loadHandicapData];
    [self loadDetailData];
    switch (self.displayType) {
        case DisplayTickType:
            [self loadTickData];
            break;
        case Display2DaysType:
            [self loadTickDaysData:2];
            break;
        case Display3DaysType:
            [self loadTickDaysData:3];
            break;
        case DisplayDayKLineType:
            [self loadkLineData:ChartDayData];
            break;
        case DisplayWeekKLineType:
            [self loadkLineData:ChartWeekData];
            break;
        case DisplayMonthKLineType:
            [self loadkLineData:ChartMonthData];
            break;
        case Display1MinKLineType:
            [self loadkLineData:Chart1minuteData];
            break;
        case Display5MinKLineType:
            [self loadkLineData:Chart5minuteData];
            break;
        case Display15MinKLineType:
            [self loadkLineData:Chart15minuteData];
            break;
        case Display30MinKLineType:
            [self loadkLineData:Chart30minuteData];
            break;
        case Display1HourKLineType:
            [self loadkLineData:Chart1hourData];
            break;
        case Display2HourKLineType:
            [self loadkLineData:Chart2hourData];
            break;
        case Display4HourKLineType:
            [self loadkLineData:Chart4hourData];
            break;
        default:
            break;
    }
}

- (void)setAutoRefresh{
    [self scheduledDisPatchTimerWithName:AUTO_REFRESH_TIMER_IDENTIFIER timerInterval:REFRESH_TIME queue:nil repeats:YES action:^{
        if (_requestingCount > 0) {
            return;
        }
        
        NSLog(@"...refresh...");
        _isRefreshing = YES;
        
        DO_IN_MAIN_QUEUE(^{
            [self updateTime];
            [self refreshData];
        });
    }];
}

- (void)refreshData{
    [self loadHandicapData];
    switch (self.displayType) {
        case DisplayTickType:
            [self loadTickData];
            break;
        case Display2DaysType:
            [self loadTickDaysData:2];
            break;
        case Display3DaysType:
            [self loadTickDaysData:3];
            break;
        case DisplayDetailType:
            [self loadDetailData];
            break;
        case Display1MinKLineType:
            [self loadkLineData:Chart1minuteData];
            break;
        case Display5MinKLineType:
            [self loadkLineData:Chart5minuteData];
            break;
        case Display15MinKLineType:
            [self loadkLineData:Chart15minuteData];
            break;
        case Display30MinKLineType:
            [self loadkLineData:Chart30minuteData];
            break;
        case Display1HourKLineType:
            [self loadkLineData:Chart1hourData];
            break;
        case Display2HourKLineType:
            [self loadkLineData:Chart2hourData];
            break;
        case Display4HourKLineType:
            [self loadkLineData:Chart4hourData];
            break;
        default:
            break;
    }
}

- (void)loadkLineData: (ChartDataType) chartDataType{
    _displayChartDataType = chartDataType;
    
    NSString *strKLineType = [self findKLineType:chartDataType];
    
    CCSGroupChartData *displayGroupChartData = [self findDisplayGroupChartData:_displayChartDataType];
    
    NSString *strStartTime;
    if (displayGroupChartData && _isRefreshing) {
        CCSOHLCVDData *ohlcv = displayGroupChartData.ohlcvdDatas[0];
        strStartTime = [[ohlcv date] dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyy-MM-dd HH:mm:ss"];
    }else if (displayGroupChartData && !_isRefreshing) {
        if (![displayGroupChartData canLoadMore]) {
            _isRefreshing = NO;
            _requestingCount--;
            _isLoadingMore = NO;
            return;
        }
        CCSOHLCVDData *ohlcv = displayGroupChartData.ohlcvdDatas[[displayGroupChartData.ohlcvdDatas count] - 1];
        strStartTime = [[ohlcv date] dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        strStartTime = [TYTool getCurrentTime];
    }
    NSLog(@"strStartTime: %@", strStartTime);
    
    NSMutableDictionary *dicParameters =  [NSMutableDictionary dictionary];
    [dicParameters setValue:self.productData.producID forKey:@"id"];
    [dicParameters setValue:strStartTime forKey:@"b"];
    [dicParameters setValue:@"N" forKey:@"d"];//方向P正向N负向
    [dicParameters setValue:strKLineType forKey:@"kt"];
    [dicParameters setValue:@100 forKey:@"c"];//根数，多少条数据
    
    [self doRequest:API_KLINE_PI parameters:[NSMutableDictionary dictionaryWithDictionary:@{@"kqn":@[dicParameters]}] success:^(id responsData) {
        NSArray *arrayResponse = [responsData split:@";"];
        
        NSMutableArray *arrayKLineDatas = [[NSMutableArray alloc] init];
        NSMutableArray<CCSOHLCVDData *> *ohlcDatas = [[NSMutableArray alloc] init];
        for (id  _Nonnull obj in arrayResponse) {
            NSArray *arrayKLineData = [obj split:@"|"];
            CCSKLineData *kLineData = [[CCSKLineData alloc] init];
            CCSOHLCVDData *ohlcvdData = [[CCSOHLCVDData alloc] init];
            [arrayKLineData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                switch (index) {
                    case 0:
                        // 商品ID
                        break;
                    case 1:
                        // K线类型
                        break;
                    case 2:
                        // 行情时间
                        [kLineData setDate: obj];
                        ohlcvdData.date = [kLineData date];
                        break;
                    case 3:
                        // 开盘价
                        [kLineData setOpenPrice:obj];
                        ohlcvdData.open = [[kLineData openPrice] doubleValue];
                        break;
                    case 4:
                        // 最高价
                        [kLineData setHighPrice:obj];
                        ohlcvdData.high = [[kLineData highPrice] doubleValue];
                        break;
                    case 5:
                        // 最低价
                        [kLineData setLowPrice:obj];
                        ohlcvdData.low = [[kLineData lowPrice] doubleValue];
                        break;
                    case 6:
                        // 收盘价
                        [kLineData setClosePrice:obj];
                        ohlcvdData.close = [[kLineData closePrice] doubleValue];
                        ohlcvdData.current = [[kLineData closePrice] doubleValue];
                        break;
                    case 7:
                        // 现量
                        [kLineData setTradeCount:obj];
                        ohlcvdData.vol = [[kLineData tradeCount] doubleValue];
                        break;
                    case 8:
                        // 成交量
                        break;
                    case 10:
                        // 成交额
                        [kLineData setEndFlag:IIF([obj isEqualToString:@"true"], YES, NO)];
                        ohlcvdData.endFlag = [kLineData endFlag];
                        break;
                    case 11:
                        // 持仓量
                        break;
                    default:
                        break;
                }
            }];
            
            if ([kLineData date] && [kLineData openPrice] && [kLineData highPrice] && [kLineData lowPrice]&& [kLineData lowPrice] && [kLineData tradeCount]) {
                ohlcvdData.change = [[kLineData changePercent] doubleValue];
                
                [arrayKLineDatas addObject:kLineData];
                [ohlcDatas addObject:ohlcvdData];
            }
        }
        if (ohlcDatas && [ohlcDatas count] > 0) {
            NSLog(@"kline count: %lu", (unsigned long)[ohlcDatas count]);
            [self kLineDataPreProcess:ohlcDatas];
            ohlcDatas = [NSMutableArray arrayWithArray: [[ohlcDatas reverseObjectEnumerator] allObjects]];
            DO_IN_MAIN_QUEUE(^{
                [self updateKLineChart:chartDataType ohlcDatas:ohlcDatas];
            });
        }else{
            _isRefreshing = NO;
            NSLog(@"kline request unusual");
        }
        
        _isLoadingMore = NO;
    } failed:^(NSError *error) {
    }];
}

- (void)kLineDataPreProcess:(NSMutableArray *) ohlcDatas{
    for (CCSOHLCVDData *data in ohlcDatas) {
        data.open = data.open * AXIS_CALC_PARM;
        data.high = data.high * AXIS_CALC_PARM;
        data.low = data.low * AXIS_CALC_PARM;
        data.close = data.close * AXIS_CALC_PARM;
        //        data.open = [NSString stringWithFormat:@"%f",[data.open doubleValue] * AXIS_CALC_PARM];
        //        data.high = [NSString stringWithFormat:@"%f",[data.high doubleValue] * AXIS_CALC_PARM];
        //        data.low = [NSString stringWithFormat:@"%f",[data.low doubleValue] * AXIS_CALC_PARM];
        //        data.close = [NSString stringWithFormat:@"%f",[data.close doubleValue] * AXIS_CALC_PARM];
    }
}

- (void)updateKLineChart:(ChartDataType) dataType ohlcDatas:(NSMutableArray *) ohlcDatas{
    if (dataType == ChartDayData) {
        [self setDayData:ohlcDatas];
    }else if (dataType == ChartWeekData){
        [self setWeekData:ohlcDatas];
    }else if (dataType == ChartMonthData){
        [self setMonthData:ohlcDatas];
    }else if (dataType == Chart1minuteData){
        [self set1minData:ohlcDatas];
    }else if (dataType == Chart5minuteData){
        [self set5minData:ohlcDatas];
    }else if (dataType == Chart15minuteData){
        [self set15minData:ohlcDatas];
    }else if (dataType == Chart30minuteData){
        [self set30minData:ohlcDatas];
    }else if (dataType == Chart1hourData){
        [self set1HourData:ohlcDatas];
    }else if (dataType == Chart2hourData){
        [self set2HourData:ohlcDatas];
    }else if (dataType == Chart4hourData){
        [self set4HourData:ohlcDatas];
    }else{
    }
}

- (void)loadTickData{
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionary];
    
    [dicParameters setValue:@[self.productData.producID] forKey:@"id"];
    
    [self doRequest:API_TICK_PI parameters:dicParameters success:^(id responsData) {
        
        [self updateTickTradeNode:responsData];
        
        BOOL isCrossDays = [_arrTickTimesData[0] startTime] > [_arrTickTimesData[0] endTime];
        BOOL isSettlement = NO;
        
        NSArray *arrayResponse = [responsData split:@";"];
        NSMutableArray *arrayTickDatas = [[NSMutableArray alloc] init];
        [arrayResponse enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
            NSArray *arrayTickData = [obj split:@"|"];
            CCSTickData *tickData = [[CCSTickData alloc] init];
            __block BOOL isToday = NO;
            __block BOOL isValidTime = NO;
            [arrayTickData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                switch (index) {
                    case 0:
                        // 商品ID
                        break;
                    case 1:
                        
                        break;
                    case 2:
                    {
                        // 行情时间
                        [tickData setTime: [obj dateWithFormat:@"yyyyMMddHHmmss" target:@"HH:mm"]];
                        
                        NSString *date = [obj dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyyMMdd"];
                        NSString *today = [[TYTool getCurrentTime] dateWithFormat:@"yyyy-MM-dd HH:mm:ss" target:@"yyyyMMdd"];
                        if ([today isEqualToString:date] || isCrossDays) {
                            isToday = YES;
                        }else{
                            isToday = NO;
                        }
                        isValidTime = [self isValidTime:obj];
                        
                        break;
                    }
                    case 3:
                        // 开盘价
                        break;
                    case 4:
                        // 最高价
                        break;
                    case 5:
                        // 最低价
                        break;
                    case 6:
                        // 收盘价
                        [tickData setPrice:obj];
                        break;
                    case 7:
                        // 现量
                        [tickData setCount:obj];
                        break;
                    case 8:
                        // 成交量
                        break;
                    case 10:
                        // 成交额
                        break;
                    case 11:
                        // 持仓量 @ 合约ID
                        break;
                    case 12:
                        // 交易开始时间
                        break;
                    case 13:
                        // 交易结束时间
                        break;
                    default:
                        break;
                }
            }];
            
            if (tickData.time && tickData.price && tickData.count && isToday && !isSettlement && isValidTime) {
                [arrayTickDatas addObject:tickData];
            }
        }];
        
        [self tickLineProcess:arrayTickDatas line:_tickLine];
        [_tickChart setNeedsDisplay];
    } failed:^(NSError *error) {
    }];
}

- (void)updateTickTradeNode:(NSString *) strResponse{
    if (_arrTickTimesData) {
        return;
    }
    _arrTickTimesData = [[NSMutableArray alloc] init];
    NSArray *responseTimes = [strResponse split:@"@"];
    
    if ([responseTimes count] == 2){
        NSArray *arrTimes = [responseTimes[1] split:@";"];
        for (NSString *strTime in arrTimes) {
            if (!strTime || [strTime isEqualToString:@""]) {
                continue;
            }
            [_arrTickTimesData addObject:[self formatStratEndTime:strTime]];
        }
    }else if ([responseTimes count] == 3){
        NSArray *arrTimes = [responseTimes[2] split:@"|"];
        for (NSString *strTime in arrTimes) {
            if (!strTime || [strTime isEqualToString:@""]) {
                continue;
            }
            [_arrTickTimesData addObject:[self formatStratEndTime:strTime]];
        }
    }
    
    [self tickLineDataUpdate:_arrTickTimesData chart:_tickChart];
    [self tickLineDataUpdate:_arrTickTimesData chart:_2Dayschart];
    [self tickLineDataUpdate:_arrTickTimesData chart:_3Dayschart];
}

- (CCSTimeData *)formatStratEndTime:(NSString *) strTime{
    CCSTimeData *timeData = [[CCSTimeData alloc] init];
    
    NSArray<NSString *> *arrayTimes = [strTime split:@"|"];
    
    CGFloat startHour;
    CGFloat startMin;
    
    startHour = [[arrayTimes[1] dateWithFormat:@"HH:mm:ss" target:@"HH"] floatValue];
    startMin = [[arrayTimes[1] dateWithFormat:@"HH:mm:ss" target:@"mm"] floatValue];
    [timeData setStartTime:startHour + startMin/60.0f];
    [timeData setStrStartTime:[arrayTimes[1] dateWithFormat:@"HH:mm:ss" target:@"HH:mm"]];
    
    startHour = [[arrayTimes[2] dateWithFormat:@"HH:mm:ss" target:@"HH"] floatValue];
    startMin = [[arrayTimes[2] dateWithFormat:@"HH:mm:ss" target:@"mm"] floatValue];
    [timeData setEndTime:startHour + startMin/60.0f];
    [timeData setStrEndTime:[arrayTimes[2] dateWithFormat:@"HH:mm:ss" target:@"HH:mm"]];
    
    NSInteger minute = 0;
    if (timeData.startTime > timeData.endTime) {
        minute = (24.0f - timeData.endTime)*60 + timeData.startTime * 60;
    }else{
        minute = (timeData.endTime - timeData.startTime)*60;
    }
    [timeData setMinute:minute];
    
    return timeData;
}

- (BOOL)isValidTime:(NSString *)time{
//    CGFloat hour = [[time dateWithFormat:@"yyyyMMddHHmmss" target:@"HH"] floatValue];
//    CGFloat minute = [[time dateWithFormat:@"yyyyMMddHHmmss" target:@"mm"] floatValue];
//    
//    BOOL isValid = NO;
//    for (CCSTimeData *timeData in _arrTickTimesData) {
//        
//    }
//    
    return YES;
}

- (void)tickLineDataUpdate:(NSArray *) times chart:(CCSTickChart *) chart{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"00"];
    
    NSMutableArray *arrMinsLineData = [[NSMutableArray alloc] init];
    NSMutableArray *arrMinsLineData1 = [[NSMutableArray alloc] init];
    NSMutableArray *arrMinsLineData2 = [[NSMutableArray alloc] init];
    
    NSMutableArray *longitudeSplitor = [[NSMutableArray alloc] init];
    
    NSMutableArray *titlesX = [[NSMutableArray alloc] init];
    [times enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
        CCSTimeData *timeData = obj;
        // 前一天
        if (timeData.endTime < timeData.startTime) {
            for (int i=timeData.startTime*60; i<=60*24; i++) {
                int hour = i/60;
                int min = i - hour*60;
                
                NSString *time = [NSString stringWithFormat:@"%@:%@", [numberFormatter stringFromNumber:[NSNumber numberWithInt:hour]], [numberFormatter stringFromNumber:[NSNumber numberWithInt:min]]];
                
                [arrMinsLineData addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData1 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData2 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
            }
            for (int i=0*60; i<=60*timeData.endTime + 1; i++) {
                int hour = i/60;
                int min = i - hour*60;
                
                NSString *time = [NSString stringWithFormat:@"%@:%@", [numberFormatter stringFromNumber:[NSNumber numberWithInt:hour]], [numberFormatter stringFromNumber:[NSNumber numberWithInt:min]]];
                
                [arrMinsLineData addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData1 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData2 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
            }
        }else{
            for (int i=timeData.startTime*60; i<=60*timeData.endTime+1; i++) {
                int hour = i/60;
                int min = i - hour*60;
                
                NSString *time = [NSString stringWithFormat:@"%@:%@", [numberFormatter stringFromNumber:[NSNumber numberWithInt:hour]], [numberFormatter stringFromNumber:[NSNumber numberWithInt:min]]];
                
                [arrMinsLineData addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData1 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
                [arrMinsLineData2 addObject:[[CCSLineData alloc] initWithValue:0.0 date: time]];
            }
        }
        
        [longitudeSplitor addObject: [NSString stringWithFormat:@"%ld", (long)timeData.minute + 1]];
        if (index == 0) {
            [titlesX addObject:timeData.strStartTime];
        }else if(index == [times count]-1){
            [titlesX addObject:[NSString stringWithFormat:@"%@/%@", ((CCSTimeData *)times[[times count] - 2]).strEndTime, timeData.strStartTime]];
            [titlesX addObject:timeData.strEndTime];
        }else{
            [titlesX addObject:[NSString stringWithFormat:@"%@/%@", ((CCSTimeData *)times[index - 1]).strEndTime, ((CCSTimeData *)times[index]).strStartTime]];
        }
    }];
    
    NSArray *lineDatas = @[arrMinsLineData, arrMinsLineData1, arrMinsLineData2];
    [chart.linesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
        CCSTitledLine *line = obj;
        line.data = lineDatas[index];
    }];
    
    chart.displayFrom = 0;
    chart.maxDisplayNumber = [arrMinsLineData count];
    chart.minDisplayNumber = [arrMinsLineData count];
    chart.displayNumber = [arrMinsLineData count];

    chart.longitudeSplitor = longitudeSplitor;
    
    if ([times count] == 1) {
        [titlesX removeAllObjects];
        
        [titlesX addObject:((CCSTimeData *)times[0]).strStartTime];
        [titlesX addObject:((CCSTimeData *)times[0]).strEndTime];
    }else if ([times count] == 2){
        [titlesX removeAllObjects];
        
        [titlesX addObject:((CCSTimeData *)times[0]).strStartTime];
        [titlesX addObject:[NSString stringWithFormat:@"%@/%@", ((CCSTimeData *)times[0]).strEndTime, ((CCSTimeData *)times[1]).strStartTime]];
        [titlesX addObject:((CCSTimeData *)times[1]).strEndTime];
    }else{
    }
    
    chart.longitudeTitles = titlesX;
}

- (void)tickLineProcess:(NSArray *)arrData line:(CCSTitledLine *) line{
    NSMutableDictionary *dicMinsData = [[NSMutableDictionary alloc] init];
    NSString *finalTime;
    if (arrData && [arrData count] > 0) {
        finalTime = ((CCSTickData *)arrData[arrData.count - 1]).time;
    }
    
    for (CCSTickData *tickData in arrData) {
        [dicMinsData setObject:tickData.price forKey:tickData.time];
    }
    CGFloat lastPrice = 0.0f;
    NSString *lastTime;
    for (CCSLineData *lineData in [line data]) {
        if (dicMinsData[[lineData date]]) {
            [lineData setValue:[dicMinsData[[lineData date]] doubleValue]];
            lastPrice = [lineData value];
            lastTime = [lineData date];
        }else{
            if (lastTime) {
                NSString *strLastTime = [lastTime copy];
                NSString *strFinalTime = [[lineData date] copy];
                NSInteger lastHour = [[strLastTime replaceAll:@":" target:@""] integerValue]/100;
                NSInteger lastMinute = [[strFinalTime replaceAll:@":" target:@""] integerValue]%100;
                
                NSInteger currentHour = [[strFinalTime replaceAll:@":" target:@""] integerValue]/100;
                NSInteger currentMinute = [[strFinalTime replaceAll:@":" target:@""] integerValue]%100;
                if ((lastHour == currentHour && currentMinute - lastMinute <= 1) || [lastTime isEqualToString: finalTime]) {
                    [lineData setValue: 0.0];
                }else{
                    [lineData setValue: lastPrice];
                }
            }else{
                [lineData setValue: lastPrice];
            }
        }
    }
}

- (void)loadTickDaysData:(NSInteger) days{
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionary];
    
    [dicParameters setValue:self.productData.producID forKey:@"id"];
    [dicParameters setValue: days == 2?@"1":@"2"forKey:@"fst"];
    
    [self doRequest:API_DAYS_PI parameters:dicParameters success:^(id responsData) {
        [self updateTickTradeNode:responsData];
        
        BOOL isCrossDays = [_arrTickTimesData[0] startTime] > [_arrTickTimesData[0] endTime];
        BOOL isSettlement = NO;
        
        NSArray *arrayResponse = [responsData split:@";"];
        
        NSMutableArray *array0DayDatas = [[NSMutableArray alloc] init];
        NSMutableArray *array1DayDatas = [[NSMutableArray alloc] init];
        NSMutableArray *array2DayDatas = [[NSMutableArray alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *today = [NSDate date];
        NSString *dateToday = [dateFormatter stringFromDate:today];
        
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:60*60*24*-1];
        NSString *dateYesterday = [dateFormatter stringFromDate:yesterday];
        
        NSDate *yesterdayBefore = [NSDate dateWithTimeIntervalSinceNow:60*60*24*2*-1];
        NSString *dateYesterdayBefore = [dateFormatter stringFromDate:yesterdayBefore];
        
        __block NSString *date;
        [arrayResponse enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
            NSArray *arrayTickData = [obj split:@"|"];
            CCSTickData *tickData = [[CCSTickData alloc] init];
            __block NSInteger dayFlag = 0;
            __block BOOL isToday = NO;
            [arrayTickData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                switch (index) {
                    case 0:
                        // 交易日标识
                        dayFlag = [obj integerValue];
                        break;
                    case 1:
                        
                        break;
                    case 2:
                    {
                        // 行情时间
                        [tickData setTime: [obj dateWithFormat:@"yyyyMMddHHmmss" target:@"HH:mm"]];
                        date = [obj dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyy-MM-dd"];
                        if (dayFlag == 0) {
                            if ([date isEqualToString:dateToday] || isCrossDays) {
                                isToday = YES;
                            }else{
                                isToday = NO;
                            }
                        }else if (dayFlag == 1){
                            if ([date isEqualToString:dateYesterday] || isCrossDays) {
                                isToday = YES;
                            }else{
                                isToday = NO;
                            }
                        }else if (dayFlag == 2){
                            if ([date isEqualToString:dateYesterdayBefore] || isCrossDays) {
                                isToday = YES;
                            }else{
                                isToday = NO;
                            }
                        }else{
                            isToday = YES;
                        }
                        break;
                    }
                    case 3:
                        // 开盘价
                        break;
                    case 4:
                        // 最高价
                        break;
                    case 5:
                        // 最低价
                        break;
                    case 6:
                        // 收盘价
                        [tickData setPrice:obj];
                        break;
                    case 7:
                        // 现量
                        break;
                    case 8:
                        // 成交量
                        [tickData setCount:obj];
                        break;
                    case 10:
                        // 成交额
                        break;
                    case 11:
                        // 持仓量 @ 合约ID
                        break;
                    case 12:
                        // 交易开始时间
                        break;
                    case 13:
                        // 交易结束时间
                        break;
                    default:
                        break;
                }
            }];
            
            // 是否当日数据check
            if (tickData.time && tickData.price && tickData.count && isToday && !isSettlement) {
                if (dayFlag == 0) {
                    [array0DayDatas addObject:tickData];
                }else if (dayFlag == 1){
                    [array1DayDatas addObject:tickData];
                }else if (dayFlag == 2){
                    [array2DayDatas addObject:tickData];
                }else{
                }
            }
            
            if (date && ![date isEqualToString:@""] && days == 2) {
                _2DaysDates[dayFlag] = date;
            }else if (date && ![date isEqualToString:@""] && days == 3){
                _3DaysDates[dayFlag] = date;
            }
        }];
        
        if (days == 2) {
            [self tickLineProcess:array0DayDatas line:_2DaysLinesData[0]];
            [self tickLineProcess:array1DayDatas line:_2DaysLinesData[1]];
            
            [_lbl2DaysDates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                UILabel *lblDdate = obj;
                [lblDdate setText:_2DaysDates[index]];
            }];
            [_2Dayschart setNeedsDisplay];
        }else if (days == 3){
            [self tickLineProcess:array0DayDatas line:_3DaysLinesData[0]];
            [self tickLineProcess:array1DayDatas line:_3DaysLinesData[1]];
            [self tickLineProcess:array2DayDatas line:_3DaysLinesData[2]];
            
            [_lbl3DaysDates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                UILabel *lblDdate = obj;
                [lblDdate setText:_3DaysDates[index]];
            }];
            [_3Dayschart setNeedsDisplay];
        }
    } failed:^(NSError *error) {
    }];
}

- (void)loadHandicapData{
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionary];
    
    [dicParameters setValue:@[self.productData.producID] forKey:@"id"];
    
    [self doRequest:API_HANDICAP_PI parameters:dicParameters success:^(id responsData) {
        NSArray *arrayResponse = [responsData split:@"|"];
        
        if (!_tickBuySellData) {
            _tickBuySellData = @[[[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init], [[CCSTickData alloc] init]];
        }
        
        [arrayResponse enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
            switch (index) {
                case 0:
                    // 商品ID
                    break;
                case 1:
                    // 昨结
                    self.handicapData.yesterdayClosePrice = obj;
                    break;
                case 2:
                    // 昨收
                    self.handicapData.closePrice = obj;
                    break;
                case 3:
                    // 开盘价
                    self.handicapData.openPrice = obj;
                    break;
                case 4:
                    // 高值
                    self.productData.highPrice = obj;
                    self.handicapData.highPrice = obj;
                    break;
                case 5:
                    // 低值
                    self.productData.lowPrice = obj;
                    self.handicapData.lowPrice = obj;
                    break;
                case 6:
                    // 当前价
                    self.productData.currentPrice = obj;
                    self.handicapData.currentPrice = obj;
                    break;
                case 7:
                    // 行情时间
                    break;
                case 8:
                    // 现量
                    break;
                case 9:
                    // 成交量
                    self.handicapData.openSumCount = obj;
                    break;
                case 10:
                    // 成交额
                    self.handicapData.closeSumCount = obj;
                    break;
                case 11:
                    // 持仓量
                    self.handicapData.yesterdayCloseSumCount = obj;
                    break;
                case 12:
                    // 报价类型
                    break;
                case 13:
                    // 买1价
                    self.handicapData.buyPrice = obj;
                    self.productData.buyPrice = obj;
                    _tickBuySellData[0].price = obj;
                    
                    break;
                case 14:
                    // 买1量
                    self.handicapData.buyCount = obj;
                    _tickBuySellData[0].count = obj;
                    break;
                case 15:
                    // 买2价
                    _tickBuySellData[1].price = obj;
                    break;
                case 16:
                    // 买2量
                    _tickBuySellData[1].count = obj;
                    break;
                case 17:
                    // 买3价
                    _tickBuySellData[2].price = obj;
                    break;
                case 18:
                    // 买3量
                    _tickBuySellData[2].count = obj;
                    break;
                case 19:
                    // 买4价
                    _tickBuySellData[3].price = obj;
                    break;
                case 20:
                    // 买4量
                    _tickBuySellData[3].count = obj;
                    break;
                case 21:
                    // 买5价
                    _tickBuySellData[4].price = obj;
                    break;
                case 22:
                    // 买5量
                    _tickBuySellData[4].count = obj;
                    break;
                case 23:
                    // 卖1价
                    self.handicapData.sellPrice = obj;
                    self.productData.sellPrice = obj;
                    _tickBuySellData[5].price = obj;
                    break;
                case 24:
                    // 卖1量
                    self.handicapData.sellCount = obj;
                    _tickBuySellData[5].count = obj;
                    break;
                case 25:
                    // 卖2价
                    _tickBuySellData[6].price = obj;
                    break;
                case 26:
                    // 卖2量
                    _tickBuySellData[6].count = obj;
                    break;
                case 27:
                    // 卖3价
                    _tickBuySellData[7].price = obj;
                    break;
                case 28:
                    // 卖3量
                    _tickBuySellData[7].count = obj;
                    break;
                case 29:
                    // 卖4价
                    _tickBuySellData[8].price = obj;
                    break;
                case 30:
                    // 卖4量
                    _tickBuySellData[8].count = obj;
                    break;
                case 31:
                    // 卖5价
                    _tickBuySellData[9].price = obj;
                    break;
                case 32:
                    // 卖5量
                    _tickBuySellData[9].count = obj;
                    break;
                default:
                    break;
                    
            }
        }];
        
        //涨跌值
        self.handicapData.changePrice = [NSString stringWithFormat:@"%f", [self.handicapData.currentPrice floatValue] - [self.handicapData.yesterdayClosePrice floatValue]];
        self.productData.changePrice = self.handicapData.changePrice;
        
        //涨跌百分比
        CGFloat changedata = [self.handicapData.highPrice floatValue]-[self.handicapData.lowPrice floatValue];
        
        self.productData.changePercent = [[[NSString stringWithFormat:@"%f", changedata/[self.handicapData.yesterdayClosePrice floatValue]] decimal:2] append:@"%"];
        
        [self updateTick:_tickBuySellData];
        
        [self updateProduct];
        [self updateHandicap:self.handicapData];
    } failed:^(NSError *error) {
    }];
}

- (void)loadDetailData{
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionaryWithDictionary:@{@"id": self.productData.producID, @"c":@"10"}];
    
    [self doRequest:API_DETAIL_PI parameters:dicParameters success:^(id responsData) {
        NSArray *arrayResponse = [responsData split:@";"];
        
        NSMutableArray *arrayDetails = [[NSMutableArray alloc] init];
        [arrayResponse enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
            
            NSArray *arrayDetail = [obj split:@"|"];
            CCSTickData *tickData = [[CCSTickData alloc] init];
            [arrayDetail enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                switch (index) {
                    case 0:
                        // 商品ID
                        break;
                    case 1:
                        // 行情时间
                        [tickData setTime: [obj dateWithFormat:@"yyyyMMddHHmmss" target:@"HH:mm:ss"]];
                        break;
                    case 2:
                        // 最新价
                        [tickData setPrice:obj];
                        break;
                    case 3:
                        // 现量
                        [tickData setCount:obj];
                        break;
                    case 4:
                        // 成交量
                        break;
                    case 5:
                        // 成交额
                        break;
                    case 6:
                        // 持仓量
                        break;
                    case 7:
                        // 报价类型
                        break;
                    default:
                        break;
                }
            }];
            if (tickData.time) {
                [arrayDetails addObject:tickData];
            }
        }];
        
        [self setDetailData:arrayDetails];
        [_tbDetail reloadData];
    } failed:^(NSError *error) {
    }];
}

- (void)doRequest:(NSString *)pi parameters:(NSMutableDictionary *) parameters success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    DO_IN_MAIN_QUEUE(^{
        if (_requestingCount == 0) {
            [SVProgressHUD show];
        }
        _requestingCount++;
        NSLog(@"_requestingCount ++: %lu", (unsigned long)_requestingCount);
    });
    [[TYHttpRequest sharedInstance] requireWithPi:pi dic:parameters isHaveID:NO WithVc:self success:^(id responsData) {
        NSLog(@"Response Data: %@", responsData);
        successBlock(responsData);
        DO_IN_MAIN_QUEUE_AFTER(0.2, ^{
            _requestingCount--;
            NSLog(@"_requestingCount --: %lu", (unsigned long)_requestingCount);
            if (_requestingCount == 0) {
                [SVProgressHUD dismiss];
            }
        });
    }];
}

- (NSString *)findKLineType:(ChartDataType) dataType{
    // "M" : 分钟线,"Q" : 15分钟线,"H" : 小时线,"d" : 日线,"m" : 月线,"y" : 年线
    return IIF(dataType == ChartDayData, @"d", IIF(dataType == ChartWeekData, @"w", IIF(dataType == ChartMonthData, @"m", IIF(dataType == Chart1minuteData, @"M", IIF(dataType == Chart5minuteData, @"M5", IIF(dataType == Chart15minuteData, @"Q", IIF(dataType == Chart30minuteData, @"M30", IIF(dataType == Chart1hourData, @"H", IIF(dataType == Chart2hourData, @"H2", IIF(dataType == Chart4hourData, @"H4", @"M"))))))))));
}

- (CCSGroupChartData *)findDisplayGroupChartData:(ChartDataType) dataType{
    return IIF(dataType == ChartDayData, self.chartDayData, IIF(dataType == ChartWeekData, self.chartWeekData, IIF(dataType == ChartMonthData, self.chartMonthData, IIF(dataType == Chart1minuteData, self.chart1MinData, IIF(dataType == Chart5minuteData, self.chart5MinData, IIF(dataType == Chart15minuteData, self.chart15MinData, IIF(dataType == Chart30minuteData, self.chart30MinData, IIF(dataType == Chart1hourData, self.chart1HourData, IIF(dataType == Chart2hourData, self.chart2HourData, IIF(dataType == Chart4hourData, self.chart4HourData, nil))))))))));
}

/*******************************************************************************
 * Implements Of CCSChartDelegate
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(CCUInt)index{
    [_groupChart CCSChartBeTouchedOn:chart point:point indexAt:index];
}

- (void)CCSChartBeLongPressDown:(id)chart{
    [self.groupChart CCSChartBeLongPressDown:chart];
}

- (void)CCSChartBeLongPressUp:(id)chart{
    [self.groupChart CCSChartBeLongPressUp:chart];
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(CCUInt)from number:(CCUInt)number{
    CCSGroupChartData *displayGroupChartData = [self findDisplayGroupChartData:_displayChartDataType];
    if (from < 3 && !_isLoadingMore && _requestingCount==0 && displayGroupChartData && [displayGroupChartData canLoadMore]) {
        _isLoadingMore = YES;
        // 请求数据
        DO_IN_MAIN_QUEUE_AFTER(0.5,^(void){
            [self loadkLineData:_displayChartDataType];
        });
    }else if(_requestingCount == 0){
        [_groupChart CCSChartDisplayChangedFrom:chart from:from number:number];
        if (displayGroupChartData) {
            [displayGroupChartData setDisplayFrom:from];
            [displayGroupChartData setDisplayNumber:number];
        }
    }
}

/*******************************************************************************
 * Implements Of UITableViewDataSource
 *******************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_detailData) {
        return [_detailData count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCSMarketDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier forIndexPath:indexPath];
    [cell setData:_detailData[indexPath.row]];
    return cell;
}

/*******************************************************************************
 * Implements Of UITableViewDelegate
 *******************************************************************************/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)showKMinsMenu{
    [UIView animateWithDuration:0.2f animations:^{
        if (self.vMinsContainer.alpha == 0.0f) {
            self.vMinsContainer.alpha = 1.0f;
        }else{
            self.vMinsContainer.alpha = 0.0f;
        }
    }];
}

- (void)showKLineChartsWithMinutes: (NSInteger) minutes{
    if (minutes == 1){
        self.displayType = Display1MinKLineType;
        if (!self.chart1MinData) {
            [self loadkLineData:Chart1minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart1MinData];
        }
    }else if(minutes == 5){
        self.displayType = Display5MinKLineType;
        if (!self.chart5MinData) {
            [self loadkLineData:Chart5minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart5MinData];
        }
    }else if(minutes == 15){
        self.displayType = Display15MinKLineType;
        if (!self.chart15MinData) {
            [self loadkLineData:Chart15minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart15MinData];
        }
    }else if(minutes == 30){
        self.displayType = Display30MinKLineType;
        if (!self.chart30MinData) {
            [self loadkLineData:Chart30minuteData];
        }else{
            [self.groupChart setGroupChartData:self.chart30MinData];
        }
    }else if(minutes == 60){
        self.displayType = Display1HourKLineType;
        if (!self.chart1HourData) {
            [self loadkLineData:Chart1hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart1HourData];
        }
    }else if(minutes == 120){
        self.displayType = Display2HourKLineType;
        if (!self.chart2HourData) {
            [self loadkLineData:Chart2hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart2HourData];
        }
    }else if(minutes == 240){
        self.displayType = Display4HourKLineType;
        if (!self.chart4HourData) {
            [self loadkLineData:Chart4hourData];
        }else{
            [self.groupChart setGroupChartData:self.chart4HourData];
        }
    }else{
    }
}

- (void)updateChartsWithIndicatorType:(IndicatorType) indicatorType{
    if (indicatorType == IndicatorMACD) {
        [self.chartDayData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chartWeekData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chartMonthData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart1MinData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart5MinData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart15MinData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart30MinData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart1HourData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart2HourData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        [self.chart4HourData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        
        [self.groupChart updateMACDChart];
    }else if (indicatorType == IndicatorMA){
        [self.chartDayData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chartWeekData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chartMonthData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart1MinData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart5MinData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart15MinData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart30MinData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart1HourData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart2HourData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        [self.chart4HourData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        
        [self.groupChart updateCandleStickChart];
    }else if (indicatorType == IndicatorVMA){
        [self.chartDayData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chartWeekData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chartMonthData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart1MinData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart5MinData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart15MinData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart30MinData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart1HourData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart2HourData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        [self.chart4HourData updateStickLinesData:self.vma1 ma2:self.vma2 ma3:self.vma3];
        
        [self.groupChart updateStickChart];
    }else if (indicatorType == IndicatorKDJ){
        [self.chartDayData updateKDJData:self.kdjN];
        [self.chartWeekData updateKDJData:self.kdjN];
        [self.chartMonthData updateKDJData:self.kdjN];
        [self.chart1MinData updateKDJData:self.kdjN];
        [self.chart5MinData updateKDJData:self.kdjN];
        [self.chart15MinData updateKDJData:self.kdjN];
        [self.chart30MinData updateKDJData:self.kdjN];
        [self.chart1HourData updateKDJData:self.kdjN];
        [self.chart2HourData updateKDJData:self.kdjN];
        [self.chart4HourData updateKDJData:self.kdjN];
        
        [self.groupChart updateKDJChart];
    }else if (indicatorType == IndicatorRSI){
        [self.chartDayData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chartWeekData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chartMonthData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart1MinData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart5MinData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart15MinData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart30MinData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart1HourData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart2HourData updateRSIData:self.rsiN1 n2:self.rsiN2];
        [self.chart4HourData updateRSIData:self.rsiN1 n2:self.rsiN2];
        
        [self.groupChart updateRSIChart];
    }else if (indicatorType == IndicatorWR){
        [self.chartDayData updateWRData:self.wrN];
        [self.chartWeekData updateWRData:self.wrN];
        [self.chartMonthData updateWRData:self.wrN];
        [self.chart1MinData updateWRData:self.wrN];
        [self.chart5MinData updateWRData:self.wrN];
        [self.chart15MinData updateWRData:self.wrN];
        [self.chart30MinData updateWRData:self.wrN];
        [self.chart1HourData updateWRData:self.wrN];
        [self.chart2HourData updateWRData:self.wrN];
        [self.chart4HourData updateWRData:self.wrN];
        
        [self.groupChart updateWRChart];
    }else if (indicatorType == IndicatorCCI){
        [self.chartDayData updateCCIData:self.cciN];
        [self.chartWeekData updateCCIData:self.cciN];
        [self.chartMonthData updateCCIData:self.cciN];
        [self.chart1MinData updateCCIData:self.cciN];
        [self.chart5MinData updateCCIData:self.cciN];
        [self.chart15MinData updateCCIData:self.cciN];
        [self.chart30MinData updateCCIData:self.cciN];
        [self.chart1HourData updateCCIData:self.cciN];
        [self.chart2HourData updateCCIData:self.cciN];
        [self.chart4HourData updateCCIData:self.cciN];
        
        [self.groupChart updateCCIChart];
    }else if (indicatorType == IndicatorBOLL){
        [self.chartDayData updateBOLLData:self.bollN];
        [self.chartWeekData updateBOLLData:self.bollN];
        [self.chartMonthData updateBOLLData:self.bollN];
        [self.chart1MinData updateBOLLData:self.bollN];
        [self.chart5MinData updateBOLLData:self.bollN];
        [self.chart15MinData updateBOLLData:self.bollN];
        [self.chart30MinData updateBOLLData:self.bollN];
        [self.chart1HourData updateBOLLData:self.bollN];
        [self.chart2HourData updateBOLLData:self.bollN];
        [self.chart4HourData updateBOLLData:self.bollN];
        [self.chartDayData updateCandleStickBollingerBandData:self.bollN];
        [self.chartWeekData updateCandleStickBollingerBandData:self.bollN];
        [self.chartMonthData updateCandleStickBollingerBandData:self.bollN];
        [self.chart1MinData updateCandleStickBollingerBandData:self.bollN];
        [self.chart5MinData updateCandleStickBollingerBandData:self.bollN];
        [self.chart15MinData updateCandleStickBollingerBandData:self.bollN];
        [self.chart30MinData updateCandleStickBollingerBandData:self.bollN];
        [self.chart1HourData updateCandleStickBollingerBandData:self.bollN];
        [self.chart2HourData updateCandleStickBollingerBandData:self.bollN];
        [self.chart4HourData updateCandleStickBollingerBandData:self.bollN];
        
        [self.groupChart updateCandleStickChart];
        [self.groupChart updateBOLLChart];
    }
}

- (void)updateProduct{
    if (!self.productData) {
        return;
    }
    
    [self.lblCurrentPrice setText:[self.productData.currentPrice decimal:self.scale]];
    [self.lblChangePrice setText:[self.productData.changePrice decimal:self.scale]];
    [self.lblChangePercent setText:self.productData.changePercent];
    [self.lblBuyPrice setText:[self.productData.buyPrice decimal:self.scale]];
    [self.lblSellPrice setText:[self.productData.sellPrice decimal:self.scale]];
    [self.lblHighPrice setText:[self.productData.highPrice decimal:self.scale]];
    [self.lblLowPrice setText:[self.productData.lowPrice decimal:self.scale]];
    
    if ([self.productData.currentPrice doubleValue] > [self.handicapData.yesterdayClosePrice doubleValue]) {
        [self.vProductContainer setBackgroundColor:LINE_COLORS[0]];
    }else if ([self.productData.currentPrice doubleValue] < [self.handicapData.yesterdayClosePrice doubleValue]){
        [self.vProductContainer setBackgroundColor:LINE_COLORS[1]];
    }else{
        [self.vProductContainer setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (void)updateHandicap:(CCSHandicapData *) handicapData{
    if (!handicapData) {
        return;
    }
    
    [self.lblHandicapSellPrice setText: [self.handicapData.sellPrice decimal: self.scale]];
    [self.lblHandicapSellCount setText: [self.handicapData.sellCount decimal: self.scale]];
    [self.lblHandicapBuyPrice setText: [self.handicapData.buyPrice decimal: self.scale]];
    [self.lblHandicapBuyCount setText: [self.handicapData.buyCount decimal: self.scale]];
    [self.lblHandicapCurrentPrice setText: [self.handicapData.currentPrice decimal:self.scale]];
    [self.lblHandicapChangePrice setText: [self.handicapData.changePrice decimal:self.scale]];
    [self.lblHandicapHighPrice setText: [self.handicapData.highPrice decimal:self.scale]];
    [self.lblHandicapLowPrice setText: [self.handicapData.lowPrice decimal:self.scale]];
    [self.lblHandicapOpenPrice setText: [self.handicapData.openPrice decimal:self.scale]];
    [self.lblHandicapOpenSumCount setText: [self.handicapData.openSumCount decimal:self.scale]];
    [self.lblHandicapClosePrice setText: [self.handicapData.closePrice decimal:self.scale]];
    [self.lblHandicapCloseSumCount setText: [self.handicapData.closeSumCount unit:self.scale]];
    [self.lblYesterdayClosePrice setText: [self.handicapData.yesterdayClosePrice decimal:self.scale]];
    [self.lblYesterdayCloseSumCount setText: [self.handicapData.yesterdayCloseSumCount decimal: self.scale]];
}

- (void)updateTick:(NSArray *) tickData{
    if (!tickData) {
        return;
    }
    
    [_tickBuySellData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
        CCSTickData *tickData = obj;
        if (index < 5) {
            // 买
            [_arrUIBuyingTimes[index] setText:[NSString stringWithFormat:@"买%lu", index+(NSInteger)1]];
            [((UIButton *)_arrUIBuyingPrices[index]) setTitle:[[tickData price] decimal:0] forState:UIControlStateNormal];
            [_arrUIBuyingCounts[index] setText:[[tickData count] decimal:0]];
        }else{
            // 卖
            NSUInteger sellingIndex = index - 5;
            
            [_arrUISellingTimes[4 - sellingIndex] setText:[NSString stringWithFormat:@"卖%lu", sellingIndex + (NSInteger)1]];
            [((UIButton *)_arrUISellingPrices[4 - sellingIndex]) setTitle:[[tickData price] decimal:0] forState:UIControlStateNormal];
            [_arrUISellingCounts[4 - sellingIndex] setText:[[tickData count] decimal:0]];
        }
    }];
}

- (void)horizontal:(UIButton *) sender{
    CCSMarketDetailHorizontalViewController *horizontalViewController = [[CCSMarketDetailHorizontalViewController alloc] init];
    [horizontalViewController setDisplayType:self.displayType];
    [horizontalViewController setProductData:self.productData];
    [horizontalViewController setHandicapData:self.handicapData];
    [horizontalViewController setDetailData:_detailData];
    [horizontalViewController setScale:self.scale];
    
    [horizontalViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:horizontalViewController animated:YES];
}

- (NSString *)findJSONStringWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    //UTF-8编码
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

- (void)updateTime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM/dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [self.lblTime setText:currentDateStr];
}

- (void)scheduledDisPatchTimerWithName:(NSString *)name
                         timerInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action{
    if (!name) {
        return;
    }
    if (!queue) {
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_resume(timer);
    
    if (!_dicTimers) {
        _dicTimers = [NSMutableDictionary dictionaryWithDictionary:@{name:timer}];
    }else{
        [_dicTimers setObject:timer forKey:name];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        action();
        
        if (!repeats) {
            [self cancelDisPatchTimerWithName:name];
        }
    });
}

- (void)cancelDisPatchTimerWithName:(NSString *)name{
    if (!name || !_dicTimers[name]) {
        return;
    }
    
    dispatch_source_cancel(_dicTimers[name]);
    [_dicTimers removeObjectForKey:name];
}

/*******************************************************************************
 * setter
 *******************************************************************************/

- (void)setHandicapData:(CCSHandicapData *)handicapData{
    _handicapData = handicapData;
}

- (void)setTickBuySellData:(NSMutableArray *) tickBuySellData{
    _tickBuySellData = tickBuySellData;
}

- (void)setDetailData:(NSArray *) detailData{
    _detailData = detailData;
}

/**
 * 设置分时数据
 */
- (void)setTickData:(NSArray *) arrayTickData{
    _arrayTickData = arrayTickData;
}

/**
 * 设置日数据
 */
- (void)setDayData:(NSArray *) ohlcvDatas{
    if (_isRefreshing || !self.chartDayData) {
        _isRefreshing = NO;
        
        self.chartDayData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chartDayData];
    }else{
        [self.chartDayData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置周数据
 */
- (void)setWeekData:(NSArray *) ohlcvDatas{
    if (_isRefreshing || !self.chartWeekData) {
        _isRefreshing = NO;
        
        self.chartWeekData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chartWeekData];
    }else{
        [self.chartWeekData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置月数据
 */
- (void)setMonthData:(NSArray *) ohlcvDatas{
    if (_isRefreshing || !self.chartMonthData) {
        _isRefreshing = NO;
        
        self.chartMonthData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chartMonthData];
    }else{
        [self.chartMonthData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置1分钟数据
 */
- (void)set1minData:(NSArray *) ohlcvDatas{
    if (!self.chart1MinData) {
        self.chart1MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        [self.groupChart setGroupChartData:self.chart1MinData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
        
    }else{
        [self.chart1MinData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置5分钟数据
 */
- (void)set5minData:(NSArray *) ohlcvDatas{
    if (!self.chart5MinData) {
        self.chart5MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart5MinData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart5MinData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置15分钟数据
 */
- (void)set15minData:(NSArray *) ohlcvDatas{
    if (!self.chart15MinData) {
        self.chart15MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart15MinData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart15MinData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置30分钟数据
 */
- (void)set30minData:(NSArray *) ohlcvDatas{
    if (!self.chart30MinData) {
        self.chart30MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart30MinData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart30MinData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置1小时数据
 */
- (void)set1HourData:(NSArray *) ohlcvDatas{
    if (!self.chart1HourData) {
        self.chart1HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart1HourData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart1HourData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置2小时数据
 */
- (void)set2HourData:(NSArray *) ohlcvDatas{
    if (!self.chart2HourData) {
        self.chart2HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart2HourData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart2HourData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

/**
 * 设置4小时数据
 */
- (void)set4HourData:(NSArray *) ohlcvDatas{
    if (!self.chart4HourData) {
        self.chart4HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas displayChartType:self.groupChart.bottomChartType];
        
        [self.groupChart setGroupChartData:self.chart4HourData];
    }else if (_isRefreshing){
        _isRefreshing = NO;
    }else{
        [self.chart4HourData mergeWithCCSOHLCVDDatas:ohlcvDatas mergeType:MergeFrontType];
        [self.groupChart refreshGroupChart];
    }
}

@end
