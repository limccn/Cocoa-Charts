//
//  CCSStickChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSStickChartViewController.h"
#import "CCSStickChartData.h"
#import "CCSStickChart.h"

@interface CCSStickChartViewController ()

@end

@implementation CCSStickChartViewController

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
    
    self.title = @"Stick Chart";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    NSMutableArray *stickData = [[[NSMutableArray alloc]init]autorelease];
    
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:133016 low:0 date: @"11/26"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:127695 low:0 date: @"12/3"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:138336 low:0 date: @"12/10"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:131951 low:0 date: @"12/17"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:117054 low:0 date: @"12/24"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:122374 low:0 date: @"12/31"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:130887 low:0 date: @"1/7"] autorelease]];
    [stickData addObject: [[[CCSStickChartData alloc] initWithHigh:146849 low:0 date: @"1/14"] autorelease]];
    
    CCSStickChart *stickchart =[[[CCSStickChart alloc] initWithFrame:CGRectMake(0, 80, 320, 200)]autorelease];
    
    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    //设置stickData
    stickchart.stickData = stickData;
    stickchart.maxValue=150000;
    stickchart.minValue=0;
    stickchart.maxSticksNum=8;
    stickchart.displayCrossXOnTouch = NO;
    stickchart.displayCrossYOnTouch = NO;
    stickchart.latitudeNum = 2;
    stickchart.longitudeNum = 2;
    stickchart.stickFillColor = [UIColor orangeColor];
    stickchart.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:stickchart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
