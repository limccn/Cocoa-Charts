//
//  CCSMACandleStickChartViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSMACandleStickChartViewController.h"
#import "CCSMACandleStickChart.h"
#import "CCSCandleStickChartData.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@interface CCSMACandleStickChartViewController ()

@end

@implementation CCSMACandleStickChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"MA Candle Stick Chart";
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

    NSMutableArray *linesdata = [[NSMutableArray alloc] init];

    NSMutableArray *linedataMA5 = [[NSMutableArray alloc] initWithCapacity:100];

    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:291.8 date:@"06/30"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:293.4 date:@"07/01"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:297.6 date:@"07/04"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:301.0 date:@"07/05"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:303.6 date:@"07/06"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:304.0 date:@"07/07"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:304.6 date:@"07/08"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:303.4 date:@"07/11"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:301.8 date:@"07/12"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:299.8 date:@"07/13"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:298.0 date:@"07/14"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:296.4 date:@"07/15"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:293.4 date:@"07/19"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:292.0 date:@"07/20"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:290.8 date:@"07/21"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:291.6 date:@"07/22"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:291.6 date:@"07/25"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:293.8 date:@"07/26"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:293.4 date:@"07/27"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:291.6 date:@"07/28"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:288.0 date:@"07/29"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:286.0 date:@"08/01"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:281.6 date:@"08/02"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:277.4 date:@"08/03"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:274.2 date:@"08/04"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:269.8 date:@"08/05"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:263.8 date:@"08/08"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:259.2 date:@"08/09"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"08/10"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:253.4 date:@"08/11"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.2 date:@"08/12"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.0 date:@"08/15"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:251.4 date:@"08/16"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:250.8 date:@"08/17"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:250.0 date:@"08/18"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:248.0 date:@"08/19"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:245.0 date:@"08/22"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:243.8 date:@"08/23"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:241.0 date:@"08/24"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:240.2 date:@"08/25"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:241.0 date:@"08/26"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:243.0 date:@"08/29"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:245.8 date:@"08/30"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:250.2 date:@"08/31"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.8 date:@"09/01"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:253.8 date:@"09/02"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.8 date:@"09/05"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:248.4 date:@"09/06"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:243.4 date:@"09/07"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:239.6 date:@"09/08"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:240.6 date:@"09/09"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:243.8 date:@"09/12"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:248.6 date:@"09/13"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.0 date:@"09/14"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.0 date:@"09/15"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:255.8 date:@"09/16"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:255.4 date:@"09/20"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.6 date:@"09/21"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.6 date:@"09/22"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:253.8 date:@"09/26"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:251.6 date:@"09/27"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:252.6 date:@"09/28"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.4 date:@"09/29"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.0 date:@"09/30"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:259.6 date:@"10/03"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:258.6 date:@"10/04"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.0 date:@"10/05"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.8 date:@"10/06"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:253.8 date:@"10/07"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:253.2 date:@"10/11"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:255.0 date:@"10/12"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.2 date:@"10/13"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.0 date:@"10/14"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.4 date:@"10/17"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.8 date:@"10/18"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:257.4 date:@"10/19"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.6 date:@"10/20"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"10/21"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"10/24"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"10/25"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:255.8 date:@"10/26"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:255.6 date:@"10/27"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:254.8 date:@"10/28"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:251.8 date:@"10/31"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:248.2 date:@"11/01"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:244.4 date:@"11/02"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:241.4 date:@"11/04"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:238.2 date:@"11/07"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:235.0 date:@"11/08"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:235.2 date:@"11/09"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:235.0 date:@"11/10"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:232.8 date:@"11/11"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:231.8 date:@"11/14"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:232.2 date:@"11/15"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:230.0 date:@"11/16"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:229.8 date:@"11/17"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:230.2 date:@"11/18"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:230.6 date:@"11/21"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:231.6 date:@"11/22"]];
    [linedataMA5 addObject:[[CCSLineData alloc] initWithValue:231.2 date:@"11/24"]];


    CCSTitledLine *lineMA5 = [[CCSTitledLine alloc] init];
    lineMA5.data = linedataMA5;
    lineMA5.color = [UIColor cyanColor];
    lineMA5.title = @"MA5";

    NSMutableArray *linedataMA10 = [[NSMutableArray alloc] initWithCapacity:100];

    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:281.8 date:@"06/30"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:285.6 date:@"07/01"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:289.8 date:@"07/04"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:293.2 date:@"07/05"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:295.9 date:@"07/06"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:297.9 date:@"07/07"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:299.0 date:@"07/08"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:300.5 date:@"07/11"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:301.4 date:@"07/12"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:301.7 date:@"07/13"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:301.0 date:@"07/14"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:300.5 date:@"07/15"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:298.4 date:@"07/19"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:296.9 date:@"07/20"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:295.3 date:@"07/21"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:294.8 date:@"07/22"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:294.0 date:@"07/25"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:293.6 date:@"07/26"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:292.7 date:@"07/27"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:291.2 date:@"07/28"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:289.8 date:@"07/29"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:288.8 date:@"08/01"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:287.7 date:@"08/02"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:285.4 date:@"08/03"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:282.9 date:@"08/04"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:278.9 date:@"08/05"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:274.9 date:@"08/08"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:270.4 date:@"08/09"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:266.9 date:@"08/10"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:263.8 date:@"08/11"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:261.0 date:@"08/12"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:257.9 date:@"08/15"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.3 date:@"08/16"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:253.6 date:@"08/17"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:251.7 date:@"08/18"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:250.1 date:@"08/19"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"08/22"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.6 date:@"08/23"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:245.9 date:@"08/24"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:245.1 date:@"08/25"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:244.5 date:@"08/26"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:244.0 date:@"08/29"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:244.8 date:@"08/30"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:245.6 date:@"08/31"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:246.5 date:@"09/01"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.4 date:@"09/02"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.9 date:@"09/05"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.1 date:@"09/06"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:246.8 date:@"09/07"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:246.2 date:@"09/08"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.2 date:@"09/09"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:248.3 date:@"09/12"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"09/13"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:247.7 date:@"09/14"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:246.8 date:@"09/15"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:248.2 date:@"09/16"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:249.6 date:@"09/20"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:251.6 date:@"09/21"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:253.3 date:@"09/22"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:253.9 date:@"09/26"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:253.7 date:@"09/27"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:254.0 date:@"09/28"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:254.5 date:@"09/29"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.8 date:@"09/30"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.7 date:@"10/03"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.1 date:@"10/04"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:254.3 date:@"10/05"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:254.6 date:@"10/06"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.4 date:@"10/07"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.4 date:@"10/11"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.8 date:@"10/12"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.6 date:@"10/13"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.9 date:@"10/14"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.6 date:@"10/17"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.5 date:@"10/18"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.2 date:@"10/19"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.9 date:@"10/20"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.7 date:@"10/21"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.9 date:@"10/24"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:257.1 date:@"10/25"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.6 date:@"10/26"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:256.1 date:@"10/27"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:255.6 date:@"10/28"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:254.1 date:@"10/31"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:252.3 date:@"11/01"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:250.1 date:@"11/02"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:248.5 date:@"11/04"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:246.5 date:@"11/07"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:243.4 date:@"11/08"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:241.7 date:@"11/09"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:239.7 date:@"11/10"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:237.1 date:@"11/11"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:235.0 date:@"11/14"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:233.6 date:@"11/15"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:232.6 date:@"11/16"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:232.4 date:@"11/17"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:231.5 date:@"11/18"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:231.2 date:@"11/21"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:231.9 date:@"11/22"]];
    [linedataMA10 addObject:[[CCSLineData alloc] initWithValue:230.6 date:@"11/24"]];

    CCSTitledLine *lineMA10 = [[CCSTitledLine alloc] init];
    lineMA10.data = linedataMA10;
    lineMA10.color = [UIColor redColor];
    lineMA10.title = @"MA10";

    [linesdata addObject:lineMA5];
    [linesdata addObject:lineMA10];

    CCSMACandleStickChart *candleStickChart = [[CCSMACandleStickChart alloc] initWithFrame:CGRectMake(0, MARGIN_TOP, 320, 320)];

    candleStickChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    //设置stickData
    candleStickChart.stickData = candlestickData;
    candleStickChart.linesData = linesdata;
    candleStickChart.maxValue = 340;
    candleStickChart.minValue = 220;
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.displayLatitudeTitle = YES;
    candleStickChart.axisMarginBottom = 12;
    candleStickChart.maxSticksNum = 60;
    candleStickChart.axisMarginLeft = 30;
    candleStickChart.userInteractionEnabled = YES;
    candleStickChart.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:candleStickChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
