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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Grid Chart";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CCSGridChart *gridchart =[[CCSGridChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];
    
    gridchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    gridchart.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    
    [TitleY addObject:@"11/26"];
    [TitleY addObject:@"12/3"];
    [TitleY addObject:@"12/10"];
    [TitleY addObject:@"12/17"];
    [TitleY addObject:@"12/24"];
    [TitleY addObject:@"12/31"];
    [TitleY addObject:@"1/7"];
    [TitleY addObject:@"1/14"];
    
    gridchart.axisYTitles = TitleY;
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    
    [TitleX addObject:@"0"];
    [TitleX addObject:@"1000"];
    [TitleX addObject:@"2000"];
    [TitleX addObject:@"3000"];
    [TitleX addObject:@"4000"];
    
    gridchart.axisXTitles = TitleX;
    
    [self.view addSubview:gridchart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
