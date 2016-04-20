//
//  CCSSampleGroupChartDemoViewController.m
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSampleGroupChartDemoViewController.h"

#import "CCSChartsSettingViewController.h"

#import "CCSSamplGroupChartDetailTableViewCell.h"

#import "CCSAppDelegate.h"
#import "CCSSampleHorizontalViewController.h"

#define AXIS_CALC_PARM  1000

#import "CCSAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

#import "NSArray+CCSTACompute.h"
#import "CCSStringUtils.h"
#import "NSString+UserDefault.h"
#import "CCSJSONData.h"

#define MIN_CHART_LEFT_RIGHT_SCALE                  3.0f

#define VIEW_SIZE                                   self.view.bounds.size

/** 精选 Cell */
static NSString *DetailCellIdentifier             = @"CCSSamplGroupChartDetailTableViewCell";

//typedef enum {
//    Chart1minData = 0,
//    Chart15minData = 1,
//    ChartTimesData = 2
//} ChartDataType;

@interface CCSSampleGroupChartDemoViewController (){
    NSMutableArray                                  *_chartData;
    
    UIView                                          *_vMinsChartContainer;
    CCSAreaChart                                    *_areachart;
    
    /** 盘口 */
    UIView                                          *_vHandicap;
    /** 明细 */
    UIView                                          *_vDetail;
    /** 明细 */
    UITableView                                     *_tbDetail;
    NSArray                                         *_detailData;
}

- (void)loadJSONData: (ChartDataType) chartDataType;

- (void)loadTickData;

@end

@implementation CCSSampleGroupChartDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    // 延迟操作执行的代码
    [self loadJSONData:Chart15minData];
}

- (void)viewDidLayoutSubviews{
    [self initAreaChart];
    
    [self initHandicap];
    
    [self initDetail];
    
    [self initKMins];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)minutesTouchUpInside:(id)sender{
    UIButton *btnMinutes = sender;
    [btnMinutes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.segTopChartType setSelectedSegmentIndex:6];
    
    [self showKMinsMenu];
}

- (IBAction)selectMinutesKChartTouchUpInside:(id)sender{
    UIView *view = sender;
    
    [self showKLineChartsWithMinutes:view.tag];
    [self showKMinsMenu];
}

- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    [self.btnMinutes setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:NO];
        [_vDetail setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
    }else if (segmentedControl.selectedSegmentIndex == 1) {
        [_vMinsChartContainer setHidden:NO];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (self.arrayTickData) {
            _areachart.linesData = self.arrayTickData;
            [_areachart setNeedsDisplay];
        }else{
            [self loadTickData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 2) {
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:NO];
        [self.groupChart setHidden:YES];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
    }else if (segmentedControl.selectedSegmentIndex == 3){
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chartDayData) {
            [self loadJSONData:Chart15minData];
        }else{
            [self.groupChart setGroupChartData:self.chartDayData];
        }
    }else if (segmentedControl.selectedSegmentIndex == 4){
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [self.groupChart setHidden:NO];
        if (self.vMinsContainer.alpha > 0.0f) {
            [self showKMinsMenu];
        }
        
        if (!self.chartWeekData) {
            [self loadJSONData:Chart1minData];
        }else{
            [self.groupChart setGroupChartData:self.chartWeekData];
        }
    }else{
    }
}

- (void)initView{
    [self.segTopChartType addTarget:self action:@selector(segTopChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    [self.segTopChartType setSelectedSegmentIndex:3];
    
    // 设置颜色
    self.segTopChartType.tintColor = [UIColor blackColor];
    [self.segTopChartType setBackgroundColor:[UIColor blackColor]];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    // 设置文字属性
    [self.segTopChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                               NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    [self.segTopChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [_groupChart setChartDelegate:self];
    [_groupChart setChartsBackgroundColor:[UIColor blackColor]];
    [_groupChart setSetting:^{
        CCSChartsSettingViewController *ctrlSetting = [[CCSChartsSettingViewController alloc] init];
        ctrlSetting.ctrlChart = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctrlSetting];
        [self presentViewController:navigationController animated:YES completion:^{
        }];
    }];
    
    [self.btnHorizontal addTarget:self action:@selector(horizontal:) forControlEvents:UIControlEventTouchUpInside];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [self.lblTime setText:currentDateStr];
}

- (void)initAreaChart{
    if (_vMinsChartContainer) {
        return;
    }
    _vMinsChartContainer = [[UIView alloc] init];
    [_vMinsChartContainer setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    [_vMinsChartContainer setHidden:YES];
    [self.view addSubview:_vMinsChartContainer];
    
    _areachart = [[CCSAreaChart alloc] init];
    [_areachart setFrame:CGRectMake(0.0f, 0.0f, _vMinsChartContainer.frame.size.width - _vMinsChartContainer.frame.size.width/MIN_CHART_LEFT_RIGHT_SCALE, _vMinsChartContainer.frame.size.height)];
    _areachart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _areachart.lineWidth = 1.0f;
    _areachart.maxValue = 150000;
    _areachart.minValue = 100000;
    _areachart.longitudeNum = 4;
    _areachart.latitudeNum = 4;
    _areachart.areaAlpha = 0.2;
    [_areachart setBackgroundColor:[UIColor blackColor]];
    
    [_vMinsChartContainer addSubview:_areachart];
    
    UIView *vTrade = [[UIView alloc] init];
    [vTrade setFrame:CGRectMake(VIEW_SIZE.width - VIEW_SIZE.width/MIN_CHART_LEFT_RIGHT_SCALE, _areachart.frame.origin.y, VIEW_SIZE.width/MIN_CHART_LEFT_RIGHT_SCALE, _areachart.frame.size.height)];
    [_vMinsChartContainer addSubview:vTrade];
    
    CGFloat tradeHeight = -12.0f;
    
    NSMutableArray *arrUISellingPrices = [[NSMutableArray alloc] init];
    NSMutableArray *arrUISellingCounts = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIView *vSellingContainer = [[UIView alloc] init];
        [vSellingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 30.0f)];
        [vTrade addSubview:vSellingContainer];
        
        UILabel *lblSelling = [[UILabel alloc] init];
        [lblSelling setFrame:CGRectMake(0.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [lblSelling setTextAlignment:NSTextAlignmentCenter];
        [lblSelling setTextColor:[UIColor lightGrayColor]];
        [lblSelling setFont:[UIFont systemFontOfSize:12.0f]];
        [lblSelling setText:@"09:36"];
        [vSellingContainer addSubview:lblSelling];
        
        UIButton *btnSelling = [[UIButton alloc] init];
        [btnSelling setFrame:CGRectMake(vSellingContainer.frame.size.width/3.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [btnSelling.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [btnSelling setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnSelling setTitle:[NSString stringWithFormat:@"%d", 3030] forState:UIControlStateNormal];
        [vSellingContainer addSubview:btnSelling];
        [arrUISellingPrices addObject:btnSelling];
        
        UILabel *lblSellingCount = [[UILabel alloc] init];
        [lblSellingCount setFrame:CGRectMake(vSellingContainer.frame.size.width/3.0f*2.0f, 0.0f, vSellingContainer.frame.size.width/3.0f, vSellingContainer.frame.size.height)];
        [lblSellingCount setTextAlignment:NSTextAlignmentCenter];
        [lblSellingCount setTextColor:[UIColor lightGrayColor]];
        [lblSellingCount setFont:[UIFont systemFontOfSize:12.0f]];
        [lblSellingCount setText:[NSString stringWithFormat:@"%d", 3]];
        [vSellingContainer addSubview:lblSellingCount];
        [arrUISellingCounts addObject:lblSellingCount];
        
        tradeHeight += vSellingContainer.frame.size.height;
    }
    
    UIView *vCenterLine = [[UIView alloc] init];
    [vCenterLine setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 0.5f)];
    [vCenterLine setBackgroundColor:[UIColor lightGrayColor]];
    [vCenterLine setAlpha:0.3f];
    [vTrade addSubview:vCenterLine];
    
    NSMutableArray *arrUIBuyingPrices = [[NSMutableArray alloc] init];
    NSMutableArray *arrUIBuyingCounts = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIView *vBuyingContainer = [[UIView alloc] init];
        [vBuyingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 30.0f)];
        [vTrade addSubview:vBuyingContainer];
        
        UILabel *lblBuying = [[UILabel alloc] init];
        [lblBuying setFrame:CGRectMake(0.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [lblBuying setTextAlignment:NSTextAlignmentCenter];
        [lblBuying setTextColor:[UIColor lightGrayColor]];
        [lblBuying setFont:[UIFont systemFontOfSize:12.0f]];
        [lblBuying setText:@"09:36"];
        [vBuyingContainer addSubview:lblBuying];
        
        UIButton *btnBuying = [[UIButton alloc] init];
        [btnBuying setFrame:CGRectMake(vBuyingContainer.frame.size.width/3.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [btnBuying.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [btnBuying setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnBuying setTitle:[NSString stringWithFormat:@"%d", 3030] forState:UIControlStateNormal];
        [vBuyingContainer addSubview:btnBuying];
        [arrUIBuyingPrices addObject:btnBuying];
        
        UILabel *lblBuyingCount = [[UILabel alloc] init];
        [lblBuyingCount setFrame:CGRectMake(vBuyingContainer.frame.size.width/3.0f*2.0f, 0.0f, vBuyingContainer.frame.size.width/3.0f, vBuyingContainer.frame.size.height)];
        [lblBuyingCount setTextAlignment:NSTextAlignmentCenter];
        [lblBuyingCount setTextColor:[UIColor lightGrayColor]];
        [lblBuyingCount setFont:[UIFont systemFontOfSize:12.0f]];
        [lblBuyingCount setText:[NSString stringWithFormat:@"%d", 3]];
        [vBuyingContainer addSubview:lblBuyingCount];
        [arrUIBuyingCounts addObject:lblBuyingCount];
        
        tradeHeight += vBuyingContainer.frame.size.height;
    }
}

- (void)initHandicap{
    if (_vHandicap) {
        return;
    }
    _vHandicap = [[UIView alloc] init];
    [_vHandicap setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    [_vHandicap setHidden:YES];
    [self.view addSubview:_vHandicap];
    
    CGFloat handicapHeight = 11.0f;
    
    NSMutableArray *arrhandicapsLeftValue = [[NSMutableArray alloc] init];
    NSMutableArray *arrhandicapsRightValue = [[NSMutableArray alloc] init];
    
    CGFloat marginLeft = 30.0f;
    CGFloat marginRight = 60.0f;
    
    for (int i=0; i<7; i++) {
        UIView *vHandicapContainer = [[UIView alloc] init];
        [vHandicapContainer setFrame:CGRectMake(0.0f, handicapHeight, _vHandicap.frame.size.width, 44.0f)];
        [_vHandicap addSubview:vHandicapContainer];
        
        UILabel *lblLeftLabel = [[UILabel alloc] init];
        [lblLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 50.0f, vHandicapContainer.frame.size.height)];
        [lblLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapContainer addSubview:lblLeftLabel];
        
        UILabel *lblLeftValue = [[UILabel alloc] init];
        [lblLeftValue setFrame:CGRectMake(marginLeft + lblLeftLabel.frame.size.width, 0.0f, 50.0f, vHandicapContainer.frame.size.height)];
        [lblLeftValue setTextAlignment:NSTextAlignmentCenter];
        [lblLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapContainer addSubview:lblLeftValue];
        
        [arrhandicapsLeftValue addObject:lblLeftValue];
        
        UILabel *lblRightLabel = [[UILabel alloc] init];
        [lblRightLabel setFrame:CGRectMake(vHandicapContainer.frame.size.width - marginRight - lblLeftLabel.frame.size.width - lblLeftValue.frame.size.width, 0.0f, lblLeftLabel.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapContainer addSubview:lblRightLabel];
        
        UILabel *lblRightValue = [[UILabel alloc] init];
        [lblRightValue setFrame:CGRectMake(marginLeft + lblRightLabel.frame.size.width + lblRightLabel.frame.origin.x, 0.0f, lblLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightValue setTextAlignment:NSTextAlignmentCenter];
        [lblRightValue setTextColor:[UIColor lightGrayColor]];
        [lblRightValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapContainer addSubview:lblRightValue];
        
        [arrhandicapsRightValue addObject:lblRightValue];
        
        switch (i) {
            case 0:
                [lblLeftLabel setText:@"卖价"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"卖量"];
                [lblRightValue setText:@"2"];
                break;
            case 1:
                [lblLeftLabel setText:@"买价"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"买量"];
                [lblRightValue setText:@"1"];
                break;
            case 2:
                [lblLeftLabel setText:@"最新"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"涨跌"];
                [lblRightValue setText:@"11"];
                break;
            case 3:
                [lblLeftLabel setText:@"最高"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"最低"];
                [lblRightValue setText:@"3559"];
                break;
            case 4:
                [lblLeftLabel setText:@"开盘"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"总量"];
                [lblRightValue setText:@"3559"];
                break;
            case 5:
                [lblLeftLabel setText:@"昨收"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"总额"];
                [lblRightValue setText:@"3559"];
                break;
            case 6:
                [lblLeftLabel setText:@"昨结"];
                [lblLeftValue setText:@"3559"];
                [lblRightLabel setText:@"持货"];
                [lblRightValue setText:@"3559"];
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
    
    _detailData = @[@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"},@{@"time":@"14:02:53",@"price":@"2742",@"count":@"10"}];
    
    _vDetail = [[UIView alloc] init];
    [_vDetail setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    [_vDetail setHidden:YES];
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
    [_tbDetail setBackgroundColor:[UIColor blackColor]];
    // scrollbar 不显示
    _tbDetail.showsVerticalScrollIndicator = NO;
    _tbDetail.bounces = NO;
    
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

- (void)loadJSONData: (ChartDataType) chartDataType{
    // when 时间 从现在开始经过多少纳秒
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
    // 经过多少纳秒，由主队列调度任务异步执行
    dispatch_after(when, dispatch_get_main_queue(), ^{
        [self loadData:chartDataType];
    });
}

- (void)loadData: (ChartDataType) chartDataType{
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
    
    arrData = [[arrData reverseObjectEnumerator] allObjects];;
    
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
            CCSOHLCVDData *data = [[CCSOHLCVDData alloc] init];
            
            data.open = [dict objectForKey:@"o"];
            data.high = [dict objectForKey:@"h"];
            data.low = [dict objectForKey:@"l"];
            data.close = [dict objectForKey:@"c"];
            data.vol = [dict objectForKey:@"tr"];
            data.date = [dict objectForKey:@"qt"];
            data.current = [dict objectForKey:@"c"];
            data.preclose = nil;
            data.change = [dict objectForKey:@"changesPercent"];
            [_chartData addObject:data];
        }
    }
    
    [self dataPreProcess];
    
    if (chartDataType == Chart1minData) {
        [self setWeekData:_chartData];
    }else if (chartDataType == Chart15minData){
        [self setDayData:_chartData];
    }else{
        [self setMonthData:_chartData];
    }
}

- (void)dataPreProcess{
    if (_chartData == nil) {
        return;
    }
    
    for (int i=0; i< [_chartData count];  i++) {
        CCSOHLCVDData *data = _chartData[i];
        data.open = [NSString stringWithFormat:@"%f",[data.open doubleValue] * AXIS_CALC_PARM];
        data.high = [NSString stringWithFormat:@"%f",[data.high doubleValue] * AXIS_CALC_PARM];
        data.low = [NSString stringWithFormat:@"%f",[data.low doubleValue] * AXIS_CALC_PARM];
        data.close = [NSString stringWithFormat:@"%f",[data.close doubleValue] * AXIS_CALC_PARM];
    }
}

- (void)loadTickData{
    // when 时间 从现在开始经过多少纳秒
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
    // 经过多少纳秒，由主队列调度任务异步执行
    dispatch_after(when, dispatch_get_main_queue(), ^{
        CCSJSONData *jsonData = nil;
        
        jsonData = [[CCSJSONData alloc] initWithData:[[self findJSONStringWithName:@"time"] dataUsingEncoding:NSUTF8StringEncoding] error:nil];
        
        NSArray *arrData = nil;
        if (jsonData.kqn !=nil) {
            arrData = jsonData.kqn;
        }else if (jsonData.ct !=nil){
            arrData = jsonData.ct;
        }else if (jsonData.ctt !=nil){
            arrData = jsonData.ctt;
        }
        
        [self minsDataProcess:arrData];
    });
}

- (void)minsDataProcess:(NSArray *)arrData{
    NSMutableArray *linedata = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dicMinsData = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dic in arrData) {
//        [dicMinsData setObject:dic[@"o"] forKey:[NSString stringWithFormat:@"%@", [dic[@"pt"] dateWithFormat:@"yyyy-MM-dd HH:mm:ssyyyy-MM-dd HH:mm:ss" target:@"HH:mm"]]];
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
    singleline.color = [UIColor purpleColor];
    singleline.title = @"chartLine";
    
    [linedata addObject:singleline];
    
    _areachart.linesData = linedata;
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    
    for (CCSLineData *lineData in arrMinsLineData){
        [TitleX addObject:lineData.date];
    }
    
    _areachart.longitudeTitles = TitleX;
    
    [_areachart setNeedsDisplay];
    
    [self setTickData:linedata];
}

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(CCUInt)index{
    [_groupChart CCSChartBeTouchedOn:chart point:point indexAt:index];
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(CCUInt)from number:(CCUInt)number{
    [_groupChart CCSChartDisplayChangedFrom:chart from:from number:number];
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
    CCSSamplGroupChartDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier forIndexPath:indexPath];
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
    
}

- (void)updateChartsWithIndicatorType:(IndicatorType) indicatorType{
    if (indicatorType == IndicatorMACD) {
        [self.chartDayData updateMACDStickData:self.macdS l:self.macdL m:self.macdM];
        
        [self.groupChart updateMACDChart];
    }else if (indicatorType == IndicatorMA){
        [self.chartDayData updateCandleStickLinesData:self.ma1 ma2:self.ma2 ma3:self.ma3];
        
        [self.groupChart updateCandleStickChart];
    }else if (indicatorType == IndicatorKDJ){
        [self.chartDayData updateKDJData:self.kdjN];
        
        [self.groupChart updateKDJChart];
    }else if (indicatorType == IndicatorRSI){
        [self.chartDayData updateRSIData:self.rsiN1 n2:self.rsiN2];
        
        [self.groupChart updateRSIChart];
    }else if (indicatorType == IndicatorWR){
        [self.chartDayData updateWRData:self.wrN];
        
        [self.groupChart updateWRChart];
    }else if (indicatorType == IndicatorCCI){
        [self.chartDayData updateCCIData:self.cciN];
        
        [self.groupChart updateCCIChart];
    }else if (indicatorType == IndicatorBOLL){
        [self.chartDayData updateBOLLData:self.bollN];
        [self.chartDayData updateCandleStickBollingerBandData:self.bollN];
        
        [self.groupChart updateCandleStickChart];
        [self.groupChart updateBOLLChart];
    }
}

- (void)horizontal:(UIButton *) sender{
    CCSAppDelegate *appDelegate = (CCSAppDelegate *) [UIApplication sharedApplication].delegate;
    UINavigationController *navigationController = (UINavigationController *) appDelegate.viewController;
    [navigationController pushViewController:[[CCSSampleHorizontalViewController alloc] init] animated:YES];
}

- (NSString *)findJSONStringWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    //UTF-8编码
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

/*******************************************************************************
 * setter
 *******************************************************************************/

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
    self.chartDayData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartDayData];
}

/**
 * 设置周数据
 */
- (void)setWeekData:(NSArray *) ohlcvDatas{
    self.chartWeekData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartWeekData];
}

/**
 * 设置月数据
 */
- (void)setMonthData:(NSArray *) ohlcvDatas{
    self.chartMonthData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置1分钟数据
 */
- (void)set1minData:(NSArray *) ohlcvDatas{
    self.chart1MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置5分钟数据
 */
- (void)set5minData:(NSArray *) ohlcvDatas{
    self.chart5MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置15分钟数据
 */
- (void)set15minData:(NSArray *) ohlcvDatas{
    self.chart15MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置30分钟数据
 */
- (void)set30minData:(NSArray *) ohlcvDatas{
    self.chart30MinData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置1小时数据
 */
- (void)set1HourData:(NSArray *) ohlcvDatas{
    self.chart1HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置2小时数据
 */
- (void)set2HourData:(NSArray *) ohlcvDatas{
    self.chart2HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

/**
 * 设置4小时数据
 */
- (void)set4HourData:(NSArray *) ohlcvDatas{
    self.chart4HourData = [[CCSGroupChartData alloc] initWithCCSOHLCVDDatas:ohlcvDatas];
    
    [self.groupChart setGroupChartData:self.chartMonthData];
}

@end
