//
//  CCSPizzaChartViewController.m
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

#import "CCSPizzaChartViewController.h"
#import "CCSTitleValueColor.h"

@interface CCSPizzaChartViewController () {
    CCSPizzaChart *_pizzaChart;
}
@end

@implementation CCSPizzaChartViewController
@synthesize pizzaChart = _pizzaChart;

- (void)dealloc {
    [_pizzaChart release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Pizza Chart";
}

- (void)randomChangeIndex {
    NSUInteger index = arc4random() % 7;
    [self.pizzaChart selectPartByIndex:index];

    [self performSelector:@selector(randomChangeIndex) withObject:nil afterDelay:2.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    CCSPizzaChart *pizzachart = [[[CCSPizzaChart alloc] initWithFrame:CGRectMake(0, 80, 320, 320)] autorelease];

    pizzachart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    NSMutableArray *piedata = [[[NSMutableArray alloc] init] autorelease];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Alpha" value:1.0 color:[UIColor redColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Bravo" value:2.0 color:[UIColor orangeColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Charlie" value:3.0 color:[UIColor yellowColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Delta" value:4.0 color:[UIColor greenColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Echo" value:5.0 color:[UIColor cyanColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Foxtrot" value:6.0 color:[UIColor blueColor]] autorelease]];
    [piedata addObject:[[[CCSTitleValueColor alloc] initWithTitle:@"Golf" value:7.0 color:[UIColor purpleColor]] autorelease]];

    pizzachart.data = piedata;
    pizzachart.backgroundColor = [UIColor clearColor];

    //select index
    pizzachart.selectedIndex = 2;

    //radius
    pizzachart.radius = 100;
    pizzachart.offsetLength = 8;

    [self.view addSubview:pizzachart];

    self.pizzaChart = pizzachart;
    [self performSelector:@selector(randomChangeIndex) withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
