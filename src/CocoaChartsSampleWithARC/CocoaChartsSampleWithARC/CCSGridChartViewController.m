//
//  CCSGridChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSGridChartViewController.h"
#import "CCSGridChart.h"

@interface CCSGridChartViewController ()

@end

@implementation CCSGridChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Grid Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CCSGridChart *gridchart = [[CCSGridChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    gridchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    gridchart.backgroundColor = [UIColor clearColor];

    NSMutableArray *TitleX = [[NSMutableArray alloc] init];

    [TitleX addObject:@"11/26"];
    [TitleX addObject:@"12/3"];
    [TitleX addObject:@"12/10"];
    [TitleX addObject:@"12/17"];
    [TitleX addObject:@"12/24"];
    [TitleX addObject:@"12/31"];
    [TitleX addObject:@"1/7"];
    [TitleX addObject:@"1/14"];

    gridchart.longitudeTitles = TitleX;

    NSMutableArray *TitleY = [[NSMutableArray alloc] init];

    [TitleY addObject:@"0"];
    [TitleY addObject:@"1000"];
    [TitleY addObject:@"2000"];
    [TitleY addObject:@"3000"];
    [TitleY addObject:@"4000"];

    gridchart.latitudeTitles = TitleY;

    [self.view addSubview:gridchart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
