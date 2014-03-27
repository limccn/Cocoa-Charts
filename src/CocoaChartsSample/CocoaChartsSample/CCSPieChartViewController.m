//
//  CCSPieChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
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

    CCSPieChart *piechart = [[[CCSPieChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320)] autorelease];

    piechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    NSMutableArray *piedata = [[[NSMutableArray alloc] init] autorelease];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Alpha" value:2.0 color:[UIColor redColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Bravo" value:3.0 color:[UIColor orangeColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Charlie" value:4.0 color:[UIColor yellowColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Delta" value:3.0 color:[UIColor greenColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Echo" value:2.0 color:[UIColor cyanColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Foxtrot" value:3.0 color:[UIColor blueColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Golf" value:4.0 color:[UIColor purpleColor]] autorelease]];

    piechart.data = piedata;
    piechart.backgroundColor = [UIColor clearColor];


    [self.view addSubview:piechart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
