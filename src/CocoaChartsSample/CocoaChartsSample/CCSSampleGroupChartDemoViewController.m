//
//  CCSSampleGroupChartDemoViewController.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSampleGroupChartDemoViewController.h"

#import "CCSChartsSettingViewController.h"

#import "CCSSamplGroupChartDetailTableViewCell.h"

#import "CCSAppDelegate.h"

#define AXIS_CALC_PARM  1000

#import "CCSAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

#import "NSArray+CCSTACompute.h"
#import "CCSStringUtils.h"
#import "NSString+UserDefault.h"
#import "NSString+UIColor.h"

#define MIN_CHART_LEFT_RIGHT_SCALE                  3.0f

#define VIEW_SIZE                                   self.view.bounds.size

/** 精选 Cell */
static NSString *DetailCellIdentifier             = @"CCSSamplGroupChartDetailTableViewCell";

typedef enum {
    Chart1minData = 0,
    Chart15minData = 1,
    ChartTimesData = 2
} ChartDataType;

@interface CCSSampleGroupChartDemoViewController (){
    CCSGroupChartData                               *_dayData;
}

- (void)loadJSONData: (ChartDataType) chartDataType;

- (void)loadKLineData: (ChartDataType) chartDataType;

- (void)loadTickData;

@end

@implementation CCSSampleGroupChartDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initAreaChart];
    
    // 延迟操作执行的代码
    [self loadJSONData:Chart15minData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self.areachart setHidden:NO];
        [self.groupChart setHidden:YES];
        
        [self loadTickData];
    }else if (segmentedControl.selectedSegmentIndex == 1) {
        [self.areachart setHidden:YES];
        [self.groupChart setHidden:NO];
        
        if (!_dayData) {
            [self loadJSONData:Chart15minData];
        }else{
            [self.groupChart setGroupChartData:_dayData];
        }
    }else{
    }
}

/*******************************************************************************
 * Implements Of CCSChartDelegate
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(CCUInt)index{
    [_groupChart CCSChartBeTouchedOn:chart point:point indexAt:index];
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(CCUInt)from number:(CCUInt)number{
    [_groupChart CCSChartDisplayChangedFrom:chart from:from number:number];
}

- (void)initView{
    [self.segTopChartType addTarget:self action:@selector(segTopChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    [self.segTopChartType setSelectedSegmentIndex:1];
    
    // 设置颜色
    self.segTopChartType.tintColor = [UIColor whiteColor];
    [self.segTopChartType setBackgroundColor:[UIColor whiteColor]];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                             NSForegroundColorAttributeName: [@"#323232" str2Color]};
    // 设置文字属性
    [self.segTopChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                               NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    [self.segTopChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [_groupChart setChartDelegate:self];
    [_groupChart setChartsBackgroundColor:[@"F5F5F5" str2Color]];
    [_groupChart setSetting:^{
        CCSChartsSettingViewController *ctrlSetting = [[CCSChartsSettingViewController alloc] init];
        ctrlSetting.ctrlChart = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctrlSetting];
        [self presentViewController:navigationController animated:YES completion:^{
        }];
    }];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [self.lblTime setText:currentDateStr];
}

- (void)initAreaChart{
    [self.areachart setBackgroundColor:[@"F5F5F5" str2Color]];
    
    self.areachart.lineWidth = 0.5f;
    self.areachart.maxValue = 150000;
    self.areachart.minValue = 100000;
    self.areachart.longitudeNum = 4;
    self.areachart.latitudeNum = 4;
    self.areachart.areaAlpha = 0.2;
}

- (void)loadJSONData: (ChartDataType) chartDataType{
    DO_IN_BACKGROUND(^{
        [self loadKLineData:chartDataType];
    });
}

- (void)loadKLineData: (ChartDataType) chartDataType{
    // 读取JSON
    NSString *jsonString = [@"KLineData" findJSONStringWithType:@"txt"];
    // 解析
    NSDictionary *dicKLineData = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:kNilOptions
                                                                   error:nil];
    
    NSArray *arrNativeData = dicKLineData[@"kLine"];
    
    arrNativeData = [[arrNativeData reverseObjectEnumerator] allObjects];
    
    NSMutableArray *ohlcdDatas = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arrNativeData) {
        if (dict != nil) {
            CCSOHLCVDData *data = [[CCSOHLCVDData alloc] init];
            
            data.open = [[dict objectForKey:@"open"] doubleValue] * AXIS_CALC_PARM;
            data.high = [[dict objectForKey:@"high"] doubleValue] * AXIS_CALC_PARM;
            data.low = [[dict objectForKey:@"low"] doubleValue] * AXIS_CALC_PARM;
            data.close = [[dict objectForKey:@"close"] doubleValue]* AXIS_CALC_PARM;
            data.vol = [[dict objectForKey:@"volume"] doubleValue];
            data.date = [dict objectForKey:@"day"];
            data.current = [[dict objectForKey:@"close"] doubleValue];
            data.preclose = 0;
            data.change = 0;
            [ohlcdDatas addObject:data];
        }
    }
    
    DO_IN_MAIN_QUEUE(^{
        [self setDayData:ohlcdDatas];
    });
}

- (void)loadTickData{
    DO_IN_BACKGROUND(^{
        // 读取JSON
        NSString *jsonString = [@"Tick" findJSONStringWithType:@"txt"];
        // 解析
        NSDictionary *dicTickData = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:kNilOptions
                                                                      error:nil];
        
        NSArray *arrNativeData = dicTickData[@"tick"];
        
        arrNativeData = [[arrNativeData reverseObjectEnumerator] allObjects];
        
        [self minsDataProcess:arrNativeData];
    });
}

- (void)minsDataProcess:(NSArray *)arrData{
    NSMutableArray *linedata = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dicMinsData = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dic in arrData) {
        [dicMinsData setObject:dic[@"o"] forKey:[NSString stringWithFormat:@"%@", [dic[@"pt"] dateWithFormat:@"yyyy-MM-ddHH: mm: ss" target:@"HH:mm"]]];
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"00"];
    
    NSMutableArray *arrMinsLineData = [[NSMutableArray alloc] init];
    for (int i=1; i<=60*24; i++) {
        int hour = i/60;
        int min = i - hour*60;
        
        NSString *time = [NSString stringWithFormat:@"%@:%@", [numberFormatter stringFromNumber:[NSNumber numberWithInt:hour]], [numberFormatter stringFromNumber:[NSNumber numberWithInt:min]]];
        
        double open = 4310.0;
        if (dicMinsData[time]) {
            open = [dicMinsData[time] doubleValue];
        }
        
        [arrMinsLineData addObject:[[CCSLineData alloc] initWithValue:open * AXIS_CALC_PARM date: time]];
    }
    
    CCSTitledLine *singleline = [[CCSTitledLine alloc] init];
    singleline.data = arrMinsLineData;
    singleline.color = LINE_COLORS[2];
    singleline.title = @"chartLine";
    
    [linedata addObject:singleline];
    
    _areachart.linesData = linedata;
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    
    for (CCSLineData *lineData in arrMinsLineData){
        [TitleX addObject:lineData.date];
    }
    
    self.areachart.longitudeTitles = TitleX;
    
    DO_IN_MAIN_QUEUE(^{
        [_areachart setNeedsDisplay];
    });
}

- (void)updateChartsWithIndicatorType:(IndicatorType) indicatorType{
    if (indicatorType == IndicatorMACD) {
        [_dayData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        
        [self.groupChart updateMACDChart];
    }else if (indicatorType == IndicatorMA){
        [_dayData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        
        [self.groupChart updateCandleStickChart];
    }else if (indicatorType == IndicatorKDJ){
        [_dayData updateKDJData:self.kdjN];
        
        [self.groupChart updateKDJChart];
    }else if (indicatorType == IndicatorRSI){
        [_dayData updateRSIData:self.rsiN1 n2:self.rsiN2];
        
        [self.groupChart updateRSIChart];
    }else if (indicatorType == IndicatorWR){
        [_dayData updateWRData:self.wrN];
        
        [self.groupChart updateWRChart];
    }else if (indicatorType == IndicatorCCI){
        [_dayData updateCCIData:self.cciN];
        
        [self.groupChart updateCCIChart];
    }else if (indicatorType == IndicatorBOLL){
        [_dayData updateBOLLData:self.bollN];
        [_dayData updateCandleStickBollingerBandData:self.bollN];
        
        [self.groupChart updateCandleStickChart];
        [self.groupChart updateBOLLChart];
    }
}

/*******************************************************************************
 * setter
 *******************************************************************************/

/**
 * 设置日数据
 */
- (void)setDayData:(NSArray *) ohlcvDatas{
    _dayData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:_dayData];
}

/**
 * 设置周数据
 */
- (void)setWeekData:(NSArray *) ohlcvDatas{
    _dayData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:_dayData];
}

@end
