//
//  CCSSlipCandleStickChartViewController.m
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipCandleStickChartViewController.h"
#import "CCSSlipCandleStickChart.h"
#import "CCSCandleStickChartData.h"

@interface CCSSlipCandleStickChartViewController ()

@end

@implementation CCSSlipCandleStickChartViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Slip Candle Stick Chart";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];


    NSMutableArray *candlestickData = [[NSMutableArray alloc] init];

    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:297 high:300 low:293 close:300 date:@"06/30"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:300 high:302 low:297 close:299 date:@"07/01"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:304 high:308 low:304 close:307 date:@"07/04"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:304 high:307 low:303 close:305 date:@"07/05"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:305 high:307 low:302 close:307 date:@"07/06"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:304 high:305 low:302 close:302 date:@"07/07"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:304 high:307 low:302 close:302 date:@"07/08"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:301 high:303 low:299 close:301 date:@"07/11"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:298 high:299 low:294 close:297 date:@"07/12"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:294 high:300 low:291 close:297 date:@"07/13"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:294 high:295 low:293 close:293 date:@"07/14"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:292 high:295 low:292 close:294 date:@"07/15"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:292 high:292 low:286 close:286 date:@"07/19"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:292 high:294 low:288 close:290 date:@"07/20"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:288 high:291 low:287 close:291 date:@"07/21"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:293 high:297 low:293 close:297 date:@"07/22"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:296 high:298 low:294 close:294 date:@"07/25"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:292 high:299 low:291 close:297 date:@"07/26"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:293 high:293 low:287 close:288 date:@"07/27"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:285 high:287 low:280 close:282 date:@"07/28"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:280 high:285 low:279 close:279 date:@"07/29"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:276 high:286 low:274 close:284 date:@"08/01"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:281 high:281 low:275 close:275 date:@"08/02"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:270 high:271 low:267 close:267 date:@"08/03"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:267 high:270 low:266 close:266 date:@"08/04"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:254 high:257 low:246 close:257 date:@"08/05"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:255 high:259 low:252 close:254 date:@"08/08"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:248 high:253 low:238 close:252 date:@"08/09"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:258 high:258 low:252 close:253 date:@"08/10"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:247 high:252 low:247 close:251 date:@"08/11"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:257 low:250 close:251 date:@"08/12"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:257 high:257 low:250 close:253 date:@"08/15"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:253 high:254 low:246 close:249 date:@"08/16"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:249 high:252 low:248 close:250 date:@"08/17"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:252 high:253 low:245 close:247 date:@"08/18"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:242 high:244 low:239 close:241 date:@"08/19"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:239 high:242 low:238 close:238 date:@"08/22"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:238 high:244 low:238 close:243 date:@"08/23"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:246 high:248 low:236 close:236 date:@"08/24"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:244 high:246 low:241 close:243 date:@"08/25"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:243 high:246 low:242 close:245 date:@"08/26"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:246 high:252 low:245 close:248 date:@"08/29"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:253 high:260 low:253 close:257 date:@"08/30"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:258 high:261 low:250 close:258 date:@"08/31"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:258 high:261 low:255 close:256 date:@"09/01"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:254 high:254 low:250 close:250 date:@"09/02"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:246 high:248 low:242 close:243 date:@"09/05"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:239 high:240 low:234 close:235 date:@"09/06"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:235 high:236 low:230 close:233 date:@"09/07"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:245 high:245 low:235 close:237 date:@"09/08"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:235 high:262 low:235 close:255 date:@"09/09"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:253 high:262 low:250 close:259 date:@"09/12"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:259 high:260 low:256 close:259 date:@"09/13"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:259 high:259 low:250 close:250 date:@"09/14"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:252 high:256 low:247 close:247 date:@"09/15"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:249 high:264 low:246 close:264 date:@"09/16"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:259 high:261 low:256 close:257 date:@"09/20"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:259 high:259 low:255 close:255 date:@"09/21"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:254 high:254 low:248 close:250 date:@"09/22"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:250 high:250 low:242 close:243 date:@"09/26"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:246 high:253 low:245 close:253 date:@"09/27"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:262 low:252 close:262 date:@"09/28"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:264 low:256 close:264 date:@"09/29"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:262 high:265 low:256 close:263 date:@"09/30"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:259 low:253 close:256 date:@"10/03"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:257 low:247 close:248 date:@"10/04"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:250 high:255 low:248 close:249 date:@"10/05"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:252 high:258 low:252 close:258 date:@"10/06"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:258 high:263 low:258 close:258 date:@"10/07"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:260 high:260 low:253 close:253 date:@"10/11"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:253 high:260 low:253 close:257 date:@"10/12"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:261 high:261 low:259 close:260 date:@"10/13"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:260 high:260 low:257 close:257 date:@"10/14"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:260 high:262 low:259 close:260 date:@"10/17"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:259 high:260 low:255 close:255 date:@"10/18"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:257 high:257 low:251 close:255 date:@"10/19"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:255 high:256 low:252 close:256 date:@"10/20"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:258 low:254 close:256 date:@"10/21"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:256 high:261 low:256 close:260 date:@"10/24"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:261 high:262 low:255 close:255 date:@"10/25"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:252 high:255 low:250 close:252 date:@"10/26"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:251 high:256 low:246 close:255 date:@"10/27"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:258 high:259 low:252 close:252 date:@"10/28"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:247 high:253 low:245 close:245 date:@"10/31"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:245 high:245 low:237 close:237 date:@"11/01"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:233 high:235 low:231 close:233 date:@"11/02"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:234 high:241 low:233 close:240 date:@"11/04"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:238 high:242 low:235 close:236 date:@"11/07"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:233 high:236 low:228 close:229 date:@"11/08"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:233 high:239 low:231 close:238 date:@"11/09"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:230 high:233 low:230 close:232 date:@"11/10"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:232 high:232 low:226 close:229 date:@"11/11"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:230 high:234 low:230 close:231 date:@"11/14"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:228 high:231 low:228 close:231 date:@"11/15"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:229 high:232 low:227 close:227 date:@"11/16"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:226 high:233 low:225 close:231 date:@"11/17"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:227 high:232 low:227 close:231 date:@"11/18"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:228 high:235 low:228 close:233 date:@"11/21"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:229 high:238 low:229 close:236 date:@"11/22"]];
    [candlestickData addObject:[[CCSCandleStickChartData alloc] initWithOpen:232 high:236 low:224 close:225 date:@"11/24"]];

    CCSSlipCandleStickChart *candleStickChart = [[CCSSlipCandleStickChart alloc] initWithFrame:CGRectMake(0, 80, 320, 200)];

    candleStickChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //设置stickData
    candleStickChart.stickData = candlestickData;
    candleStickChart.maxValue = 340;
    candleStickChart.minValue = 220;
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.displayLatitudeTitle = YES;
    candleStickChart.axisMarginBottom = 12;
    candleStickChart.maxSticksNum = 60;
    candleStickChart.axisMarginLeft = 30;
    candleStickChart.userInteractionEnabled = YES;
    candleStickChart.backgroundColor = [UIColor whiteColor];
    //candleStickChart.candleStickStyle = CCSCandleStickStyleBar;

    [self.view addSubview:candleStickChart];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
