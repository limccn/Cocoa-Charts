//
//  CCSSampleGroupChartDemoViewController.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSampleGroupChartDemoViewController.h"

#define AXIS_CALC_PARM  1000

#import "CCSAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

#import "CCSStringUtils.h"
#import "CCSJSONData.h"

/**
 * 屏幕宽高
 */
#define VIEW_SIZE                self.view.bounds.size

typedef enum {
    Chart1minData = 0,
    Chart15minData = 1,
    ChartTimesData = 2
} ChartDataType;

@interface CCSSampleGroupChartDemoViewController (){
    NSMutableArray                                  *_chartData;
    
    CCSAreaChart                                    *_areachart;
}

@end

@implementation CCSSampleGroupChartDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    // 延迟操作执行的代码
    [self loadJSONData:Chart15minData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    [self.segTopChartType addTarget:self action:@selector(segTopChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    [self.segTopChartType setSelectedSegmentIndex:1];
    
    [_groupChart setChartDelegate:self];
    
    [self initAreaChart];
}

- (void)initAreaChart{
    NSMutableArray *linedata = [[NSMutableArray alloc] init];
    
    CCSJSONData *jsonData = [[CCSJSONData alloc] initWithData:[[self findJSONStringWithName:@"1min"] dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    
    NSArray *arrData = nil;
    if (jsonData.kqn !=nil) {
        arrData = jsonData.kqn;
    }else if (jsonData.ct !=nil){
        arrData = jsonData.ct;
    }else if (jsonData.ctt !=nil){
        arrData = jsonData.ctt;
    }
    
    NSMutableArray *singlelinedata = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in arrData) {
        @try {
            [singlelinedata addObject: [[CCSLineData alloc] initWithValue:[dic[@"o"] doubleValue] * AXIS_CALC_PARM date:[NSString stringWithFormat:@"%@", [dic[@"pt"] dateWithFormat:@"yyyy-MM-ddHH: mm: ss" target:@"HH:mm"]]]];
        }
        @catch (NSException *exception) {
            continue;
        }
        @finally {
        }
    }
    
    CCSTitledLine *singleline = [[CCSTitledLine alloc] init];
    singleline.data = singlelinedata;
    singleline.color = [UIColor purpleColor];
    singleline.title = @"chartLine2";
    
    [linedata addObject:singleline];
    
    _areachart = [[CCSAreaChart alloc] initWithFrame:CGRectMake(8.0f, MARGIN_TOP + 44.0f, VIEW_SIZE.width - 16.0f, 333.0f)];
    _areachart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _areachart.linesData = linedata;
    _areachart.lineWidth = 1.0f;
    _areachart.maxValue = 150000;
    _areachart.minValue = 100000;
    _areachart.longitudeNum = 4;
    _areachart.latitudeNum = 4;
    _areachart.backgroundColor = [UIColor clearColor];
    _areachart.areaAlpha = 0.2;
    
    [_areachart setHidden:YES];
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    
    for (CCSLineData *lineData in singlelinedata){
        [TitleX addObject:lineData.date];
    }
    
    _areachart.longitudeTitles = TitleX;
    
    [self.view addSubview:_areachart];
}

- (void)loadJSONData: (ChartDataType) chartDataType{
    // when 时间 从现在开始经过多少纳秒
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
    // 经过多少纳秒，由主队列调度任务异步执行
    dispatch_after(when, dispatch_get_main_queue(), ^{
        [self loadData:chartDataType];
    });
}

- (void)loadData: (ChartDataType) chartDataType{
//    NSString *strAllPdts = [self findJSONStringWithName:@"allpdts"];
    
    CCSJSONData *jsonData = nil;
    
    if (chartDataType == Chart1minData) {
        jsonData = [[CCSJSONData alloc] initWithData:[[self findJSONStringWithName:@"1min"] dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    }else if (chartDataType == Chart15minData){
        jsonData = [[CCSJSONData alloc] initWithData:[[self findJSONStringWithName:@"15min"] dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    }else{
        jsonData = [[CCSJSONData alloc] initWithData:[[self findJSONStringWithName:@"time"] dataUsingEncoding:NSUTF8StringEncoding] error:nil];
    }
    
    NSArray *arrData = nil;
    if (jsonData.kqn !=nil) {
        arrData = jsonData.kqn;
    }else if (jsonData.ct !=nil){
        arrData = jsonData.ct;
    }else if (jsonData.ctt !=nil){
        arrData = jsonData.ctt;
    }
    
    if (_chartData == nil) {
        _chartData = [[NSMutableArray alloc] init];
    }
    
    //    data.open = [dict objectForKey:@"openPrice"];
    //    data.high = [dict objectForKey:@"upPrice"];
    //    data.low = [dict objectForKey:@"lowPrice"];
    //    data.close = [dict objectForKey:@"closePrice"];
    //    data.vol = [dict objectForKey:@"totalNum"];
    //    data.date = [dict objectForKey:@"tradeDate"];
    //    data.current = [dict objectForKey:@"currentPrice"];
    //    data.preclose = nil;
    //    data.change = [dict objectForKey:@"changesPercent"];
    for (NSDictionary *dict in arrData) {
        if (dict != nil) {
            OHLCVDGroupData *data = [[OHLCVDGroupData alloc] init];
            
            data.open = [dict objectForKey:@"o"];
            data.high = [dict objectForKey:@"h"];
            data.low = [dict objectForKey:@"l"];
            data.close = [dict objectForKey:@"c"];
            data.vol = [dict objectForKey:@"tr"];
            data.date = [dict objectForKey:@"qt"];
            data.current = [dict objectForKey:@"n"];
            data.preclose = nil;
            data.change = [dict objectForKey:@"changesPercent"];
            [_chartData addObject:data];
        }
    }
    
    [self dataPreProcess];
}

- (void) dataPreProcess{
    if (_chartData == nil) {
        return;
    }
    
    for (int i=0; i< [_chartData count];  i++) {
        OHLCVDGroupData *data = _chartData[i];
        data.open = [NSString stringWithFormat:@"%f",[data.open doubleValue] * AXIS_CALC_PARM];
        data.high = [NSString stringWithFormat:@"%f",[data.high doubleValue] * AXIS_CALC_PARM];
        data.low = [NSString stringWithFormat:@"%f",[data.low doubleValue] * AXIS_CALC_PARM];
        data.close = [NSString stringWithFormat:@"%f",[data.close doubleValue] * AXIS_CALC_PARM];
    }
    [_groupChart setChartData:_chartData];
}

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index{
    [_groupChart CCSChartBeTouchedOn:chart point:point indexAt:index];
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number{
    [_groupChart CCSChartDisplayChangedFrom:chart from:from number:number];
}

- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        [_areachart setHidden:NO];
        [self.groupChart setHidden:YES];
    }else if (segmentedControl.selectedSegmentIndex == 1){
        [_areachart setHidden:YES];
        [self.groupChart setHidden:NO];
        [self loadJSONData:Chart15minData];
    }else if (segmentedControl.selectedSegmentIndex == 2){
        [_areachart setHidden:YES];
        [self.groupChart setHidden:NO];
        [self loadJSONData:Chart1minData];
    }else{
        [_areachart setHidden:YES];
        [self.groupChart setHidden:NO];
        [self loadJSONData:ChartTimesData];
    }
}

- (NSString *)findJSONStringWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    //UTF-8编码
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

@end
