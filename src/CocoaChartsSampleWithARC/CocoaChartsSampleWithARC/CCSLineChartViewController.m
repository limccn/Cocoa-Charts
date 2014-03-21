//
//  CCSLineChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSLineChartViewController.h"
#import "CCSLineChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@interface CCSLineChartViewController ()

@end

@implementation CCSLineChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Line Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *linedata = [[NSMutableArray alloc] init];

    NSMutableArray *singlelinedatas = [[NSMutableArray alloc] init];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:133016 date:@"11/26"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:127695 date:@"12/3"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:138336 date:@"12/10"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:131951 date:@"12/17"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:117054 date:@"12/24"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:122374 date:@"12/31"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:130887 date:@"1/7"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:146849 date:@"1/14"]];

    CCSTitledLine *singleline = [[CCSTitledLine alloc] init];
    singleline.data = singlelinedatas;
    singleline.color = [UIColor blueColor];
    singleline.title = @"chartLine";

    [linedata addObject:singleline];

    CCSLineChart *linechart = [[CCSLineChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    linechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    linechart.linesData = linedata;
    linechart.maxValue = 150000;
    linechart.minValue = 100000;
    linechart.longitudeNum = 7;
    linechart.backgroundColor = [UIColor clearColor];
    linechart.lineWidth = 1.5;
    linechart.axisCalc = 100;
    linechart.lineAlignType = CCSLineAlignTypeJustify;

    [self.view addSubview:linechart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
