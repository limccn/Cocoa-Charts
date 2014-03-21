//
//  CCSAreaChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 11/13/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSAreaChartViewController.h"
#import "CCSAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@interface CCSAreaChartViewController ()

@end

@implementation CCSAreaChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Area Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *linedata = [[NSMutableArray alloc] init];

    NSMutableArray *singlelinedatas1 = [[NSMutableArray alloc] init];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:133016 date:@"11/26"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:127695 date:@"12/3"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:138336 date:@"12/10"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:131951 date:@"12/17"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:117054 date:@"12/24"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:122374 date:@"12/31"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:130887 date:@"1/7"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:146849 date:@"1/14"]];

    CCSTitledLine *singleline1 = [[CCSTitledLine alloc] init];
    singleline1.data = singlelinedatas1;
    singleline1.color = [UIColor blueColor];
    singleline1.title = @"chartLine1";

    [linedata addObject:singleline1];

    NSMutableArray *singlelinedatas2 = [[NSMutableArray alloc] init];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:143016 date:@"11/26"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:117695 date:@"12/3"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:128336 date:@"12/10"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:121951 date:@"12/17"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:127054 date:@"12/24"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:132374 date:@"12/31"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:120887 date:@"1/7"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:116849 date:@"1/14"]];

    CCSTitledLine *singleline2 = [[CCSTitledLine alloc] init];
    singleline2.data = singlelinedatas2;
    singleline2.color = [UIColor redColor];
    singleline2.title = @"chartLine2";

    [linedata addObject:singleline2];

    CCSAreaChart *linechart = [[CCSAreaChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    linechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    linechart.linesData = linedata;
    linechart.maxValue = 150000;
    linechart.minValue = 100000;
    linechart.longitudeNum = 6;
    linechart.backgroundColor = [UIColor clearColor];
    linechart.lineWidth = 1.5;
    linechart.areaAlpha = 0.2;

    NSMutableArray *TitleX = [[NSMutableArray alloc] init];

    [TitleX addObject:@"11/26"];
    [TitleX addObject:@"12/3"];
    [TitleX addObject:@"12/10"];
    [TitleX addObject:@"12/17"];
    [TitleX addObject:@"12/24"];
    [TitleX addObject:@"12/31"];
    [TitleX addObject:@"1/7"];
    [TitleX addObject:@"1/14"];

    linechart.longitudeTitles = TitleX;

    [self.view addSubview:linechart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
