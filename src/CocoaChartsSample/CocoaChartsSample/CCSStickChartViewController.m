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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Stick Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    NSMutableArray *stickData = [[[NSMutableArray alloc] init] autorelease];

    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:113016 low:0 date:@"11/1"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:127695 low:0 date:@"11/2"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:138336 low:0 date:@"11/3"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:141951 low:0 date:@"11/4"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"11/5"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"11/6"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"11/7"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"11/8"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"11/9"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"11/10"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:118336 low:0 date:@"11/11"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:121951 low:0 date:@"11/12"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:137054 low:0 date:@"11/13"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:142374 low:0 date:@"11/14"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:150887 low:0 date:@"11/15"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:166849 low:0 date:@"11/16"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:173016 low:0 date:@"11/17"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:187695 low:0 date:@"11/18"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:198336 low:0 date:@"11/19"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:101951 low:0 date:@"11/20"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"11/21"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"11/22"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"11/23"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"11/24"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:150887 low:0 date:@"11/25"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:166849 low:0 date:@"11/26"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:173016 low:0 date:@"11/27"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:187695 low:0 date:@"11/28"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:198336 low:0 date:@"11/29"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:101951 low:0 date:@"11/30"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"12/1"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"12/2"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"12/3"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"12/4"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"12/5"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"12/6"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"12/7"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"12/8"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"12/9"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"12/10"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"12/11"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"12/12"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"12/13"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"12/14"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"12/15"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"12/16"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"12/17"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"12/18"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"12/19"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"12/20"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"12/21"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"12/22"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"12/23"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"12/24"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"12/25"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"12/26"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"12/27"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"12/28"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"12/29"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"12/30"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"1/1"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"1/2"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"1/3"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"1/4"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"1/5"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"1/6"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"1/7"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"1/8"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"1/9"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"1/10"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"1/11"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"1/12"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"1/13"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"1/14"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"1/15"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"1/16"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"1/17"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"1/18"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"1/19"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"1/20"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:117054 low:0 date:@"1/21"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:122374 low:0 date:@"1/22"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:130887 low:0 date:@"1/23"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:146849 low:0 date:@"1/24"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:157054 low:0 date:@"1/25"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:162374 low:0 date:@"1/26"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:170887 low:0 date:@"1/27"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:186849 low:0 date:@"1/28"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:193016 low:0 date:@"1/29"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:107695 low:0 date:@"1/30"] autorelease]];

    CCSStickChart *stickchart = [[[CCSStickChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)] autorelease];

    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //设置stickData
    stickchart.stickData = stickData;
    stickchart.maxValue = 150000;
    stickchart.minValue = 0;
    stickchart.maxSticksNum = 8;
    //stickchart.displayCrossXOnTouch = NO;
    //stickchart.displayCrossYOnTouch = NO;
    stickchart.latitudeNum = 2;
    stickchart.longitudeNum = 2;
    stickchart.stickFillColor = [UIColor orangeColor];
    stickchart.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:stickchart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
