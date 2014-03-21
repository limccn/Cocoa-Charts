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

    NSMutableArray *linedata = [[NSMutableArray alloc] init];

    NSMutableArray *singlelinedatas = [[NSMutableArray alloc] init];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:281.8 date:@"06/30"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:285.6 date:@"07/01"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:289.8 date:@"07/04"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:293.2 date:@"07/05"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:295.9 date:@"07/06"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:297.9 date:@"07/07"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:299.0 date:@"07/08"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:300.5 date:@"07/11"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:301.4 date:@"07/12"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:301.7 date:@"07/13"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:301.0 date:@"07/14"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:300.5 date:@"07/15"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:298.4 date:@"07/19"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:296.9 date:@"07/20"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:295.3 date:@"07/21"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:294.8 date:@"07/22"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:294.0 date:@"07/25"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:293.6 date:@"07/26"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:292.7 date:@"07/27"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:291.2 date:@"07/28"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:289.8 date:@"07/29"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:288.8 date:@"08/01"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:287.7 date:@"08/02"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:285.4 date:@"08/03"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:282.9 date:@"08/04"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:278.9 date:@"08/05"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:274.9 date:@"08/08"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:270.4 date:@"08/09"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:266.9 date:@"08/10"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:263.8 date:@"08/11"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:261.0 date:@"08/12"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:257.9 date:@"08/15"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.3 date:@"08/16"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:253.6 date:@"08/17"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:251.7 date:@"08/18"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:250.1 date:@"08/19"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"08/22"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.6 date:@"08/23"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:245.9 date:@"08/24"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:245.1 date:@"08/25"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:244.5 date:@"08/26"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:244.0 date:@"08/29"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:244.8 date:@"08/30"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:245.6 date:@"08/31"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:246.5 date:@"09/01"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.4 date:@"09/02"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.9 date:@"09/05"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.1 date:@"09/06"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:246.8 date:@"09/07"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:246.2 date:@"09/08"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.2 date:@"09/09"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:248.3 date:@"09/12"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"09/13"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:247.7 date:@"09/14"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:246.8 date:@"09/15"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:248.2 date:@"09/16"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:249.6 date:@"09/20"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:251.6 date:@"09/21"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:253.3 date:@"09/22"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:253.9 date:@"09/26"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:253.7 date:@"09/27"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:254.0 date:@"09/28"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:254.5 date:@"09/29"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.8 date:@"09/30"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.7 date:@"10/03"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.1 date:@"10/04"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:254.3 date:@"10/05"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:254.6 date:@"10/06"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.4 date:@"10/07"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"10/11"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.8 date:@"10/12"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.6 date:@"10/13"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.9 date:@"10/14"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.6 date:@"10/17"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.5 date:@"10/18"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.2 date:@"10/19"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.9 date:@"10/20"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.7 date:@"10/21"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.9 date:@"10/24"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:257.1 date:@"10/25"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.6 date:@"10/26"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:256.1 date:@"10/27"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:255.6 date:@"10/28"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:254.1 date:@"10/31"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:252.3 date:@"11/01"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:250.1 date:@"11/02"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"11/04"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:246.5 date:@"11/07"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:243.4 date:@"11/08"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:241.7 date:@"11/09"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:239.7 date:@"11/10"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:237.1 date:@"11/11"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:235.0 date:@"11/14"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:233.6 date:@"11/15"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:232.6 date:@"11/16"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:232.4 date:@"11/17"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:231.5 date:@"11/18"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:231.2 date:@"11/21"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:231.9 date:@"11/22"]];
    [singlelinedatas addObject:[[CCSLineData alloc] initWithValue:230.6 date:@"11/24"]];

    CCSTitledLine *singleline = [[CCSTitledLine alloc] init];
    singleline.data = singlelinedatas;
    singleline.color = [UIColor blueColor];
    singleline.title = @"chartLine";

    [linedata addObject:singleline];

    CCSSlipLineChart *linechart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

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
