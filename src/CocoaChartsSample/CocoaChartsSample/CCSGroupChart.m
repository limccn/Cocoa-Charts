//
//  CCSGroupChart.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSGroupChart.h"

#import "CCSColoredStickChartData.h"
#import "CCSCandleStickChartData.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"
#import "CCSMACDData.h"

#import "ta_libc.h"
#import "CCSTALibUtils.h"
#import "CCSStringUtils.h"

#define WR_NONE_DISPLAY 101

#define AXIS_CALC_PARM  1000

@implementation OHLCVDGroupData

@end

@interface CCSGroupChart (){
    /** 是否初始化 */
    BOOL                     _isInitialize;
    /** 是否需要重新加载 */
    BOOL                     _needsReload;
    /** 当前 view 大小 */
    CGSize                   _contentSize;
    
}

@end

@implementation CCSGroupChart

/*******************************************************************************
 * initialize
 *******************************************************************************/

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // 设置初始化标识
    _isInitialize = YES;
}

/*******************************************************************************
 * Overrides From UIView
 *******************************************************************************/

- (void)layoutSubviews{
    [super layoutSubviews];
    // 初始化
    if (_isInitialize) {
        _isInitialize = NO;
        _contentSize = self.bounds.size;
        
        [self initControllers];
        
        [self initCandleStickChart];
        [self initStickChart];
        [self initMACDChart];
        [self initKDJChart];
        [self initRSIChart];
        [self initWRChart];
        [self initCCIChart];
        [self initBOLLChart];
        
        self.scrollViewBottomChart.contentSize = CGSizeMake(self.scrollViewBottomChart.frame.size.width * 7, self.self.scrollViewBottomChart.frame.size.height);
        
        //如果k线中已有数据，显示最后一根
        if ([self.candleStickChart.stickData count] > 0) {
            self.candleStickChart.selectedStickIndex = [self.candleStickChart.stickData count] - 1;
            [self candleStickChartTouch:self];
        }
    }
    // 刷新
    if (_needsReload) {
        _needsReload = NO;
        
        [self initCandleStickChartData];
        [self initStickChartData];
        [self initMACDChartData];
        [self initKDJChartData];
        [self initRSIChartData];
        [self initWRChartData];
        [self initCCIChartData];
        [self initBOLLChartData];
    }
}

/*******************************************************************************
* Implements Of UIScrollViewDelegate
*******************************************************************************/

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int page = (int) floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    //判断是否page发生了变更
    if (self.segBottomChartType.selectedSegmentIndex != page) {
        //设置pageControl
        self.segBottomChartType.selectedSegmentIndex = page;
        [self.segBottomChartType setNeedsDisplay];
    }
}

/*******************************************************************************
 * Implements Of CCSChartDelegate
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index {
    
    if ([chart isKindOfClass:[self.candleStickChart class]]) {
        
        if (0 == self.segBottomChartType.selectedSegmentIndex) {
            self.stickChart.singleTouchPoint = point;
            self.stickChart.selectedStickIndex = index;
            [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
            self.macdChart.singleTouchPoint = point;
            self.macdChart.selectedStickIndex = index;
            [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
            self.kdjChart.singleTouchPoint = point;
            [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
            self.rsiChart.singleTouchPoint = point;
            [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
            self.wrChart.singleTouchPoint = point;
            [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
            self.cciChart.singleTouchPoint = point;
            [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
            self.bollChart.singleTouchPoint = point;
            [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        }
    }else{
        self.stickChart.singleTouchPoint = point;
        self.stickChart.selectedStickIndex = index;
        [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
    }
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number{
    
    if ([chart isKindOfClass:[self.candleStickChart class]]) {
        if (0 == self.segBottomChartType.selectedSegmentIndex) {
            self.stickChart.displayFrom = from;
            self.stickChart.displayNumber = number;
            [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
            self.macdChart.displayFrom = from;
            self.macdChart.displayNumber = number;
            [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
            self.kdjChart.displayFrom = from;
            self.kdjChart.displayNumber = number;
            [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
            self.rsiChart.displayFrom = from;
            self.rsiChart.displayNumber = number;
            [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
            self.wrChart.displayFrom = from;
            self.wrChart.displayNumber = number;
            [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
            self.cciChart.displayFrom = from;
            self.cciChart.displayNumber = number;
            [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
            self.bollChart.displayFrom = from;
            self.bollChart.displayNumber = number;
            [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        }
        
    }else{
        self.candleStickChart.displayFrom = from;
        self.candleStickChart.displayNumber = number;
        [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
    }
}

/*******************************************************************************
* Public Methods
*******************************************************************************/

- (void)setChartData:(NSMutableArray *)chartData{
    _chartData = chartData;
    
    _needsReload = YES;
    [self setNeedsLayout];
}

- (void)setChartDelegate:(UIViewController<CCSChartDelegate> *)chartDelegate{
    _chartDelegate = chartDelegate;
    
    self.candleStickChart.chartDelegate = self.chartDelegate;
    self.stickChart.chartDelegate = self.chartDelegate;
    self.macdChart.chartDelegate = self.chartDelegate;
    self.kdjChart.chartDelegate = self.chartDelegate;
    self.rsiChart.chartDelegate = self.chartDelegate;
    self.wrChart.chartDelegate = self.chartDelegate;
    self.cciChart.chartDelegate = self.chartDelegate;
    self.bollChart.chartDelegate = self.chartDelegate;
}

/*******************************************************************************
* Private Methods
*******************************************************************************/

- (void)initControllers {
    UISegmentedControl *segBottomChartType = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"VOL", @"MACD", @"KDJ", @"RSI", @"WR", @"CCI", @"BOLL", nil]];
    segBottomChartType.frame = CGRectMake(0.0f, _contentSize.height - 33.0f,  _contentSize.width, 33.0f);
    //segBottomChartType.segmentedControlStyle = UISegmentedControlStyleBar;
    [segBottomChartType addTarget:self action:@selector(segBottomChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    [segBottomChartType setSelectedSegmentIndex:0];
    
    UIScrollView *scrollViewBottomChart = [[UIScrollView alloc] init];
    scrollViewBottomChart.frame = CGRectMake(0.0f, (_contentSize.height - 33.0f)/3.0f*2 - 1.0f, _contentSize.width,  (_contentSize.height - 33.0f)/3.0f);
    scrollViewBottomChart.bounces = NO;
    scrollViewBottomChart.contentSize = CGSizeMake(_contentSize.width * 6, (_contentSize.height - 33.0f)/3.0f);
    scrollViewBottomChart.pagingEnabled = YES;
    scrollViewBottomChart.delegate = self;
    [scrollViewBottomChart setScrollEnabled:NO];
    
    // 设置单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [scrollViewBottomChart addGestureRecognizer:tap];
    
    self.segBottomChartType = segBottomChartType;
    self.scrollViewBottomChart = scrollViewBottomChart;

    [self addSubview:segBottomChartType];
    [self addSubview:scrollViewBottomChart];
}

- (void)initCandleStickChart {
    CCSBOLLMASlipCandleStickChart *candleStickChart = [[CCSBOLLMASlipCandleStickChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _contentSize.width, (_contentSize.height - 33.0f)/3.0f * 2.0f)];
    
    self.candleStickChart = candleStickChart;
    [self initCandleStickChartData];
    
    //设置stickData
    candleStickChart.maxValue = 340;
    candleStickChart.minValue = 240;
    candleStickChart.axisCalc = 1;
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.displayLatitudeTitle  = YES;
    candleStickChart.userInteractionEnabled = YES;
    
//    candleStickChart.candleStickStyle = GroupCandleStickChartTypeBar;
    candleStickChart.axisYPosition = CCSGridChartYAxisPositionRight;
    candleStickChart.displayNumber = 50;
    candleStickChart.displayFrom = 0;
    candleStickChart.bollingerBandStyle = CCSBollingerBandStyleNone;
    candleStickChart.axisCalc = AXIS_CALC_PARM;
    candleStickChart.latitudeNum = 3;
    
    // 边框颜色
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.axisMarginBottom = 15.0f;
    
    candleStickChart.chartDelegate = self.chartDelegate;
    
    self.candleStickChart.backgroundColor = [UIColor clearColor];
    
    [candleStickChart addTarget:self action:@selector(candleStickChartTouch:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self addSubview:candleStickChart];
}

- (void)initCandleStickChartData {
    if (self.chartData != NULL) {
        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
        
        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
            OHLCVDGroupData *item = [self.chartData objectAtIndex:i];
            CCSCandleStickChartData *stickData = [[CCSCandleStickChartData alloc] init];
            stickData.open = [item.open doubleValue];
            stickData.high = [item.high doubleValue];
            stickData.low = [item.low doubleValue];
            stickData.close = [item.close doubleValue];
            stickData.change = 0;
            stickData.date = [item.date dateWithFormat:@"yyyy-MM-ddHH: mm: ss" target:@"yy-MM-dd"];
            // 增加数据
            [stickDatas addObject:stickData];
        }
        NSMutableArray *maLines = [[NSMutableArray alloc] init];
        [maLines addObject:[self computeMAData:self.chartData period:5]];
        [maLines addObject:[self computeMAData:self.chartData period:25]];
        
        self.candleStickChart.stickData = stickDatas;
        self.candleStickChart.linesData = maLines;
        self.candleStickChart.bollingerBandData = [self computeBOLLData:self.chartData];
        
        self.candleStickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.candleStickChart setNeedsDisplay];
    }
}

- (void)initStickChart {
    CCSColoredStickChart *stickchart = [[CCSColoredStickChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.stickChart = stickchart;
    
    //初始化数据
    [self initStickChartData];
    
    //设置stickData
    self.stickChart.maxValue = 800000;
    self.stickChart.minValue = 0;
    self.stickChart.stickFillColor = [UIColor colorWithRed:0.7 green:0.7 blue:0 alpha:0.8];
    
    self.stickChart.displayNumber = 50;
    self.stickChart.displayFrom = 0;
    self.stickChart.displayLongitudeTitle = NO;
    self.stickChart.axisMarginBottom = 3;
    
    self.stickChart.backgroundColor = [UIColor clearColor];
    
    [self.scrollViewBottomChart addSubview:self.stickChart];
}

- (void)initStickChartData {
    if (self.chartData != NULL) {
        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
        
        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
            OHLCVDGroupData *item = [self.chartData objectAtIndex:i];
            CCSColoredStickChartData *stickData = [[CCSColoredStickChartData alloc] init];
            stickData.high = [item.vol doubleValue];
            stickData.low = 0;
            stickData.date = [item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"];
            
            if ([item.close doubleValue] > [item.open doubleValue]) {
                stickData.fillColor = [UIColor greenColor];
                stickData.borderColor = [UIColor clearColor];
            } else if ([item.close doubleValue] < [item.open doubleValue]) {
                stickData.fillColor = [UIColor clearColor];
                stickData.borderColor = [UIColor redColor];
                
            } else {
                stickData.fillColor = [UIColor lightGrayColor];
                stickData.borderColor = [UIColor clearColor];
            }
            //增加数据
            [stickDatas addObject:stickData];
        }
        
        self.stickChart.stickData = stickDatas;
        self.stickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.stickChart setNeedsDisplay];
    }
}

- (void)initMACDChart {
    CCSMACDChart *macdchart = [[CCSMACDChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    macdchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.macdChart = macdchart;
    
    //初始化数据
    [self initMACDChartData];
    
    //设置stickData
    self.macdChart.stickFillColor = [UIColor colorWithRed:0.7 green:0.7 blue:0 alpha:0.8];
    
    self.macdChart.maxValue = 300000;
    self.macdChart.minValue = -300000;
    self.macdChart.maxSticksNum = 100;
    self.macdChart.macdDisplayType = CCSMACDChartDisplayTypeLineStick;
    self.macdChart.positiveStickColor = [UIColor redColor];
    self.macdChart.negativeStickColor = [UIColor greenColor];
    self.macdChart.macdLineColor = [UIColor cyanColor];
    self.macdChart.deaLineColor = [UIColor blueColor];
    self.macdChart.diffLineColor = [UIColor orangeColor];
    self.macdChart.displayNumber = 50;
    self.macdChart.displayFrom = 0;
    self.macdChart.axisCalc = 1000000;
    self.macdChart.displayLongitudeTitle = NO;
    self.macdChart.axisMarginBottom = 3;
    
    self.macdChart.backgroundColor = [UIColor clearColor];
    
    [self.scrollViewBottomChart addSubview:self.macdChart];
}

- (void)initMACDChartData {
    if (self.chartData != NULL) {
        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
            OHLCVDGroupData *item = [self.chartData objectAtIndex:i];
            CCSCandleStickChartData *stickData = [[CCSCandleStickChartData alloc] init];
            stickData.open = [item.open doubleValue];
            stickData.high = [item.high doubleValue];
            stickData.low = [item.low doubleValue];
            stickData.close = [item.close doubleValue];
            stickData.change = 0;
            stickData.date = [item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"];
            //增加数据
            [stickDatas addObject:stickData];
        }
        
        self.macdChart.stickData = [self computeMACDData:self.chartData];
        self.macdChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.macdChart setNeedsDisplay];
    }
}

- (void)initKDJChart {
    CCSSlipLineChart *kdjchart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 2, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    kdjchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.kdjChart = kdjchart;
    
    //初始化数据
    [self initKDJChartData];
    
    //设置stickData
    self.kdjChart.displayNumber = 50;
    self.kdjChart.displayFrom = 0;
    self.kdjChart.latitudeNum = 2;
    self.kdjChart.displayLongitudeTitle = NO;
    self.kdjChart.axisMarginBottom = 3;
    
    self.kdjChart.backgroundColor = [UIColor clearColor];
    
    [self.scrollViewBottomChart addSubview:self.kdjChart];
}

- (void)initKDJChartData {
    if (self.chartData != NULL) {
        
        self.kdjChart.linesData = [self computeKDJData:self.chartData];
        self.kdjChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.kdjChart setNeedsDisplay];
    }
}

- (void)initRSIChart {
    CCSSlipLineChart *rsiChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 3, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    rsiChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.rsiChart = rsiChart;
    
    //初始化数据
    [self initRSIChartData];
    
    //设置stickData
    self.rsiChart.displayNumber = 50;
    self.rsiChart.displayFrom = 0;
    self.rsiChart.displayLongitudeTitle = NO;
    self.rsiChart.axisMarginBottom = 3;
    
    self.rsiChart.backgroundColor = [UIColor clearColor];
    
    [self.scrollViewBottomChart addSubview:self.rsiChart];
}

- (void)initRSIChartData {
    if (self.chartData != NULL) {
        
        NSMutableArray *linesData = [[NSMutableArray alloc] init];
        [linesData addObject:[self computeRSIData:self.chartData period:6]];
        [linesData addObject:[self computeRSIData:self.chartData period:12]];
        [linesData addObject:[self computeRSIData:self.chartData period:24]];
        
        self.rsiChart.linesData = linesData;
        self.rsiChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.rsiChart setNeedsDisplay];
    }
}

- (void)initWRChart {
    CCSSlipLineChart *wrChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 4, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    wrChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.wrChart = wrChart;
    
    //初始化数据
    [self initWRChartData];
    
    //设置stickData
    self.wrChart.displayNumber = 50;
    self.wrChart.displayFrom = 0;
    self.wrChart.noneDisplayValue = WR_NONE_DISPLAY;
    self.wrChart.displayLongitudeTitle = NO;
    self.wrChart.axisMarginBottom = 3;
    
    self.wrChart.backgroundColor = [UIColor clearColor];
    // self.wrChart.noneDisplayValue = 9999;
    
    [self.scrollViewBottomChart addSubview:self.wrChart];
}

- (void)initWRChartData {
    if (self.chartData != NULL) {
        self.wrChart.linesData = [self computeWRData:self.chartData period:6];
        self.wrChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.wrChart setNeedsDisplay];
    }
}

- (void)initCCIChart {
    CCSSlipLineChart *cciChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 5, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    cciChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.cciChart = cciChart;
    
    //初始化数据
    [self initCCIChartData];
    
    //设置stickData
    self.cciChart.displayNumber = 50;
    self.cciChart.displayFrom = 0;
    self.cciChart.displayLongitudeTitle = NO;
    self.cciChart.axisMarginBottom = 3;
    
    self.cciChart.backgroundColor = [UIColor clearColor];
    
    [self.scrollViewBottomChart addSubview:self.cciChart];
}

- (void)initCCIChartData {
    if (self.chartData != NULL) {
        
        self.cciChart.linesData = [self computeCCIData:self.chartData period:14];
        self.cciChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.cciChart setNeedsDisplay];
    }
}

- (void)initBOLLChart {
    CCSSlipLineChart *bollChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 6, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    bollChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.bollChart = bollChart;
    
    //初始化数据
    [self initBOLLChartData];
    
    //设置stickData
    self.bollChart.displayNumber = 50;
    self.bollChart.displayFrom = 0;
    self.bollChart.displayLongitudeTitle = NO;
    self.bollChart.axisMarginBottom = 3;
    
    self.bollChart.backgroundColor = [UIColor clearColor];
    self.bollChart.axisCalc = AXIS_CALC_PARM;
    
    [self.scrollViewBottomChart addSubview:self.bollChart];
}

- (void)initBOLLChartData {
    if (self.chartData != NULL) {
        self.bollChart.linesData = [self computeBOLLData:self.chartData];
        self.bollChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.bollChart setNeedsDisplay];
    }
}

- (void)candleStickChartTouch:(id)sender {
    NSInteger i = self.candleStickChart.selectedStickIndex;
    
    if (self.candleStickChart.stickData && [self.candleStickChart.stickData count] > 0) {
        CCSCandleStickChartData *ohlc = [self.candleStickChart.stickData objectAtIndex:i];
        CCSCandleStickChartData *lastohlc;
        //第一根k线时，处理前日比
        if (i == 0) {
            lastohlc = [[CCSCandleStickChartData alloc] initWithOpen:0 high:0 low:0 close:ohlc.close - ohlc.change date:@""];
        } else {
            lastohlc = [self.candleStickChart.stickData objectAtIndex:i - 1];
        }
        
        //设置标签值
        self.lblOpen.text = [[[NSString stringWithFormat:@"%f", ohlc.open] decimal:2] zero];
        self.lblHigh.text = [[[NSString stringWithFormat:@"%f", ohlc.high] decimal:2] zero];
        self.lblLow.text = [[[NSString stringWithFormat:@"%f", ohlc.low] decimal:2] zero];
        self.lblClose.text = [[[NSString stringWithFormat:@"%f", ohlc.close] decimal:2] zero];
        
        self.lblChange.text = [NSString stringWithFormat:@"%@(%@%%)",
                               [[NSString stringWithFormat:@"%f", ohlc.change] decimalWithSign:2],
                               [[NSString stringWithFormat:@"%f", ohlc.change * 100 / lastohlc.close] decimalWithSign:2]];
        
        self.lblPreClose.text = [NSString stringWithFormat:@"前日終値:%@", [[[NSString stringWithFormat:@"%f", lastohlc.close] decimal:2] zero]];
        
        self.lblDate.text = ohlc.date;
        
        //设置标签文本颜色
        if (ohlc.open == 0) {
            self.lblOpen.textColor = [UIColor blackColor];
        } else {
            //设置标签文本颜色
            self.lblOpen.textColor = ohlc.open != lastohlc.close ? ohlc.open > lastohlc.close ? [UIColor redColor] : [UIColor blueColor] : [UIColor blackColor];
        }
        
        if (ohlc.high == 0) {
            self.lblHigh.textColor = [UIColor blackColor];
        } else {
            //设置标签文本颜色
            self.lblHigh.textColor = ohlc.high != lastohlc.close ? ohlc.high > lastohlc.close ? [UIColor redColor] : [UIColor blueColor] : [UIColor blackColor];
        }
        
        if (ohlc.low == 0) {
            self.lblLow.textColor = [UIColor blackColor];
        } else {
            self.lblLow.textColor = ohlc.low != lastohlc.close ? ohlc.low > lastohlc.close ? [UIColor redColor] : [UIColor blueColor] : [UIColor blackColor];
        }
        
        if (ohlc.close == 0) {
            self.lblClose.textColor = [UIColor blackColor];
        } else {
            self.lblClose.textColor = ohlc.close != lastohlc.close ? ohlc.close > lastohlc.close ? [UIColor redColor] : [UIColor blueColor] : [UIColor blackColor];
        }
        
        if (ohlc.change == 0) {
            self.lblChange.textColor = [UIColor blackColor];
        } else {
            self.lblChange.textColor = ohlc.close != lastohlc.close ? ohlc.close > lastohlc.close ? [UIColor redColor] : [UIColor blueColor] : [UIColor blackColor];
        }
        
    }
    
    if (self.stickChart.stickData && [self.stickChart.stickData count] > 0) {
        //成交量
        self.lblVolume.text = [[[NSString stringWithFormat:@"%-2.0f", ((CCSStickChartData *) [self.stickChart.stickData objectAtIndex:i]).high] decimal] zero];
    }
    
    if (self.candleStickChart.linesData && [self.candleStickChart.linesData count] > 0) {
        
        //均线数据
        CCSTitledLine *ma5 = [self.candleStickChart.linesData objectAtIndex:0];
        CCSTitledLine *ma10 = [self.candleStickChart.linesData objectAtIndex:1];
        
        //MA5
        if (ma5 && ma5.data && [ma5.data count] > 0) {
            if (((CCSLineData *) [ma5.data objectAtIndex:i]).value != 0) {
                self.lblSubTitle1.text = [NSString stringWithFormat:@"%@: %@", ma5.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [ma5.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
            } else {
                self.lblSubTitle1.text = @"";
            }
            self.lblSubTitle1.textColor = ma5.color;
        }
        
        //MA10
        if (ma10 && ma10.data && [ma10.data count] > 0) {
            if (((CCSLineData *) [ma10.data objectAtIndex:i]).value != 0) {
                self.lblSubTitle2.text = [NSString stringWithFormat:@"%@: %@", ma10.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [ma10.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
            } else {
                self.lblSubTitle2.text = @"";
            }
            self.lblSubTitle2.textColor = ma10.color;
        }
        
        if (GroupChartViewTypeVOL == self.bottomChartType) {
            if (self.stickChart.stickData && [self.stickChart.stickData count] > 0) {
                self.lblSubTitle6.text = [NSString stringWithFormat:@"VOL: %@", self.lblVolume.text];
            }
            
        } else if (GroupChartViewTypeMACD == self.bottomChartType) {
            if (self.macdChart.stickData && [self.macdChart.stickData count] > 0) {
                
                CCSMACDData *macdData = [self.macdChart.stickData objectAtIndex:i];
                if (macdData.diff != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"DIFF: %@", [[[NSString stringWithFormat:@"%f", (macdData.diff / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = self.macdChart.diffLineColor;
                
                if (macdData.dea != 0) {
                    self.lblSubTitle7.text = [NSString stringWithFormat:@"DEA: %@", [[[NSString stringWithFormat:@"%f", (macdData.dea / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle7.text = @"";
                }
                self.lblSubTitle7.textColor = self.macdChart.deaLineColor;
                
                if (macdData.macd != 0) {
                    self.lblSubTitle8.text = [NSString stringWithFormat:@"MACD: %@", [[[NSString stringWithFormat:@"%f", (macdData.macd / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle8.text = @"";
                }
                self.lblSubTitle8.textColor = self.macdChart.macdLineColor;
                
            }
        } else if (GroupChartViewTypeKDJ == self.bottomChartType) {
            //均线数据
            CCSTitledLine *lineK = [self.kdjChart.linesData objectAtIndex:0];
            CCSTitledLine *lineD = [self.kdjChart.linesData objectAtIndex:1];
            CCSTitledLine *lineJ = [self.kdjChart.linesData objectAtIndex:2];
            
            //K
            if (lineK && lineK.data && [lineK.data count] > 0) {
                if (((CCSLineData *) [lineK.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"%@: %@", lineK.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lineK.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = lineK.color;
            }
            
            //D
            if (lineD && lineD.data && [lineD.data count] > 0) {
                if (((CCSLineData *) [lineD.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle7.text = [NSString stringWithFormat:@"%@: %@", lineD.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lineD.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle7.text = @"";
                }
                self.lblSubTitle7.textColor = lineD.color;
            }
            
            //J
            if (lineJ && lineJ.data && [lineJ.data count] > 0) {
                if (((CCSLineData *) [lineJ.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle8.text = [NSString stringWithFormat:@"%@: %@", lineJ.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lineJ.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle8.text = @"";
                }
                self.lblSubTitle8.textColor = lineJ.color;
            }
        } else if (GroupChartViewTypeRSI == self.bottomChartType) {
            //均线数据
            CCSTitledLine *line6 = [self.rsiChart.linesData objectAtIndex:0];
            CCSTitledLine *line12 = [self.rsiChart.linesData objectAtIndex:1];
            CCSTitledLine *line24 = [self.rsiChart.linesData objectAtIndex:2];
            
            //6
            if (line6 && line6.data && [line6.data count] > 0) {
                if (((CCSLineData *) [line6.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"%@: %@", line6.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [line6.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = line6.color;
            }
            
            //12
            if (line12 && line12.data && [line12.data count] > 0) {
                if (((CCSLineData *) [line12.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle7.text = [NSString stringWithFormat:@"%@: %@", line12.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [line12.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle7.text = @"";
                }
                self.lblSubTitle7.textColor = line12.color;
            }
            
            //24
            if (line24 && line24.data && [line24.data count] > 0) {
                if (((CCSLineData *) [line24.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle8.text = [NSString stringWithFormat:@"%@: %@", line24.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [line24.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle8.text = @"";
                }
                self.lblSubTitle8.textColor = line24.color;
            }
        } else if (GroupChartViewTypeWR == self.bottomChartType) {
            //均线数据
            CCSTitledLine *lineWR = [self.wrChart.linesData objectAtIndex:0];
            
            //WR
            if (lineWR && lineWR.data && [lineWR.data count] > 0) {
                if (((CCSLineData *) [lineWR.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"%@: %@", lineWR.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lineWR.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = lineWR.color;
            }
            
            self.lblSubTitle7.text = @"";
            self.lblSubTitle8.text = @"";
            
        } else if (GroupChartViewTypeCCI == self.bottomChartType) {
            //均线数据
            CCSTitledLine *lineCCI = [self.cciChart.linesData objectAtIndex:0];
            
            if (lineCCI && lineCCI.data && [lineCCI.data count] > 0) {
                if (((CCSLineData *) [lineCCI.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"%@: %@", lineCCI.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lineCCI.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = lineCCI.color;
            }
            
            self.lblSubTitle7.text = @"";
            self.lblSubTitle8.text = @"";
            
        } else if (GroupChartViewTypeBOLL == self.bottomChartType) {
            //均线数据
            CCSTitledLine *upper = [self.candleStickChart.bollingerBandData objectAtIndex:0];
            CCSTitledLine *lower = [self.candleStickChart.bollingerBandData objectAtIndex:1];
            CCSTitledLine *boll = [self.candleStickChart.bollingerBandData objectAtIndex:2];
            
            //UPPER
            if (upper && upper.data && [upper.data count] > 0) {
                if (((CCSLineData *) [upper.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle3.text = [NSString stringWithFormat:@"%@: %@", upper.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [upper.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle3.text = @"";
                }
                self.lblSubTitle3.textColor = upper.color;
                
                self.lblSubTitle6.textColor = self.lblSubTitle3.textColor;
                self.lblSubTitle6.text = self.lblSubTitle3.text;
            }
            
            //LOWER
            if (lower && lower.data && [lower.data count] > 0) {
                if (((CCSLineData *) [lower.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle4.text = [NSString stringWithFormat:@"%@: %@", lower.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [lower.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle4.text = @"";
                }
                self.lblSubTitle4.textColor = lower.color;
                
                self.lblSubTitle7.textColor = self.lblSubTitle4.textColor;
                self.lblSubTitle7.text = self.lblSubTitle4.text;
            }
            
            //BOLL
            if (boll && boll.data && [boll.data count] > 0) {
                if (((CCSLineData *) [boll.data objectAtIndex:i]).value != 0) {
                    self.lblSubTitle5.text = [NSString stringWithFormat:@"%@: %@", boll.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [boll.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle5.text = @"";
                }
                self.lblSubTitle5.textColor = boll.color;
                
                self.lblSubTitle8.textColor = self.lblSubTitle5.textColor;
                self.lblSubTitle8.text = self.lblSubTitle5.text;
            }
        }
    }
    
    //成交量图设置线条
    //[self.stickChart setSelectedPointAddReDraw:self.candleStickChart.singleTouchPoint];
    
}

#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{
    if (self.segBottomChartType.selectedSegmentIndex == 6) {
        self.segBottomChartType.selectedSegmentIndex = 0;
    }else{
        self.segBottomChartType.selectedSegmentIndex = self.segBottomChartType.selectedSegmentIndex + 1;
    }
    
    [self segBottomChartTypeTypeValueChaged:self.segBottomChartType];
}

- (void)segBottomChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    self.lblSubTitle3.text = @"";
    self.lblSubTitle3.textColor = [UIColor blackColor];
    self.lblSubTitle4.text = @"";
    self.lblSubTitle5.textColor = [UIColor blackColor];
    self.lblSubTitle5.text = @"";
    self.lblSubTitle6.textColor = [UIColor blackColor];
    self.lblSubTitle6.text = @"";
    self.lblSubTitle6.textColor = [UIColor blackColor];
    self.lblSubTitle7.text = @"";
    self.lblSubTitle7.textColor = [UIColor blackColor];
    self.lblSubTitle8.text = @"";
    self.lblSubTitle8.textColor = [UIColor blackColor];
    self.lblSubTitle9.text = @"";
    self.lblSubTitle9.textColor = [UIColor blackColor];
    self.lblSubTitle10.text = @"";
    self.lblSubTitle10.textColor = [UIColor blackColor];
    
    // 得到每页宽度
    CGFloat pageWidth = self.scrollViewBottomChart.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int page = (int) floor((self.scrollViewBottomChart.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (segmentedControl.selectedSegmentIndex != page) {
        //滚动相应的距离
        self.scrollViewBottomChart.contentOffset = CGPointMake(pageWidth * segmentedControl.selectedSegmentIndex, self.scrollViewBottomChart.contentOffset.y);
    }
    
    self.candleStickChart.bollingerBandStyle = CCSBollingerBandStyleNone;
    
    if (0 == self.segBottomChartType.selectedSegmentIndex) {
        self.stickChart.displayFrom = self.candleStickChart.displayFrom;
        self.stickChart.displayNumber = self.candleStickChart.displayNumber;
        [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeVOL;
    } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
        self.macdChart.displayFrom = self.candleStickChart.displayFrom;;
        self.macdChart.displayNumber = self.candleStickChart.displayNumber;
        [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeMACD;
    } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
        self.kdjChart.displayFrom = self.candleStickChart.displayFrom;;
        self.kdjChart.displayNumber = self.candleStickChart.displayNumber;
        [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeKDJ;
    } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
        self.rsiChart.displayFrom = self.candleStickChart.displayFrom;;
        self.rsiChart.displayNumber = self.candleStickChart.displayNumber;
        [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeRSI;
    } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
        self.wrChart.displayFrom = self.candleStickChart.displayFrom;;
        self.wrChart.displayNumber = self.candleStickChart.displayNumber;
        [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeWR;
    } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
        self.cciChart.displayFrom = self.candleStickChart.displayFrom;;
        self.cciChart.displayNumber = self.candleStickChart.displayNumber;
        [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeCCI;
    } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
        self.bollChart.displayFrom = self.candleStickChart.displayFrom;;
        self.bollChart.displayNumber = self.candleStickChart.displayNumber;
        [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        
        self.candleStickChart.bollingerBandStyle = CCSBollingerBandStyleBand;
        self.bottomChartType = GroupChartViewTypeBOLL;
    }
    
    [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
}

/******************************************************************************
 *   Method of Chart Compute By TALib
 ******************************************************************************/

- (CCSTitledLine *)computeMAData:(NSArray *)items period:(int)period {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_MA(0,
                                  (int) (items.count - 1),
                                  inCls,
                                  period,
                                  TA_MAType_SMA,
                                  &outBegIdx,
                                  &outNBElement,
                                  outReal);
    
    NSMutableArray *maData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arr = CArrayToNSArray(outReal, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [maData addObject:[[CCSLineData alloc] initWithValue:[[arr objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inCls);
    freeAndSetNULL(outReal);
    
    CCSTitledLine *maline = [[CCSTitledLine alloc] init];
    
    if (5 == period) {
        maline.title = @"MA5";
    } else if (25 == period) {
        maline.title = @"MA25";
    }
    
    if (5 == period) {
        maline.color = [UIColor cyanColor];
    } else if (25 == period) {
        maline.color = [UIColor magentaColor];
    }
    
    maline.data = maData;
    
    return maline;
}

- (NSMutableArray *)computeMACDData:(NSArray *)items {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outMACD = malloc(sizeof(double) * items.count);
    double *outMACDSignal = malloc(sizeof(double) * items.count);
    double *outMACDHist = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_MACD(0,
                                    (int) (items.count - 1),
                                    inCls,
                                    12,
                                    26,
                                    9,
                                    &outBegIdx,
                                    &outNBElement,
                                    outMACD,
                                    outMACDSignal,
                                    outMACDHist);
    
    NSMutableArray *MACDData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        
        NSArray *arrMACDSignal = CArrayToNSArray(outMACDSignal, (int) items.count, outBegIdx, outNBElement);
        NSArray *arrMACD = CArrayToNSArray(outMACD, (int) items.count, outBegIdx, outNBElement);
        NSArray *arrMACDHist = CArrayToNSArray(outMACDHist, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            //两倍表示MACD
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [MACDData addObject:[[CCSMACDData alloc] initWithDea:[(NSString *) [arrMACDSignal objectAtIndex:index] doubleValue] * 1000000
                                                            diff:[(NSString *) [arrMACD objectAtIndex:index] doubleValue] * 1000000
                                                            macd:[(NSString *) [arrMACDHist objectAtIndex:index] doubleValue] * 2 * 1000000
                                                            date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inCls);
    freeAndSetNULL(outMACD);
    freeAndSetNULL(outMACDSignal);
    freeAndSetNULL(outMACDHist);
    
    return MACDData;
}

- (NSMutableArray *)computeKDJData:(NSArray *)items {
    NSMutableArray *arrHigval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrHigval addObject:item.high];
    }
    double *inHigval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrHigval, inHigval);
    
    NSMutableArray *arrLowval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrLowval addObject:item.low];
    }
    double *inLowval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrLowval, inLowval);
    
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outSlowK = malloc(sizeof(double) * items.count);
    double *outSlowD = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_STOCH(0,
                                     (int) (items.count - 1),
                                     inHigval,
                                     inLowval,
                                     inCls,
                                     9,
                                     3,
                                     TA_MAType_EMA,
                                     3,
                                     TA_MAType_EMA,
                                     &outBegIdx,
                                     &outNBElement,
                                     outSlowK,
                                     outSlowD);
    
    NSMutableArray *slowKLineData = [[NSMutableArray alloc] init];
    NSMutableArray *slowDLineData = [[NSMutableArray alloc] init];
    NSMutableArray *slow3K2DLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrSlowK = CArrayToNSArray(outSlowK, (int) items.count, outBegIdx, outNBElement);
        NSArray *arrSlowD = CArrayToNSArray(outSlowD, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [slowKLineData addObject:[[CCSLineData alloc] initWithValue:[[arrSlowK objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
            [slowDLineData addObject:[[CCSLineData alloc] initWithValue:[[arrSlowD objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
            
            double slowKLine3k2d = 3 * [[arrSlowK objectAtIndex:index] doubleValue] - 2 * [[arrSlowD objectAtIndex:index] doubleValue];
            [slow3K2DLineData addObject:[[CCSLineData alloc] initWithValue:slowKLine3k2d date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inHigval);
    freeAndSetNULL(inLowval);
    freeAndSetNULL(inCls);
    freeAndSetNULL(outSlowK);
    freeAndSetNULL(outSlowD);
    
    CCSTitledLine *slowKLine = [[CCSTitledLine alloc] init];
    slowKLine.data = slowKLineData;
    slowKLine.color = [UIColor redColor];
    slowKLine.title = @"K";
    
    CCSTitledLine *slowDLine = [[CCSTitledLine alloc] init];
    slowDLine.data = slowDLineData;
    slowDLine.color = [UIColor greenColor];
    slowDLine.title = @"D";
    
    CCSTitledLine *slow3K2DLine = [[CCSTitledLine alloc] init];
    slow3K2DLine.data = slow3K2DLineData;
    slow3K2DLine.color = [UIColor blueColor];
    slow3K2DLine.title = @"J";
    
    NSMutableArray *kdjData = [[NSMutableArray alloc] init];
    [kdjData addObject:slowKLine];
    [kdjData addObject:slowDLine];
    [kdjData addObject:slow3K2DLine];
    
    return kdjData;
}

- (CCSTitledLine *)computeRSIData:(NSArray *)items period:(int)period {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_RSI(0,
                                   (int) (items.count - 1),
                                   inCls,
                                   period,
                                   &outBegIdx,
                                   &outNBElement,
                                   outReal);
    
    NSMutableArray *rsiLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arr = CArrayToNSArray(outReal, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [rsiLineData addObject:[[CCSLineData alloc] initWithValue:[[arr objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inCls);
    freeAndSetNULL(outReal);
    
    CCSTitledLine *rsiLine = [[CCSTitledLine alloc] init];
    rsiLine.title = [NSString stringWithFormat:@"RSI%d", period];
    
    rsiLine.data = rsiLineData;
    
    if (6 == period) {
        rsiLine.color = [UIColor redColor];
    } else if (12 == period) {
        rsiLine.color = [UIColor greenColor];
    } else if (24 == period) {
        rsiLine.color = [UIColor blueColor];
    }
    
    return rsiLine;
}

- (NSMutableArray *)computeWRData:(NSArray *)items period:(int)period {
    NSMutableArray *arrHigval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrHigval addObject:item.high];
    }
    double *inHigval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrHigval, inHigval);
    
    NSMutableArray *arrLowval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrLowval addObject:item.low];
    }
    double *inLowval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrLowval, inLowval);
    
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_WILLR(0,
                                     (int) (items.count - 1),
                                     inHigval,
                                     inLowval,
                                     inCls,
                                     10,
                                     &outBegIdx,
                                     &outNBElement,
                                     outReal);
    
    NSMutableArray *wrLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrWR = CArrayToNSArrayWithParameter(outReal, (int) items.count, outBegIdx, outNBElement, -WR_NONE_DISPLAY);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [wrLineData addObject:[[CCSLineData alloc] initWithValue:-([[arrWR objectAtIndex:index] doubleValue]) date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    
    freeAndSetNULL(inHigval);
    freeAndSetNULL(inLowval);
    freeAndSetNULL(inCls);
    freeAndSetNULL(outReal);
    
    CCSTitledLine *wrLine = [[CCSTitledLine alloc] init];
    wrLine.data = wrLineData;
    wrLine.color = [UIColor redColor];
    wrLine.title = @"WR";
    
    NSMutableArray *wrData = [[NSMutableArray alloc] init];
    [wrData addObject:wrLine];
    
    return wrData;
}

- (NSMutableArray *)computeCCIData:(NSArray *)items period:(int)period {
    NSMutableArray *arrHigval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrHigval addObject:item.high];
    }
    double *inHigval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrHigval, inHigval);
    
    NSMutableArray *arrLowval = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrLowval addObject:item.low];
    }
    double *inLowval = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrLowval, inLowval);
    
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outReal = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_CCI(0,
                                   (int) (items.count - 1),
                                   inHigval,
                                   inLowval,
                                   inCls,
                                   period,
                                   &outBegIdx,
                                   &outNBElement,
                                   outReal);
    
    NSMutableArray *cciLineData = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrCCI = CArrayToNSArray(outReal, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [cciLineData addObject:[[CCSLineData alloc] initWithValue:[[arrCCI objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inHigval);
    freeAndSetNULL(inLowval);
    freeAndSetNULL(inCls);
    freeAndSetNULL(outReal);
    
    CCSTitledLine *cciLine = [[CCSTitledLine alloc] init];
    cciLine.data = cciLineData;
    cciLine.color = [UIColor redColor];
    cciLine.title = @"CCI";
    
    NSMutableArray *wrData = [[NSMutableArray alloc] init];
    [wrData addObject:cciLine];
    
    return wrData;
}

- (NSMutableArray *)computeBOLLData:(NSArray *)items {
    NSMutableArray *arrCls = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < items.count; index++) {
        OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
        [arrCls addObject:item.close];
    }
    double *inCls = malloc(sizeof(double) * items.count);
    NSArrayToCArray(arrCls, inCls);
    
    int outBegIdx = 0, outNBElement = 0;
    double *outRealUpperBand = malloc(sizeof(double) * items.count);
    double *outRealBollBand = malloc(sizeof(double) * items.count);
    double *outRealLowerBand = malloc(sizeof(double) * items.count);
    
    TA_RetCode ta_retCode = TA_BBANDS(0,
                                      (int) (items.count - 1),
                                      inCls,
                                      20,
                                      2,
                                      2,
                                      TA_MAType_SMA,
                                      &outBegIdx,
                                      &outNBElement,
                                      outRealUpperBand,
                                      outRealBollBand,
                                      outRealLowerBand);
    
    NSMutableArray *bollLinedataUPPER = [[NSMutableArray alloc] init];
    NSMutableArray *bollLinedataLOWER = [[NSMutableArray alloc] init];
    NSMutableArray *bollLinedataBOLL = [[NSMutableArray alloc] init];
    
    if (TA_SUCCESS == ta_retCode) {
        NSArray *arrUPPER = CArrayToNSArray(outRealUpperBand, (int) items.count, outBegIdx, outNBElement);
        NSArray *arrBOLL = CArrayToNSArray(outRealBollBand, (int) items.count, outBegIdx, outNBElement);
        NSArray *arrLOWER = CArrayToNSArray(outRealLowerBand, (int) items.count, outBegIdx, outNBElement);
        
        for (NSInteger index = 0; index < arrCls.count; index++) {
            OHLCVDGroupData *item = [items objectAtIndex:items.count - 1 - index];
            [bollLinedataUPPER addObject:[[CCSLineData alloc] initWithValue:[[arrUPPER objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
            [bollLinedataLOWER addObject:[[CCSLineData alloc] initWithValue:[[arrLOWER objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
            [bollLinedataBOLL addObject:[[CCSLineData alloc] initWithValue:[[arrBOLL objectAtIndex:index] doubleValue] date:[item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"]]];
        }
    }
    
    freeAndSetNULL(inCls);
    freeAndSetNULL(outRealUpperBand);
    freeAndSetNULL(outRealBollBand);
    freeAndSetNULL(outRealLowerBand);
    
    CCSTitledLine *bollLineUPPER = [[CCSTitledLine alloc] init];
    bollLineUPPER.data = bollLinedataUPPER;
    bollLineUPPER.color = [UIColor yellowColor];
    bollLineUPPER.title = @"UPPER";
    
    CCSTitledLine *bollLineLOWER = [[CCSTitledLine alloc] init];
    bollLineLOWER.data = bollLinedataLOWER;
    bollLineLOWER.color = [UIColor purpleColor];
    bollLineLOWER.title = @"LOWER";
    
    CCSTitledLine *bollLineBOLL = [[CCSTitledLine alloc] init];
    bollLineBOLL.data = bollLinedataBOLL;
    bollLineBOLL.color = [UIColor greenColor];
    bollLineBOLL.title = @"BOLL";
    
    NSMutableArray *bollBanddata = [[NSMutableArray alloc] init];
    
    [bollBanddata addObject:bollLineUPPER];
    [bollBanddata addObject:bollLineLOWER];
    [bollBanddata addObject:bollLineBOLL];
    
    return bollBanddata;
}

/*******************************************************************************
* Unused Codes
*******************************************************************************/

@end
