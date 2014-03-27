//
//  CCSMinusStickChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CCSMinusStickChartViewController.h"
#import "CCSStickChartData.h"
#import "CCSMinusStickChart.h"

@interface CCSMinusStickChartViewController ()

@end

@implementation CCSMinusStickChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Minus Stick Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    NSMutableArray *stickData = [[[NSMutableArray alloc] init] autorelease];

    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:1301 low:0 date:@"11/26"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:1269 low:0 date:@"12/3"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:1383 low:0 date:@"12/10"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:1315 low:0 date:@"12/17"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:-1174 low:0 date:@"12/24"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:-1227 low:0 date:@"12/31"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:-1308 low:0 date:@"1/7"] autorelease]];
    [stickData addObject:[[[CCSStickChartData alloc] initWithHigh:1468 low:0 date:@"1/14"] autorelease]];

    CCSMinusStickChart *stickchart = [[[CCSMinusStickChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)] autorelease];

    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //设置stickData
    stickchart.stickData = stickData;
    stickchart.maxValue = 1500;
    stickchart.minValue = -1500;
    stickchart.maxSticksNum = 8;
    stickchart.displayCrossXOnTouch = NO;
    stickchart.displayCrossYOnTouch = NO;
    stickchart.latitudeNum = 4;
    stickchart.longitudeNum = 3;
    stickchart.stickFillColor = [UIColor orangeColor];
    stickchart.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:stickchart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
