//
//  CCSRadarChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 11/13/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSRadarChartViewController.h"
#import "CCSRadarChart.h"
#import "CCSTitleValuesColor.h"


@interface CCSRadarChartViewController ()

@end

@implementation CCSRadarChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Radar Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    CCSRadarChart *spiderwebchart = [[CCSRadarChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];

    spiderwebchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    NSArray *values1 = [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:3.0f],
            [NSNumber numberWithFloat:4.0f],
            [NSNumber numberWithFloat:3.0f],
            [NSNumber numberWithFloat:4.0f],
            [NSNumber numberWithFloat:5.0f],
            nil];
    NSArray *values2 = [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:5.0f],
            [NSNumber numberWithFloat:2.0f],
            [NSNumber numberWithFloat:3.0f],
            [NSNumber numberWithFloat:2.0f],
            [NSNumber numberWithFloat:3.0f],
            nil];

    NSMutableArray *spiderwebdata = [[NSMutableArray alloc] init];
    [spiderwebdata addObject:[[CCSTitleValuesColor alloc] initWithTitle:@"New York" values:values1 color:[UIColor blueColor]]];
    [spiderwebdata addObject:[[CCSTitleValuesColor alloc] initWithTitle:@"Los Angeles" values:values2 color:[UIColor redColor]]];

    spiderwebchart.titles = [NSMutableArray arrayWithObjects:@"Alpha", @"Bravo", @"Charlie", @"Delta", @"Echo", nil];

    spiderwebchart.data = spiderwebdata;

    spiderwebchart.backgroundColor = [UIColor clearColor];

    [self.view addSubview:spiderwebchart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
