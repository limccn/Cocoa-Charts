//
//  CCSSampleHorizontalViewController.m
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/3/27.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSampleHorizontalViewController.h"

#import "CCSSamplGroupChartDetailTableViewCell.h"

#define AXIS_CALC_PARM  1000

#import "CCSAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

#import "CCSOHLCVDData.h"
#import "CCSJSONData.h"

#import "CCSStringUtils.h"

#define MAIN_SCREEN_SIZE                            [[UIScreen mainScreen] bounds].size
#define VIEW_SIZE                                   self.view.bounds.size

#define MIN_CHART_LEFT_RIGHT_SCALE                  5.5f

#define WR_NONE_DISPLAY 101

#define AXIS_CALC_PARM  1000

#define DISPLAY_NUMBER 80

#define NO_NAVIGATION_MARGIN_TOP ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.9 ? 33.0f:0)

/** 精选 Cell */
static NSString *DetailCellIdentifier             = @"CCSSamplGroupChartDetailTableViewCell";

typedef enum {
    Chart1minData = 0,
    Chart15minData = 1,
    ChartTimesData = 2
} ChartDataType;

@interface CCSSampleHorizontalViewController (){
    UISegmentedControl                              *_segTopChartType;
    CCSGroupChart                                   *_groupChart;
    UIButton                                        *_btnClose;
    UILabel                                         *_lblProductName;
    UILabel                                         *_lblCurrentPrice;
    UILabel                                         *_lblChangePrice;
    UILabel                                         *_lblChangePercent;
    UILabel                                         *_lblBuyPrice;
    UILabel                                         *_lblSellPrice;
    UILabel                                         *_lblHighPrice;
    UILabel                                         *_lblLowPrice;
    UILabel                                         *_lblTime;
    
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

@property(nonatomic)NSUInteger orietation;

@end

@implementation CCSSampleHorizontalViewController

/******************************************************************************
 *  Override From NSObject
 ******************************************************************************/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 延迟操作执行的代码
    [self loadJSONData:Chart15minData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Simple Horizontal Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)viewDidLayoutSubviews{
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self initView];
    [self initProductInfo];
    [self initAreaChart];
    [self initHandicap];
    [self initDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView{
    _segTopChartType = [[UISegmentedControl alloc] initWithItems:@[@"盘口", @"分时", @"明细", @"日", @"周", @"月", @"1分钟", @"5分钟", @"15分钟", @"30分钟", @"1小时", @"2小时", @"4小时"]];
    [_segTopChartType setFrame:CGRectMake(0.0f, 33.0f, VIEW_SIZE.width, 33.0f)];
    [_segTopChartType addTarget:self action:@selector(segTopChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
    [_segTopChartType setSelectedSegmentIndex:3];
    
    // 设置颜色
    _segTopChartType.tintColor = [UIColor blackColor];
    [_segTopChartType setBackgroundColor:[UIColor blackColor]];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    // 设置文字属性
    [_segTopChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                               NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    [_segTopChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [self.view addSubview:_segTopChartType];
    
    _groupChart = [[CCSGroupChart alloc] init];
    [_groupChart setFrame:CGRectMake(0.0f, 66.0f, VIEW_SIZE.width, VIEW_SIZE.height - 66.0f)];
    
    [_groupChart setOrientationType:GroupChartHorizontalType];
    [_groupChart setChartDelegate:self];
    [_groupChart setChartsBackgroundColor:[UIColor blackColor]];
    
    if (_chartData) {
        [_groupChart setChartData:_chartData];
    }
    
    [self.view addSubview:_groupChart];
    
    _btnClose = [[UIButton alloc] init];
    [_btnClose setFrame:CGRectMake(VIEW_SIZE.width - 80.0f, 0.0f, 80.0f, 33.0f)];
    [_btnClose.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [_btnClose setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_btnClose setTitle:@"关闭" forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnClose];
}

- (void)initProductInfo{
    if (_lblProductName) {
        return;
    }
    
    _lblProductName = [[UILabel alloc] init];
    [_lblProductName setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 33.0f)];
    [_lblProductName setTextAlignment:NSTextAlignmentCenter];
    [_lblProductName setTextColor:[UIColor whiteColor]];
    [_lblProductName setFont:[UIFont systemFontOfSize:18.0f]];
    [_lblProductName setText:@"龙天勇银"];
    [self.view addSubview:_lblProductName];
    
    _lblCurrentPrice = [[UILabel alloc] init];
    [_lblCurrentPrice setFrame:CGRectMake(_lblProductName.frame.size.width, 0.0f, 50.0f, _lblProductName.frame.size.height)];
    [_lblCurrentPrice setTextAlignment:NSTextAlignmentCenter];
    [_lblCurrentPrice setTextColor:[UIColor redColor]];
    [_lblCurrentPrice setFont:[UIFont systemFontOfSize:15.0f]];
    [_lblCurrentPrice setText:@"3500"];
    [self.view addSubview:_lblCurrentPrice];
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    CGRect rect = [@"35" boundingRectWithSize:CGSizeMake(1000.0f, _lblProductName.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    _lblChangePrice = [[UILabel alloc] init];
    [_lblChangePrice setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width, 0.0f, rect.size.width, _lblProductName.frame.size.height)];
    [_lblChangePrice setTextAlignment:NSTextAlignmentCenter];
    [_lblChangePrice setTextColor:[UIColor redColor]];
    [_lblChangePrice setFont:[UIFont systemFontOfSize:15.0f]];
    [_lblChangePrice setText:@"35"];
    [self.view addSubview:_lblChangePrice];
    
    rect = [@"(10%)" boundingRectWithSize:CGSizeMake(1000.0f, _lblProductName.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    _lblChangePercent = [[UILabel alloc] init];
    [_lblChangePercent setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width, 0.0f, rect.size.width, _lblProductName.frame.size.height)];
    [_lblChangePercent setTextAlignment:NSTextAlignmentCenter];
    [_lblChangePercent setTextColor:[UIColor lightGrayColor]];
    [_lblChangePercent setFont:[UIFont systemFontOfSize:15.0f]];
    [_lblChangePercent setText:@"(10%)"];
    [self.view addSubview:_lblChangePercent];
    
    _lblBuyPrice = [[UILabel alloc] init];
    [_lblBuyPrice setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width + _lblChangePercent.frame.size.width, 0.0f, 60.0f, _lblProductName.frame.size.height)];
    [_lblBuyPrice setTextAlignment:NSTextAlignmentCenter];
    [_lblBuyPrice setTextColor:[UIColor lightGrayColor]];
    [_lblBuyPrice setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblBuyPrice setText:@"买3499"];
    [self.view addSubview:_lblBuyPrice];
    
    _lblSellPrice = [[UILabel alloc] init];
    [_lblSellPrice setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width + _lblChangePercent.frame.size.width + _lblBuyPrice.frame.size.width, 0.0f, _lblBuyPrice.frame.size.width, _lblProductName.frame.size.height)];
    [_lblSellPrice setTextAlignment:NSTextAlignmentCenter];
    [_lblSellPrice setTextColor:[UIColor lightGrayColor]];
    [_lblSellPrice setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblSellPrice setText:@"卖3450"];
    [self.view addSubview:_lblSellPrice];
    
    _lblHighPrice = [[UILabel alloc] init];
    [_lblHighPrice setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width + _lblChangePercent.frame.size.width + _lblBuyPrice.frame.size.width + _lblSellPrice.frame.size.width, 0.0f, _lblBuyPrice.frame.size.width, _lblProductName.frame.size.height)];
    [_lblHighPrice setTextAlignment:NSTextAlignmentCenter];
    [_lblHighPrice setTextColor:[UIColor lightGrayColor]];
    [_lblHighPrice setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblHighPrice setText:@"高3559"];
    [self.view addSubview:_lblHighPrice];
    
    _lblLowPrice = [[UILabel alloc] init];
    [_lblLowPrice setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width + _lblChangePercent.frame.size.width + _lblBuyPrice.frame.size.width + _lblSellPrice.frame.size.width + _lblHighPrice.frame.size.width, 0.0f, _lblBuyPrice.frame.size.width, _lblProductName.frame.size.height)];
    [_lblLowPrice setTextAlignment:NSTextAlignmentCenter];
    [_lblLowPrice setTextColor:[UIColor lightGrayColor]];
    [_lblLowPrice setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblLowPrice setText:@"低3444"];
    [self.view addSubview:_lblLowPrice];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _lblTime = [[UILabel alloc] init];
    [_lblTime setFrame:CGRectMake(_lblProductName.frame.size.width + _lblCurrentPrice.frame.size.width + _lblChangePrice.frame.size.width + _lblChangePercent.frame.size.width + _lblBuyPrice.frame.size.width + _lblSellPrice.frame.size.width + _lblHighPrice.frame.size.width + _lblLowPrice.frame.size.width, 0.0f, _lblBuyPrice.frame.size.width, _lblProductName.frame.size.height)];
    [_lblTime setTextAlignment:NSTextAlignmentCenter];
    [_lblTime setTextColor:[UIColor lightGrayColor]];
    [_lblTime setFont:[UIFont systemFontOfSize:14.0f]];
    [_lblTime setText:currentDateStr];
    [self.view addSubview:_lblTime];
}

- (void)initAreaChart{
    if (_vMinsChartContainer) {
        return;
    }
    _vMinsChartContainer = [[UIView alloc] init];
    [_vMinsChartContainer setFrame:CGRectMake(0.0f, 66.0f, VIEW_SIZE.width, VIEW_SIZE.height - 66.0f)];
    [_vMinsChartContainer setHidden:YES];
    [self.view addSubview:_vMinsChartContainer];
    
    _areachart = [[CCSAreaChart alloc] init];
    [_areachart setFrame:CGRectMake(0.0f,0.0f, _vMinsChartContainer.frame.size.width - _vMinsChartContainer.frame.size.width/MIN_CHART_LEFT_RIGHT_SCALE, _vMinsChartContainer.frame.size.height)];
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
    [vTrade setFrame:CGRectMake(_vMinsChartContainer.frame.size.width - _vMinsChartContainer.frame.size.width/MIN_CHART_LEFT_RIGHT_SCALE, _areachart.frame.origin.y, _vMinsChartContainer.frame.size.width/MIN_CHART_LEFT_RIGHT_SCALE, _vMinsChartContainer.frame.size.height)];
    [_vMinsChartContainer addSubview:vTrade];
    
    CGFloat tradeHeight = 0.0f;
    
    NSMutableArray *arrUISellingPrices = [[NSMutableArray alloc] init];
    NSMutableArray *arrUISellingCounts = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UIView *vSellingContainer = [[UIView alloc] init];
        [vSellingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 22.0f)];
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
        [vBuyingContainer setFrame:CGRectMake(0.0f, tradeHeight, vTrade.frame.size.width, 22.0f)];
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
        [lblBuyingCount setTextColor:[UIColor whiteColor]];
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
    [_vHandicap setFrame:CGRectMake([_groupChart frame].origin.x, [_groupChart frame].origin.y, [_groupChart frame].size.width, [_groupChart frame].size.height)];
    [_vHandicap setHidden:YES];
    [self.view addSubview:_vHandicap];
    
    CGFloat handicapHeight = 11.0f;
    
    NSMutableArray *arrhandicapsLeftValue = [[NSMutableArray alloc] init];
    NSMutableArray *arrhandicapsRightValue = [[NSMutableArray alloc] init];
    
    CGFloat marginLeft = 30.0f;
    CGFloat marginRight = 60.0f;
    
    for (int i=0; i<4; i++) {
        UIView *vHandicapContainer = [[UIView alloc] init];
        [vHandicapContainer setFrame:CGRectMake(0.0f, handicapHeight, _vHandicap.frame.size.width, 44.0f)];
        [_vHandicap addSubview:vHandicapContainer];
        
        UIView *vHandicapLeftContainer = [[UIView alloc] init];
        [vHandicapLeftContainer setFrame:CGRectMake(0.0f, 0.0f, vHandicapContainer.frame.size.width/2.0f, vHandicapContainer.frame.size.height)];
        [vHandicapContainer addSubview:vHandicapLeftContainer];
        
        UILabel *lblLeftLeftLabel = [[UILabel alloc] init];
        [lblLeftLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblLeftLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftLeftLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftLeftLabel];
        
        UILabel *lblLeftLeftValue = [[UILabel alloc] init];
        [lblLeftLeftValue setFrame:CGRectMake(marginLeft + lblLeftLeftLabel.frame.size.width, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblLeftLeftValue setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftLeftValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftLeftValue];
        
        [arrhandicapsLeftValue addObject:lblLeftLeftValue];
        
        UILabel *lblLeftRightLabel = [[UILabel alloc] init];
        [lblLeftRightLabel setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width - marginRight - lblLeftLeftLabel.frame.size.width - lblLeftLeftValue.frame.size.width, 0.0f, lblLeftLeftLabel.frame.size.width, vHandicapLeftContainer.frame.size.height)];
        [lblLeftRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftRightLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftRightLabel];
        
        UILabel *lblLeftRightValue = [[UILabel alloc] init];
        [lblLeftRightValue setFrame:CGRectMake(marginLeft + lblLeftRightLabel.frame.size.width + lblLeftRightLabel.frame.origin.x, 0.0f, lblLeftLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblLeftRightValue setTextAlignment:NSTextAlignmentCenter];
        [lblLeftRightValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftRightValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftRightValue];
        
        [arrhandicapsRightValue addObject:lblLeftRightValue];
        
        UIView *vHandicapRightContainer = [[UIView alloc] init];
        [vHandicapRightContainer setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width, 0.0f, vHandicapContainer.frame.size.width/2.0f, vHandicapContainer.frame.size.height)];
        [vHandicapContainer addSubview:vHandicapRightContainer];
        
        UILabel *lblRightLeftLabel = [[UILabel alloc] init];
        [lblRightLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblRightLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightLeftLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightLeftLabel];
        
        UILabel *lblRightLeftValue = [[UILabel alloc] init];
        [lblRightLeftValue setFrame:CGRectMake(marginLeft + lblLeftLeftLabel.frame.size.width, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblRightLeftValue setTextAlignment:NSTextAlignmentCenter];
        [lblRightLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblRightLeftValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightLeftValue];
        
        [arrhandicapsLeftValue addObject:lblRightLeftValue];
        
        UILabel *lblRightRightLabel = [[UILabel alloc] init];
        [lblRightRightLabel setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width - marginRight - lblLeftLeftLabel.frame.size.width - lblLeftLeftValue.frame.size.width, 0.0f, lblLeftLeftLabel.frame.size.width, vHandicapLeftContainer.frame.size.height)];
        [lblRightRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightRightLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightRightLabel];
        
        UILabel *lblRightRightValue = [[UILabel alloc] init];
        [lblRightRightValue setFrame:CGRectMake(marginLeft + lblLeftRightLabel.frame.size.width + lblLeftRightLabel.frame.origin.x, 0.0f, lblLeftLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightRightValue setTextAlignment:NSTextAlignmentCenter];
        [lblRightRightValue setTextColor:[UIColor lightGrayColor]];
        [lblRightRightValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightRightValue];
        
        [arrhandicapsRightValue addObject:lblLeftRightValue];
        
        switch (i) {
            case 0:
                [lblLeftLeftLabel setText:@"卖价"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"卖量"];
                [lblLeftRightValue setText:@"2"];
                [lblRightLeftLabel setText:@"最高"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"最低"];
                [lblRightRightValue setText:@"3559"];
                break;
            case 1:
                [lblLeftLeftLabel setText:@"买价"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"买量"];
                [lblLeftRightValue setText:@"1"];
                [lblRightLeftLabel setText:@"开盘"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"总量"];
                [lblRightRightValue setText:@"3559"];
                break;
            case 2:
                [lblLeftLeftLabel setText:@"最新"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"涨跌"];
                [lblLeftRightValue setText:@"11"];
                [lblRightLeftLabel setText:@"昨收"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"总额"];
                [lblRightRightValue setText:@"3559"];
                break;
            case 3:
                [lblLeftLeftLabel setText:@"昨结"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"持货"];
                [lblLeftRightValue setText:@"3559"];
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
    [_vDetail setFrame:CGRectMake([_groupChart frame].origin.x, [_groupChart frame].origin.y, [_groupChart frame].size.width, [_groupChart frame].size.height)];
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
    [_tbDetail setFrame:CGRectMake([_groupChart frame].origin.x, [lblTime frame].size.height, [_groupChart frame].size.width, [_groupChart frame].size.height - 44.0f)];
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
            CCSOHLCVDData *data = [[CCSOHLCVDData alloc] init];
            
            data.open = [[dict objectForKey:@"o"] doubleValue];
            data.high = [[dict objectForKey:@"h"] doubleValue];
            data.low = [[dict objectForKey:@"l"] doubleValue];
            data.close = [[dict objectForKey:@"c"] doubleValue];
            data.vol = [[dict objectForKey:@"tr"] doubleValue];
            data.date = [dict objectForKey:@"qt"];
            data.current = [[dict objectForKey:@"n"] doubleValue];
            data.preclose = 0;
            data.change = [[dict objectForKey:@"changesPercent"] doubleValue];
            [_chartData addObject:data];
        }
    }
    
    [self dataPreProcess];
    
    [_groupChart setChartData:_chartData];
}

- (void)dataPreProcess{
    if (_chartData == nil) {
        return;
    }
    
    for (int i=0; i< [_chartData count];  i++) {
        CCSOHLCVDData *data = _chartData[i];
        data.open = data.open * AXIS_CALC_PARM;
        data.high = data.high * AXIS_CALC_PARM;
        data.low = data.low * AXIS_CALC_PARM;
        data.close = data.close * AXIS_CALC_PARM;
    }
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

- (void)segTopChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:NO];
        [_vDetail setHidden:YES];
        [_groupChart setHidden:YES];
    }else if (segmentedControl.selectedSegmentIndex == 1) {
        [_vMinsChartContainer setHidden:NO];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_groupChart setHidden:YES];
        
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
    }else if (segmentedControl.selectedSegmentIndex == 2) {
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:NO];
        [_groupChart setHidden:YES];
    }else if (segmentedControl.selectedSegmentIndex == 3){
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_groupChart setHidden:NO];
        //        [self loadJSONData:Chart15minData];
    }else if (segmentedControl.selectedSegmentIndex == 4){
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_groupChart setHidden:NO];
        //        [self loadJSONData:Chart1minData];
    }else{
        [_vMinsChartContainer setHidden:YES];
        [_vHandicap setHidden:YES];
        [_vDetail setHidden:YES];
        [_groupChart setHidden:NO];
        //        [self loadJSONData:ChartTimesData];
    }
}

- (NSString *)findJSONStringWithName:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    //UTF-8编码
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

- (void)close:(UIButton *) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
