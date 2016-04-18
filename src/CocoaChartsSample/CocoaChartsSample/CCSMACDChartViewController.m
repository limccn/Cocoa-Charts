//
//  CCSMACDChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMACDChartViewController.h"
#import "CCSMACDChart.h"
#import "CCSMACDData.h"

@interface CCSMACDChartViewController ()

@end

@implementation CCSMACDChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"MACD Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    NSMutableArray *stickData = [[NSMutableArray alloc] init];


    [stickData addObject:[[CCSMACDData alloc] initWithDea:46934 diff:7297 macd:-79272 date:@"6/4"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:30276 diff:-36354 macd:-133260 date:@"6/5"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:7002 diff:-86094 macd:-186192 date:@"6/6"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-20810 diff:-132060 macd:-222500 date:@"6/7"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-55227 diff:-192894 macd:-275332 date:@"6/13"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-91853 diff:-238357 macd:-293008 date:@"6/14"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-127894 diff:-272058 macd:-288326 date:@"6/17"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-160430 diff:-290575 macd:-260288 date:@"6/18"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-191570 diff:-316130 macd:-249118 date:@"6/19"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-227264 diff:-370042 macd:-285554 date:@"6/20"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-265658 diff:-419232 macd:-307148 date:@"6/21"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-315250 diff:-513620 macd:-396738 date:@"6/24"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-364077 diff:-559382 macd:-390610 date:@"6/25"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-409512 diff:-591253 macd:-363482 date:@"6/26"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-447752 diff:-600711 macd:-305918 date:@"6/27"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-472075 diff:-569366 macd:-194582 date:@"6/28"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-487079 diff:-547095 macd:-120032 date:@"7/1"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-494664 diff:-525007 macd:-60684 date:@"7/2"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-497830 diff:-510493 macd:-25324 date:@"7/3"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-495648 diff:-486922 macd:17452 date:@"7/4"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-489260 diff:-463704 macd:51110 date:@"7/5"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-482644 diff:-456183 macd:52922 date:@"7/8"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-474974 diff:-444294 macd:61358 date:@"7/9"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-462931 diff:-414760 macd:96342 date:@"7/10"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-435758 diff:-327065 macd:217386 date:@"7/11"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-405436 diff:-284146 macd:242578 date:@"7/12"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-372688 diff:-241698 macd:261980 date:@"7/15"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-339607 diff:-207282 macd:264648 date:@"7/16"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-308713 diff:-185136 macd:247154 date:@"7/17"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-284094 diff:-185617 macd:196952 date:@"7/18"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-266763 diff:-197441 macd:138644 date:@"7/19"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-255578 diff:-210836 macd:89482 date:@"7/22"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-245216 diff:-203771 macd:82890 date:@"7/23"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-237590 diff:-207082 macd:61014 date:@"7/24"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-231216 diff:-205721 macd:50988 date:@"7/25"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-226232 diff:-206298 macd:39866 date:@"7/26"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-225535 diff:-222748 macd:5574 date:@"7/29"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-225452 diff:-225119 macd:664 date:@"7/30"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-224925 diff:-222817 macd:4216 date:@"7/31"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-221561 diff:-208103 macd:26914 date:@"8/1"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-216249 diff:-195002 macd:42494 date:@"8/2"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-208226 diff:-176133 macd:64184 date:@"8/5"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-198928 diff:-161735 macd:74384 date:@"8/6"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-189184 diff:-150208 macd:77950 date:@"8/7"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-179559 diff:-141060 macd:76998 date:@"8/8"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-169785 diff:-130690 macd:78190 date:@"8/9"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-155257 diff:-97144 macd:116224 date:@"8/12"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-136401 diff:-60980 macd:150842 date:@"8/13"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-117266 diff:-40726 macd:153080 date:@"8/14"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-100128 diff:-31573 macd:137108 date:@"8/15"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-83475 diff:-16862 macd:133224 date:@"8/16"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-65575 diff:6022 macd:143196 date:@"8/19"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-46726 diff:28670 macd:150792 date:@"8/20"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-29120 diff:41301 macd:140844 date:@"8/21"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:-13310 diff:49929 macd:126480 date:@"8/22"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:256 diff:54524 macd:108536 date:@"8/23"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:16811 diff:83030 macd:132438 date:@"8/26"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:37683 diff:121170 macd:166974 date:@"8/27"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:60878 diff:153659 macd:185562 date:@"8/28"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:82898 diff:170981 macd:176164 date:@"8/29"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:103956 diff:188187 macd:168462 date:@"8/30"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:122751 diff:197928 macd:150354 date:@"9/2"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:140776 diff:212877 macd:144202 date:@"9/3"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:157851 diff:226152 macd:136600 date:@"9/4"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:172916 diff:233177 macd:120520 date:@"9/5"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:192558 diff:271124 macd:157132 date:@"9/6"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:228915 diff:374346 macd:290860 date:@"9/9"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:287203 diff:520353 macd:466300 date:@"9/10"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:353452 diff:618446 macd:529988 date:@"9/11"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:436047 diff:766428 macd:660762 date:@"9/12"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:518140 diff:846512 macd:656744 date:@"9/13"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:587733 diff:866105 macd:556742 date:@"9/16"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:633973 diff:818935 macd:369922 date:@"9/17"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:664420 diff:786208 macd:243574 date:@"9/18"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:684729 diff:765966 macd:162472 date:@"9/23"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:690156 diff:711862 macd:43412 date:@"9/24"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:683918 diff:658968 macd:-49900 date:@"9/25"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:659406 diff:561356 macd:-196100 date:@"9/26"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:624338 diff:484066 macd:-280542 date:@"9/27"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:580676 diff:406029 macd:-349294 date:@"9/30"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:534827 diff:351430 macd:-366792 date:@"10/8"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:489429 diff:307839 macd:-363180 date:@"10/9"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:440952 diff:247044 macd:-387816 date:@"10/10"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:401175 diff:242068 macd:-318214 date:@"10/11"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:363874 diff:214670 macd:-298408 date:@"10/14"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:326379 diff:176398 macd:-299960 date:@"10/15"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:286793 diff:128449 macd:-316686 date:@"10/16"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:245882 diff:82239 macd:-327286 date:@"10/17"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:206682 diff:49883 macd:-313598 date:@"10/18"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:173968 diff:43110 macd:-261714 date:@"10/21"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:143606 diff:22156 macd:-242898 date:@"10/22"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:117418 diff:12666 macd:-209504 date:@"10/23"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:94313 diff:1895 macd:-184836 date:@"10/24"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:75573 diff:614 macd:-149918 date:@"10/25"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:61656 diff:5986 macd:-111340 date:@"10/28"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:56615 diff:36451 macd:-40328 date:@"10/29"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:59027 diff:68679 macd:19302 date:@"10/30"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:61703 diff:72405 macd:21404 date:@"10/31"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:65698 diff:81679 macd:31960 date:@"11/1"]];
    [stickData addObject:[[CCSMACDData alloc] initWithDea:68247 diff:78442 macd:20388 date:@"11/4"]];

    CCSMACDChart *stickchart = [[CCSMACDChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //设置stickData
    stickchart.stickData = stickData;
    stickchart.maxValue = 300000;
    stickchart.minValue = -300000;
    stickchart.maxSticksNum = 100;
    stickchart.displayCrossXOnTouch = NO;
    stickchart.displayCrossYOnTouch = NO;
    stickchart.latitudeNum = 4;
    stickchart.longitudeNum = 3;
    stickchart.backgroundColor = [UIColor blackColor];
    stickchart.macdDisplayType = CCSMACDChartDisplayTypeLineStick;
    stickchart.positiveStickColor = [UIColor redColor];
    stickchart.negativeStickColor = [UIColor cyanColor];
    stickchart.macdLineColor = [UIColor cyanColor];
    stickchart.deaLineColor = [UIColor yellowColor];
    stickchart.diffLineColor = [UIColor whiteColor];

    [self.view addSubview:stickchart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
