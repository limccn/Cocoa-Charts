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
    
    self.title = @"Line Chart";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *linedata = [[[NSMutableArray alloc]init]autorelease];
    
    NSMutableArray *singlelinedatas = [[[NSMutableArray alloc]init]autorelease];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:133016 date:@"11/26"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:127695 date:@"12/3"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:138336 date:@"12/10"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:131951 date:@"12/17"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:117054 date:@"12/24"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:122374 date:@"12/31"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:130887 date:@"1/7"] autorelease]];
    [singlelinedatas addObject:[[[CCSLineData alloc] initWithValue:146849 date:@"1/14"] autorelease]];
    
    CCSTitledLine *singleline = [[[CCSTitledLine alloc]init] autorelease];
    singleline.data = singlelinedatas;
    singleline.color = [UIColor blueColor];
    singleline.title = @"chartLine";
    
    [linedata addObject:singleline];
    
    CCSLineChart *linechart =[[[CCSLineChart alloc] initWithFrame:CGRectMake(0, 80, 320, 200)] autorelease];
    
    linechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    linechart.linesData=linedata;
    linechart.maxValue=150000;
    linechart.minValue=100000;
    linechart.longitudeNum=6;
    linechart.backgroundColor = [UIColor clearColor];
    linechart.lineWidth=1.5;
    
    NSMutableArray *TitleY = [[[NSMutableArray alloc] init]autorelease];
    
    [TitleY addObject:@"11/26"];
    [TitleY addObject:@"12/3"];
    [TitleY addObject:@"12/10"];
    [TitleY addObject:@"12/17"];
    [TitleY addObject:@"12/24"];
    [TitleY addObject:@"12/31"];
    [TitleY addObject:@"1/7"];
    [TitleY addObject:@"1/14"];
    
    linechart.axisYTitles = TitleY;    
    
    [self.view addSubview:linechart];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
