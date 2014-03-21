//
//  CCSPieChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSPieChartViewController.h"
#import "CCSPieChart.h"
#import "CCSTitleValueColor.h"

@interface CCSPieChartViewController ()

@end

@implementation CCSPieChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Pie Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    CCSPieChart *piechart = [[CCSPieChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];

    piechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    NSMutableArray *piedata = [[NSMutableArray alloc] init];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Alpha" value:2.0 color:[UIColor redColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Bravo" value:3.0 color:[UIColor orangeColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Charlie" value:4.0 color:[UIColor yellowColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Delta" value:3.0 color:[UIColor greenColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Echo" value:2.0 color:[UIColor cyanColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Foxtrot" value:3.0 color:[UIColor blueColor]]];
    [piedata addObject:[[CCSTitleValueColor alloc] initWithTitle:@"Golf" value:4.0 color:[UIColor purpleColor]]];

    piechart.data = piedata;
    piechart.backgroundColor = [UIColor clearColor];


    [self.view addSubview:piechart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
