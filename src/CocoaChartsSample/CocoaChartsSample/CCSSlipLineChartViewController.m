//
//  CCSSlipLineChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 12/6/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipLineChartViewController.h"
#import "CCSSlipLineChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@interface CCSSlipLineChartViewController ()

@end

@implementation CCSSlipLineChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Slip Line Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *linedata = [[[NSMutableArray alloc] init] autorelease];

    NSMutableArray *singlelinedatas = [[[NSMutableArray alloc] init] autorelease];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:281.8 date:@"06/30"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:285.6 date:@"07/01"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:289.8 date:@"07/04"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:293.2 date:@"07/05"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:295.9 date:@"07/06"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:297.9 date:@"07/07"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:299.0 date:@"07/08"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:300.5 date:@"07/11"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:301.4 date:@"07/12"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:301.7 date:@"07/13"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:301.0 date:@"07/14"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:300.5 date:@"07/15"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:298.4 date:@"07/19"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:296.9 date:@"07/20"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:295.3 date:@"07/21"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:294.8 date:@"07/22"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:294.0 date:@"07/25"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:293.6 date:@"07/26"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:292.7 date:@"07/27"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:291.2 date:@"07/28"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:289.8 date:@"07/29"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:288.8 date:@"08/01"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:287.7 date:@"08/02"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:285.4 date:@"08/03"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:282.9 date:@"08/04"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:278.9 date:@"08/05"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:274.9 date:@"08/08"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:270.4 date:@"08/09"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:266.9 date:@"08/10"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:263.8 date:@"08/11"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:261.0 date:@"08/12"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:257.9 date:@"08/15"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.3 date:@"08/16"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:253.6 date:@"08/17"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:251.7 date:@"08/18"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:250.1 date:@"08/19"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:248.5 date:@"08/22"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.6 date:@"08/23"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:245.9 date:@"08/24"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:245.1 date:@"08/25"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:244.5 date:@"08/26"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:244.0 date:@"08/29"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:244.8 date:@"08/30"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:245.6 date:@"08/31"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:246.5 date:@"09/01"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.4 date:@"09/02"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.9 date:@"09/05"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.1 date:@"09/06"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:246.8 date:@"09/07"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:246.2 date:@"09/08"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.2 date:@"09/09"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:248.3 date:@"09/12"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:248.5 date:@"09/13"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:247.7 date:@"09/14"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:246.8 date:@"09/15"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:248.2 date:@"09/16"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:249.6 date:@"09/20"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:251.6 date:@"09/21"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:253.3 date:@"09/22"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:253.9 date:@"09/26"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:253.7 date:@"09/27"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:254.0 date:@"09/28"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:254.5 date:@"09/29"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.8 date:@"09/30"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.7 date:@"10/03"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.1 date:@"10/04"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:254.3 date:@"10/05"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:254.6 date:@"10/06"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.4 date:@"10/07"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.4 date:@"10/11"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.8 date:@"10/12"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.6 date:@"10/13"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.9 date:@"10/14"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.6 date:@"10/17"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.5 date:@"10/18"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.2 date:@"10/19"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.9 date:@"10/20"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.7 date:@"10/21"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.9 date:@"10/24"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:257.1 date:@"10/25"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.6 date:@"10/26"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:256.1 date:@"10/27"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:255.6 date:@"10/28"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:254.1 date:@"10/31"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:252.3 date:@"11/01"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:250.1 date:@"11/02"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:248.5 date:@"11/04"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:246.5 date:@"11/07"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:243.4 date:@"11/08"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:241.7 date:@"11/09"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:239.7 date:@"11/10"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:237.1 date:@"11/11"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:235.0 date:@"11/14"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:233.6 date:@"11/15"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:232.6 date:@"11/16"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:232.4 date:@"11/17"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:231.5 date:@"11/18"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:231.2 date:@"11/21"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:231.9 date:@"11/22"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:230.6 date:@"11/24"] autorelease]];

    CCSTitledLine *singleline = [[[CCSTitledLine alloc] init] autorelease];
    singleline.data = singlelinedatas;
    singleline.color = [UIColor blueColor];
    singleline.title = @"chartLine";

    [linedata addObject:singleline];

    CCSSlipLineChart *linechart = [[[CCSSlipLineChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)] autorelease];

    linechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    linechart.linesData = linedata;
    linechart.longitudeNum = 6;
    linechart.backgroundColor = [UIColor clearColor];
    linechart.lineWidth = 1.5;
    linechart.userInteractionEnabled = YES;
    linechart.displayFrom = 0;
    linechart.displayNumber = 20;
    //linechart.axisYPosition = CCSGridChartYAxisPositionRight;

    [self.view addSubview:linechart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
