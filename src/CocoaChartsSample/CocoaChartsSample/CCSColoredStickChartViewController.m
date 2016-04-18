//
//  CCSColoredStickChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSColoredStickChartViewController.h"
#import "CCSColoredStickChartData.h"
#import "CCSColoredStickChart.h"

@interface CCSColoredStickChartViewController ()

@end

@implementation CCSColoredStickChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Colored Stick Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    NSMutableArray *stickData = [[NSMutableArray alloc] init];

    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:113016 low:0 date:@"11/1" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:127695 low:0 date:@"11/2" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:138336 low:0 date:@"11/3" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:141951 low:0 date:@"11/4" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"11/5" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"11/6" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"11/7" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"11/8" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"11/9" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"11/10" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:118336 low:0 date:@"11/11" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:121951 low:0 date:@"11/12" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:137054 low:0 date:@"11/13" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:142374 low:0 date:@"11/14" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:150887 low:0 date:@"11/15" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:166849 low:0 date:@"11/16" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:173016 low:0 date:@"11/17" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:187695 low:0 date:@"11/18" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:198336 low:0 date:@"11/19" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:101951 low:0 date:@"11/20" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"11/21" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"11/22" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"11/23" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"11/24" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:150887 low:0 date:@"11/25" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:166849 low:0 date:@"11/26" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:173016 low:0 date:@"11/27" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:187695 low:0 date:@"11/28" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:198336 low:0 date:@"11/29" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:101951 low:0 date:@"11/30" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"12/1" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"12/2" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"12/3" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"12/4" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"12/5" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"12/6" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"12/7" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"12/8" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"12/9" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"12/10" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"12/11" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"12/12" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"12/13" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"12/14" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"12/15" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"12/16" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"12/17" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"12/18" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"12/19" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"12/20" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"12/21" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"12/22" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"12/23" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"12/24" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"12/25" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"12/26" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"12/27" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"12/28" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"12/29" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"12/30" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"1/1" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"1/2" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"1/3" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"1/4" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"1/5" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"1/6" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"1/7" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"1/8" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"1/9" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"1/10" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"1/11" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"1/12" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"1/13" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"1/14" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"1/15" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"1/16" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"1/17" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"1/18" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"1/19" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"1/20" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:117054 low:0 date:@"1/21" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:122374 low:0 date:@"1/22" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:130887 low:0 date:@"1/23" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:146849 low:0 date:@"1/24" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:157054 low:0 date:@"1/25" color:[UIColor redColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:162374 low:0 date:@"1/26" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:170887 low:0 date:@"1/27" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:186849 low:0 date:@"1/28" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:193016 low:0 date:@"1/29" color:[UIColor blueColor]]];
    [stickData addObject:[[CCSColoredStickChartData alloc] initWithHigh:107695 low:0 date:@"1/30" color:[UIColor redColor]]];

    CCSColoredStickChart *stickchart = [[CCSColoredStickChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

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
    //stickchart.stickFillColor = [UIColor orangeColor];
    stickchart.backgroundColor = [UIColor whiteColor];
    stickchart.axisMarginRight = 30;
    stickchart.axisMarginLeft = 2;
    stickchart.userInteractionEnabled = YES;
    stickchart.displayNumber = 50;
    stickchart.axisYPosition = CCSGridChartYAxisPositionRight;

    [self.view addSubview:stickchart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
