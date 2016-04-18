//
//  CCSBandAreaChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 11/15/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSBandAreaChartViewController.h"
#import "CCSBandAreaChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@interface CCSBandAreaChartViewController ()

@end

@implementation CCSBandAreaChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Band Area Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *linedata = [[NSMutableArray alloc] init];

    NSMutableArray *singlelinedatas1 = [[NSMutableArray alloc] init];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10617113 date:@"11/4"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10603895 date:@"11/1"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10580560 date:@"10/31"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10564875 date:@"10/30"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10620287 date:@"10/29"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10700735 date:@"10/28"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10910710 date:@"10/25"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11031533 date:@"10/24"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11099384 date:@"10/23"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11312491 date:@"10/22"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11599872 date:@"10/21"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11931192 date:@"10/18"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11990448 date:@"10/17"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12048276 date:@"10/16"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12027775 date:@"10/15"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12077014 date:@"10/14"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12183218 date:@"10/11"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12256963 date:@"10/10"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12323136 date:@"10/9"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12389093 date:@"10/8"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12437400 date:@"9/30"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12482654 date:@"9/27"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12505480 date:@"9/26"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12524677 date:@"9/25"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12502277 date:@"9/24"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12479441 date:@"9/23"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12378219 date:@"9/18"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12273935 date:@"9/17"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:12166553 date:@"9/16"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11918787 date:@"9/13"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11522061 date:@"9/12"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10912059 date:@"9/11"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10499696 date:@"9/10"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9885196 date:@"9/9"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9453670 date:@"9/6"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9326601 date:@"9/5"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9286147 date:@"9/4"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9222794 date:@"9/3"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9150994 date:@"9/2"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9087760 date:@"8/30"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9011299 date:@"8/29"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8934251 date:@"8/28"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8826646 date:@"8/27"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8707433 date:@"8/26"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8637643 date:@"8/23"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8607666 date:@"8/22"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8568989 date:@"8/21"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8523176 date:@"8/20"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8461634 date:@"8/19"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8400730 date:@"8/16"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8366701 date:@"8/15"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8363630 date:@"8/14"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8398539 date:@"8/13"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8432797 date:@"8/12"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8491880 date:@"8/9"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8552711 date:@"8/8"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8701628 date:@"8/7"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8703846 date:@"8/6"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8704691 date:@"8/5"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8704874 date:@"8/2"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8707473 date:@"8/1"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8710206 date:@"7/31"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8706704 date:@"7/30"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8703774 date:@"7/29"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8688681 date:@"7/26"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8695485 date:@"7/25"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8702430 date:@"7/24"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8717868 date:@"7/23"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8726431 date:@"7/22"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8766321 date:@"7/19"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8779082 date:@"7/18"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8800376 date:@"7/17"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8887330 date:@"7/16"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:8999954 date:@"7/15"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9084014 date:@"7/12"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9171337 date:@"7/11"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9202712 date:@"7/10"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9371937 date:@"7/9"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9536389 date:@"7/8"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9719491 date:@"7/5"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:9899715 date:@"7/4"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10075432 date:@"7/3"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10368327 date:@"7/2"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10631488 date:@"7/1"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10849122 date:@"6/28"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11043563 date:@"6/27"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11134790 date:@"6/26"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11167134 date:@"6/25"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11157660 date:@"6/24"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11067701 date:@"6/21"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11055600 date:@"6/20"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11034638 date:@"6/19"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11029121 date:@"6/18"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:11017853 date:@"6/17"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10971400 date:@"6/14"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10904335 date:@"6/13"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10807036 date:@"6/7"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10749237 date:@"6/6"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10692279 date:@"6/5"]];
    [singlelinedatas1 addObject:[[CCSLineData alloc] initWithValue:10658587 date:@"6/4"]];

    CCSTitledLine *singleline1 = [[CCSTitledLine alloc] init];
    singleline1.data = singlelinedatas1;
    singleline1.color = [UIColor blueColor];
    singleline1.title = @"chartLine1";

    [linedata addObject:singleline1];

    NSMutableArray *singlelinedatas2 = [[NSMutableArray alloc] init];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9725886 date:@"11/4"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9718104 date:@"11/1"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9723439 date:@"10/31"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9723124 date:@"10/30"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9686712 date:@"10/29"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9639264 date:@"10/28"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9532289 date:@"10/25"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9504466 date:@"10/24"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9521615 date:@"10/23"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9455508 date:@"10/22"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9366127 date:@"10/21"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9247807 date:@"10/18"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9327551 date:@"10/17"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9427723 date:@"10/16"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9510224 date:@"10/15"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9406985 date:@"10/14"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9184781 date:@"10/11"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8970036 date:@"10/10"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8814863 date:@"10/9"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8618906 date:@"10/8"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8446599 date:@"9/30"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8284345 date:@"9/27"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8137519 date:@"9/26"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7996322 date:@"9/25"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7814722 date:@"9/24"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7598558 date:@"9/23"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7425780 date:@"9/18"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7275064 date:@"9/17"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7150446 date:@"9/16"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7094212 date:@"9/13"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7130938 date:@"9/12"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7337940 date:@"9/11"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7454303 date:@"9/10"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7770803 date:@"9/9"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7980329 date:@"9/6"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7951398 date:@"9/5"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7877852 date:@"9/4"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7828205 date:@"9/3"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7794005 date:@"9/2"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7766239 date:@"8/30"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7741700 date:@"8/29"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7725748 date:@"8/28"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7719353 date:@"8/27"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7727566 date:@"8/26"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7697356 date:@"8/23"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7682333 date:@"8/22"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7679010 date:@"8/21"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7679823 date:@"8/20"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7704365 date:@"8/19"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7715269 date:@"8/16"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7721298 date:@"8/15"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7722369 date:@"8/14"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7701460 date:@"8/13"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7679202 date:@"8/12"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7645119 date:@"8/9"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7632288 date:@"8/8"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7570371 date:@"8/7"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7578153 date:@"8/6"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7566308 date:@"8/5"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7551125 date:@"8/2"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7561526 date:@"8/1"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7571793 date:@"7/31"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7593295 date:@"7/30"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7627225 date:@"7/29"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7685318 date:@"7/26"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7709514 date:@"7/25"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7688569 date:@"7/24"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7650131 date:@"7/23"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7607568 date:@"7/22"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7524678 date:@"7/19"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7536917 date:@"7/18"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7537623 date:@"7/17"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7494669 date:@"7/16"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7435045 date:@"7/15"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7395985 date:@"7/12"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7361662 date:@"7/11"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7346287 date:@"7/10"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7301062 date:@"7/9"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7289610 date:@"7/8"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7280508 date:@"7/5"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7263284 date:@"7/4"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7259567 date:@"7/3"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7209672 date:@"7/2"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7185511 date:@"7/1"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7202877 date:@"6/28"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7235436 date:@"6/27"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7385209 date:@"6/26"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7595865 date:@"6/25"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:7840339 date:@"6/24"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8214298 date:@"6/21"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8432399 date:@"6/20"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8652361 date:@"6/19"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8792878 date:@"6/18"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:8912146 date:@"6/17"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9056599 date:@"6/14"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9218664 date:@"6/13"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9415963 date:@"6/7"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9541762 date:@"6/6"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9650720 date:@"6/5"]];
    [singlelinedatas2 addObject:[[CCSLineData alloc] initWithValue:9724412 date:@"6/4"]];

    CCSTitledLine *singleline2 = [[CCSTitledLine alloc] init];
    singleline2.data = singlelinedatas2;
    singleline2.color = [UIColor redColor];
    singleline2.title = @"chartLine2";

    [linedata addObject:singleline2];

    NSMutableArray *singlelinedatas3 = [[NSMutableArray alloc] init];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10171500 date:@"11/4"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10161000 date:@"11/1"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10152000 date:@"10/31"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10144000 date:@"10/30"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10153500 date:@"10/29"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10170000 date:@"10/28"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10221500 date:@"10/25"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10268000 date:@"10/24"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10310500 date:@"10/23"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10384000 date:@"10/22"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10483000 date:@"10/21"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10589500 date:@"10/18"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10659000 date:@"10/17"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10738000 date:@"10/16"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10769000 date:@"10/15"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10742000 date:@"10/14"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10684000 date:@"10/11"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10613500 date:@"10/10"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10569000 date:@"10/9"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10504000 date:@"10/8"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10442000 date:@"9/30"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10383500 date:@"9/27"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10321500 date:@"9/26"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10260500 date:@"9/25"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10158500 date:@"9/24"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10039000 date:@"9/23"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9902000 date:@"9/18"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9774500 date:@"9/17"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9658500 date:@"9/16"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9506500 date:@"9/13"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9326500 date:@"9/12"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9125000 date:@"9/11"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8977000 date:@"9/10"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8828000 date:@"9/9"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8717000 date:@"9/6"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8639000 date:@"9/5"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8582000 date:@"9/4"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8525500 date:@"9/3"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8472500 date:@"9/2"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8427000 date:@"8/30"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8376500 date:@"8/29"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8330000 date:@"8/28"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8273000 date:@"8/27"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8217500 date:@"8/26"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8167500 date:@"8/23"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8145000 date:@"8/22"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8124000 date:@"8/21"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8101500 date:@"8/20"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8083000 date:@"8/19"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8058000 date:@"8/16"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8044000 date:@"8/15"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8043000 date:@"8/14"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8050000 date:@"8/13"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8056000 date:@"8/12"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8068500 date:@"8/9"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8092500 date:@"8/8"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8136000 date:@"8/7"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8141000 date:@"8/6"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8135500 date:@"8/5"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8128000 date:@"8/2"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8134500 date:@"8/1"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8141000 date:@"7/31"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8150000 date:@"7/30"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8165500 date:@"7/29"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8187000 date:@"7/26"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8202500 date:@"7/25"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8195500 date:@"7/24"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8184000 date:@"7/23"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8167000 date:@"7/22"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8145500 date:@"7/19"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8158000 date:@"7/18"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8169000 date:@"7/17"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8191000 date:@"7/16"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8217500 date:@"7/15"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8240000 date:@"7/12"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8266500 date:@"7/11"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8274500 date:@"7/10"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8336500 date:@"7/9"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8413000 date:@"7/8"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8500000 date:@"7/5"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8581500 date:@"7/4"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8667500 date:@"7/3"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8789000 date:@"7/2"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:8908500 date:@"7/1"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9026000 date:@"6/28"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9139500 date:@"6/27"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9260000 date:@"6/26"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9381500 date:@"6/25"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9499000 date:@"6/24"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9641000 date:@"6/21"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9744000 date:@"6/20"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9843500 date:@"6/19"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9911000 date:@"6/18"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:9965000 date:@"6/17"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10014000 date:@"6/14"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10061500 date:@"6/13"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10111500 date:@"6/7"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10145500 date:@"6/6"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10171500 date:@"6/5"]];
    [singlelinedatas3 addObject:[[CCSLineData alloc] initWithValue:10191500 date:@"6/4"]];

    CCSTitledLine *singleline3 = [[CCSTitledLine alloc] init];
    singleline3.data = singlelinedatas3;
    singleline3.color = [UIColor greenColor];
    singleline3.title = @"chartLine2";

    [linedata addObject:singleline3];

    CCSBandAreaChart *linechart = [[CCSBandAreaChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    linechart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    linechart.linesData = linedata;
    linechart.longitudeNum = 6;
    linechart.backgroundColor = [UIColor clearColor];
    linechart.lineWidth = 1.5;
    linechart.areaAlpha = 0.5;

    [self.view addSubview:linechart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
