//
//  CCSGroupChart.h
//  Cocoa-Charts
//
//  Created by zhourr on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
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

#import "CCSGroupChart.h"

#import "CCSColoredStickChartData.h"
#import "CCSCandleStickChartData.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"
#import "CCSMACDData.h"

#import "ta_libc.h"
#import "CCSTALibUtils.h"
#import "CCSStringUtils.h"
#import "NSString+UserDefault.h"
#import "NSString+UIColor.h"

#import "NSArray+CCSTACompute.h"

#define WR_NONE_DISPLAY @"101"

#define AXIS_CALC_PARM  1000

#define HORIZONTAL_LEFT_RIGHT_SCALE                     6.0f

#define SOURCE_DATE_FORMAT                              @"yyyy-MM-ddHH:mm:ss"

@implementation CCSGroupChartData

- (id)initWithCCSOHLCVDDatas:(NSArray *)ohlcvdDatas{
    self = [super init];
    
    if (self) {
        self.ohlcvdDatas = ohlcvdDatas;
        self.candleStickData = [ohlcvdDatas convertCandleStickData];
        self.candleStickLinesData = [ohlcvdDatas convertCandleStickLinesData:-1 ma2:-1 ma3:-1];
        self.candleStickBollingerBandData = [ohlcvdDatas convertCandleStickBollingerBandData:-1];
        self.stickData = [ohlcvdDatas convertStickData];
        self.stickMAData = [ohlcvdDatas convertStickMAData:-1 ma2:-1 ma3:-1];
        self.macdStickData = [ohlcvdDatas convertMacdStickData:-1 l:-1 m:-1];
        self.kdjLinesData = [ohlcvdDatas convertKDJLinesData:-1];
        self.rsiLinesData = [ohlcvdDatas convertRSILinesData:-1 n2:-1];
        self.wrLinesData = [ohlcvdDatas convertWRLinesData:-1];
        self.cciLinesData = [ohlcvdDatas convertCCILinesData:-1];
        self.bollLinesData = [ohlcvdDatas convertBOLLLinesData:-1];
    }
    return self;
}

- (void)updateCandleStickLinesData:(NSInteger)ma1 ma2:(NSInteger)ma2 ma3:(NSInteger)ma3{
    self.candleStickLinesData = [self.ohlcvdDatas convertCandleStickLinesData:ma1 ma2:ma2 ma3:ma3];
}

- (void)updateCandleStickBollingerBandData:(NSInteger) bollN{
    self.candleStickBollingerBandData = [self.ohlcvdDatas convertCandleStickBollingerBandData:bollN];
}

- (void)updateMACDStickData:(NSInteger)macdS l:(NSInteger)macdL m:(NSInteger)macdM{
    self.macdStickData = [self.ohlcvdDatas convertMacdStickData:macdS l:macdL m:macdM];
}

- (void)updateKDJData:(NSInteger)kdjN{
    self.kdjLinesData = [self.ohlcvdDatas convertKDJLinesData:kdjN];
}

- (void)updateRSIData:(NSInteger) n1 n2:(NSInteger) n2{
    self.rsiLinesData = [self.ohlcvdDatas convertRSILinesData:n1 n2:n2];
}

- (void)updateWRData:(NSInteger) wrN{
    self.wrLinesData = [self.ohlcvdDatas computeWRData:wrN];
}

- (void)updateCCIData:(NSInteger) cciN{
    self.cciLinesData = [self.ohlcvdDatas convertCCILinesData:cciN];
}

- (void)updateBOLLData:(NSInteger) bollN{
    self.bollLinesData = [self.ohlcvdDatas convertBOLLLinesData:bollN];
}

@end

@interface CCSGroupChart (){
    /** 是否初始化 */
    BOOL                     _isInitialize;
    /** 是否需要重新加载 */
    BOOL                     _needsReload;
    /** 当前 view 大小 */
    CGSize                   _contentSize;
    UIView                  *_vSelected;
    
    /** 图表背景色 */
    UIColor                 *_chartsBackgroundColor;
    
    UILabel                 *_lblOpen;
    UILabel                 *_lblClose;
    UILabel                 *_lblHigh;
    UILabel                 *_lblLow;
    
    UILabel                 *_lblVOL;
    UILabel                 *_lblMACDLabel;
    UILabel                 *_lblMACD;
    UILabel                 *_lblKDJLabel;
    UILabel                 *_lblKDJ;
    UILabel                 *_lblRSI;
    UILabel                 *_lblWR;
    UILabel                 *_lblCCI;
    UILabel                 *_lblBOLL;
}

@end

@implementation CCSGroupChart

/*******************************************************************************
 * initialize
 *******************************************************************************/

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // 设置初始化标识
    _isInitialize = YES;
    
    self.orientationType = GroupChartverticalType;
}

/*******************************************************************************
 * Overrides From UIView
 *******************************************************************************/

- (void)layoutSubviews{
    [super layoutSubviews];
    // 初始化
    if (_isInitialize) {
        _isInitialize = NO;
        _contentSize = self.bounds.size;
        
        if (!_chartsBackgroundColor) {
            _chartsBackgroundColor = [UIColor clearColor];
        }
        
        [self initControllers];
        
        [self initCandleStickChart];
        [self initStickChart];
        [self initMACDChart];
        [self initKDJChart];
        [self initRSIChart];
        [self initWRChart];
        [self initCCIChart];
        [self initBOLLChart];
        
        self.scrollViewBottomChart.contentSize = CGSizeMake(self.scrollViewBottomChart.frame.size.width * 7, self.self.scrollViewBottomChart.frame.size.height);
        
//        //如果k线中已有数据，显示最后一根
//        if ([self.candleStickChart.stickData count] > 0) {
//            self.candleStickChart.selectedStickIndex = [self.candleStickChart.stickData count] - 1;
//            [self candleStickChartTouch:self];
//        }
    }
    // 刷新
    if (_needsReload) {
        _needsReload = NO;
        
        [self initCandleStickChartData];
        [self initStickChartData];
        [self initMACDChartData];
        [self initKDJChartData];
        [self initRSIChartData];
        [self initWRChartData];
        [self initCCIChartData];
        [self initBOLLChartData];
        
        CCSOHLCVDData *ohlcData = self.groupChartData.ohlcvdDatas[[self.groupChartData.ohlcvdDatas count] - 1];
        
        [_lblOpen setText: [[NSString stringWithFormat:@"%f", ohlcData.open/1000] decimal:0]];
        [_lblClose setText: [[NSString stringWithFormat:@"%f", ohlcData.close/1000] decimal:0]];
        [_lblHigh setText: [[NSString stringWithFormat:@"%f", ohlcData.high/1000] decimal:0]];
        [_lblLow setText: [[NSString stringWithFormat:@"%f", ohlcData.low/1000] decimal:0]];
        [_lblVOL setText:[[[NSString stringWithFormat:@"%f", ohlcData.vol/10000] decimal:2] append:@"万"]];
        NSString *macdL = [MACD_L getUserDefaultString];
        NSString *macdM = [MACD_M getUserDefaultString];
        NSString *macdS = [MACD_S getUserDefaultString];
        [_lblMACDLabel setText:[NSString stringWithFormat:@"MACD(%@,%@,%@):", macdL,macdM,macdS]];
        CCSMACDData *macdData = nil;
        @try {
            macdData = self.groupChartData.macdStickData[[self.groupChartData.macdStickData count] - 1];
        }
        @catch (NSException *exception) {
        }
        if (macdData) {
            NSString *strMACD = [NSString stringWithFormat:@"%@ DIF:%@ DEA:%@", [[NSString stringWithFormat:@"%f", macdData.macd] decimal:2], [[NSString stringWithFormat:@"%f", macdData.diff] decimal:2], [[NSString stringWithFormat:@"%f", macdData.dea] decimal:2]];
//            NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString: strMACD];
//            
//            [mutableStr addAttribute:NSForegroundColorAttributeName value:LINE_COLORS[0] range:NSMakeRange(0, [strMACD rangeOfString:@"DIF:"].location)];
//            
//            [mutableStr addAttribute:NSForegroundColorAttributeName value:LINE_COLORS[1] range:NSMakeRange([strMACD rangeOfString:@"DIF:"].location, [strMACD rangeOfString:@"DEA:"].location - 5)];
//            
//            [mutableStr addAttribute:NSForegroundColorAttributeName value:LINE_COLORS[2] range:NSMakeRange([strMACD rangeOfString:@"DEA:"].location, [strMACD rangeOfString:@"DEA:"].location - 4)];
            
            [_lblMACD setText:strMACD];
        }else{
            [_lblMACD setText:[NSString stringWithFormat:@"0.0f DIF:%f DEA:%f", 0.0f, 0.0f]];
        }
        NSString *KDJN = [KDJ_N getUserDefaultString];
        [_lblKDJLabel setText:[NSString stringWithFormat:@"KDJ(%@,3,3):", KDJN]];
        
        NSMutableArray *kdjData = [[NSMutableArray alloc] init];
        [self.groupChartData.kdjLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CCSTitledLine *line = self.groupChartData.kdjLinesData[idx];
            CCSLineData *lineData = line.data[[[line data] count] - 1];
            NSString *kdj = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
            [kdjData addObject:kdj];
        }];
        if (kdjData && [kdjData count] == 3) {
            [_lblKDJ setText:[NSString stringWithFormat:@"K:%@ D:%@ J:%@", kdjData[0], kdjData[1], kdjData[2]]];
        }else{
            [_lblKDJ setText:[NSString stringWithFormat:@"K:%@ D:%@ J:%@", @"0.00", @"0.00", @"0.00"]];
        }
        
        NSString *rsiN1 = [RSI_N1 getUserDefaultString];
        NSString *rsiN2 = [RSI_N2 getUserDefaultString];
        
        NSMutableArray *rsiData = [[NSMutableArray alloc] init];
        [self.groupChartData.rsiLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CCSTitledLine *line = self.groupChartData.rsiLinesData[idx];
            CCSLineData *lineData = line.data[[[line data] count] - 1];
            NSString *rsi = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
            [rsiData addObject:rsi];
        }];
        if (rsiData && [rsiData count] == 3) {
            [_lblRSI setText:[NSString stringWithFormat:@"RSI%@: %@ RSI%@: %@ RSI24: %@", rsiN1, rsiData[0], rsiN2, rsiData[1], rsiData[2]]];
        }else{
            [_lblRSI setText:[NSString stringWithFormat:@"RSI%@: %@ RSI%@: %@ RSI24: %@", rsiN1, @"0.00", rsiN2, @"0.00", @"0.00"]];
        }
        
        NSString *wrN = [WR_N getUserDefaultString];
        if (self.groupChartData.wrLinesData && [self.groupChartData.wrLinesData count] > 0) {
            CCSTitledLine *wrLine = self.groupChartData.wrLinesData[0];
            CCSLineData *wrLineData = wrLine.data[[[wrLine data] count] - 1];
            NSString *wr = [[NSString stringWithFormat:@"%f", wrLineData.value] decimal:2];
            
            [_lblWR setText:[NSString stringWithFormat:@"WR(%@): %@", wrN, wr]];
        }else{
            [_lblWR setText:[NSString stringWithFormat:@"WR(%@): %@", wrN, @"0.00"]];
        }
        
        NSString *cciN = [CCI_N getUserDefaultString];
        if (self.groupChartData.cciLinesData && [self.groupChartData.cciLinesData count] > 0) {
            CCSTitledLine *cciLine = self.groupChartData.cciLinesData[0];
            CCSLineData *cciLineData = cciLine.data[[[cciLine data] count] - 1];
            NSString *cci = [[NSString stringWithFormat:@"%f", cciLineData.value] decimal:2];
            
            [_lblCCI setText:[NSString stringWithFormat:@"CCI(%@): %@", cciN, cci]];
        }else{
            [_lblCCI setText:[NSString stringWithFormat:@"CCI(%@): %@", cciN, @"0.00"]];
        }
        
        NSString *bollN = [BOLL_N getUserDefaultString];
        
        NSMutableArray *bollData = [[NSMutableArray alloc] init];
        [self.groupChartData.bollLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CCSTitledLine *line = self.groupChartData.bollLinesData[idx];
            CCSLineData *lineData = line.data[[[line data] count] - 1];
            NSString *boll = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
            [bollData addObject:boll];
        }];
        if (bollData && [bollData count] == 3) {
            [_lblBOLL setText:[NSString stringWithFormat:@"BOLL(%@,2,2): %@, %@, %@", bollN, bollData[0], bollData[1], bollData[2]]];
        }else{
            [_lblBOLL setText:[NSString stringWithFormat:@"BOLL(%@,2,2): %@, %@, %@", bollN, @"0.00", @"0.00", @"0.00"]];
        }
    }
}

/*******************************************************************************
* Implements Of UIScrollViewDelegate
*******************************************************************************/

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // 得到每页宽度
    CGFloat pageWidth = sender.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int page = (int) floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    //判断是否page发生了变更
    if (self.segBottomChartType.selectedSegmentIndex != page) {
        //设置pageControl
        self.segBottomChartType.selectedSegmentIndex = page;
        [self.segBottomChartType setNeedsDisplay];
    }
}

/*******************************************************************************
 * Implements Of CCSChartDelegate
 *******************************************************************************/

- (void)CCSChartBeTouchedOn:(id)chart point:(CGPoint)point indexAt:(NSUInteger)index {
    
    if ([chart isKindOfClass:[self.candleStickChart class]]) {
        
        if (0 == self.segBottomChartType.selectedSegmentIndex) {
            self.stickChart.singleTouchPoint = point;
            self.stickChart.selectedStickIndex = index;
            [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
            self.macdChart.singleTouchPoint = point;
            self.macdChart.selectedStickIndex = index;
            [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
            self.kdjChart.singleTouchPoint = point;
            [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
            self.rsiChart.singleTouchPoint = point;
            [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
            self.wrChart.singleTouchPoint = point;
            [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
            self.cciChart.singleTouchPoint = point;
            [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
            self.bollChart.singleTouchPoint = point;
            [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        }
    }else{
        self.stickChart.singleTouchPoint = point;
        self.stickChart.selectedStickIndex = index;
        [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
    }
}

- (void)CCSChartDisplayChangedFrom:(id)chart from:(NSUInteger)from number:(NSUInteger)number{
    
    if ([chart isKindOfClass:[self.candleStickChart class]]) {
        if (0 == self.segBottomChartType.selectedSegmentIndex) {
            self.stickChart.displayFrom = from;
            self.stickChart.displayNumber = number;
            [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
            self.macdChart.displayFrom = from;
            self.macdChart.displayNumber = number;
            [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
            self.kdjChart.displayFrom = from;
            self.kdjChart.displayNumber = number;
            [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
            self.rsiChart.displayFrom = from;
            self.rsiChart.displayNumber = number;
            [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
            self.wrChart.displayFrom = from;
            self.wrChart.displayNumber = number;
            [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
            self.cciChart.displayFrom = from;
            self.cciChart.displayNumber = number;
            [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
            self.bollChart.displayFrom = from;
            self.bollChart.displayNumber = number;
            [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        }
        
    }else{
        self.candleStickChart.displayFrom = from;
        self.candleStickChart.displayNumber = number;
        [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
    }
}

/*******************************************************************************
* Public Methods
*******************************************************************************/

- (void)setGroupChartData:(CCSGroupChartData *) groupChartData{
    _groupChartData = groupChartData;
    
    _needsReload = YES;
    [self setNeedsLayout];
}

- (void)setChartData:(NSMutableArray *)chartData{
    _chartData = chartData;
    
    _needsReload = YES;
    [self setNeedsLayout];
}

- (void)setChartDelegate:(UIViewController<CCSChartDelegate> *)chartDelegate{
    _chartDelegate = chartDelegate;
}

- (void)setChartsBackgroundColor:(UIColor *)backgroundColor{
    _chartsBackgroundColor = backgroundColor;
}

- (void)updateCandleStickChart{
    [self initCandleStickChartData];
}

- (void)updateMACDChart{
    [self initMACDChartData];
}

- (void)updateKDJChart{
    [self initKDJChartData];
}

- (void)updateRSIChart{
    [self initRSIChartData];
}

- (void)updateWRChart{
    [self initWRChartData];
}

- (void)updateCCIChart{
    [self initCCIChartData];
}

- (void)updateBOLLChart{
    [self initBOLLChartData];
}

/*******************************************************************************
* Private Methods
*******************************************************************************/

- (void)initControllers {
    [self setBackgroundColor:_chartsBackgroundColor];
    
    // 横屏
    if (self.orientationType == GroupChartHorizontalType) {
        UISegmentedControl *segBottomChartType = [[UISegmentedControl alloc] initWithItems:@[@"VOL", @"MACD", @"KDJ", @"RSI", @"WR", @"CCI", @"BOLL", @""]];
        segBottomChartType.frame = CGRectMake(_contentSize.width - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE - (_contentSize.height - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE)/2.0f, (_contentSize.height - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE)/2.0f,  _contentSize.height, _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE);
        [segBottomChartType addTarget:self action:@selector(segBottomChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
        [segBottomChartType setSelectedSegmentIndex:0];
        // 设置颜色
        segBottomChartType.tintColor = _chartsBackgroundColor;
        [segBottomChartType setBackgroundColor:_chartsBackgroundColor];
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],
                                                 NSForegroundColorAttributeName: [@"#23423F" str2Color]};
        [segBottomChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],
                                                   NSForegroundColorAttributeName: [UIColor lightGrayColor]};
        [segBottomChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        // 旋转90度
        [segBottomChartType setTransform:CGAffineTransformMakeRotation(90 *M_PI / 180.0)];
        // UISegmentedControl每个item 旋转 270 度
        for (UIView *subview in [segBottomChartType subviews]) {
            [subview setTransform:CGAffineTransformMakeRotation(270 *M_PI / 180.0)];
        }
        
        self.segBottomChartType = segBottomChartType;
        
        [self addSubview:segBottomChartType];
        
        UIButton *btnChartHorizontal = [[UIButton alloc] init];
        [btnChartHorizontal setFrame:CGRectMake(_contentSize.width - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE , _contentSize.height - _contentSize.height/8.0f, _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE, _contentSize.height/8.0f)];
        [btnChartHorizontal.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [btnChartHorizontal setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnChartHorizontal setTitle:@"设置" forState:UIControlStateNormal];
        [btnChartHorizontal addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnChartHorizontal];
    }else{
        NSArray *arraySegItems = @[@"VOL", @"MACD", @"KDJ", @"RSI", @"WR", @"CCI", @"BOLL"];
        
        UISegmentedControl *segBottomChartType = [[UISegmentedControl alloc] initWithItems: arraySegItems];
        segBottomChartType.frame = CGRectMake(0.0f, _contentSize.height - 34.0f,  _contentSize.width - 50.0f, 33.0f);
        [segBottomChartType addTarget:self action:@selector(segBottomChartTypeTypeValueChaged:) forControlEvents:UIControlEventValueChanged];
        [segBottomChartType setSelectedSegmentIndex:0];
        // 设置颜色
        segBottomChartType.tintColor = _chartsBackgroundColor;
        [segBottomChartType setBackgroundColor:_chartsBackgroundColor];
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                                 NSForegroundColorAttributeName: [@"#23423F" str2Color]};
        [segBottomChartType setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
                                                   NSForegroundColorAttributeName: [UIColor lightGrayColor]};
        [segBottomChartType setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        
        self.segBottomChartType = segBottomChartType;
        
        [self addSubview:segBottomChartType];
        
        UIButton *btnChartHorizontal = [[UIButton alloc] init];
        [btnChartHorizontal setFrame:CGRectMake(segBottomChartType.frame.size.width, segBottomChartType.frame.origin.y, _contentSize.width - segBottomChartType.frame.size.width, segBottomChartType.frame.size.height)];
        [btnChartHorizontal.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [btnChartHorizontal setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btnChartHorizontal setTitle:@"设置" forState:UIControlStateNormal];
        [btnChartHorizontal addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnChartHorizontal];
        
        _vSelected = [[UIView alloc] init];
        [_vSelected setFrame:CGRectMake(0.0f, segBottomChartType.frame.origin.y + segBottomChartType.frame.size.height - 3.0f, segBottomChartType.frame.size.width/[arraySegItems count], 1.0f)];
        [_vSelected setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:_vSelected];
    }
    
    UIScrollView *scrollViewBottomChart = [[UIScrollView alloc] init];
    
    if (self.orientationType == GroupChartHorizontalType) {
        scrollViewBottomChart.frame = CGRectMake(0.0f, _contentSize.height/3.0f*2 - 1.0f, _contentSize.width - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE,  _contentSize.height/3.0f);
    }else{
        scrollViewBottomChart.frame = CGRectMake(0.0f, (_contentSize.height - 33.0f)/3.0f*2 - 1.0f, _contentSize.width,  (_contentSize.height - 33.0f)/3.0f);
    }
    
    scrollViewBottomChart.bounces = NO;
    scrollViewBottomChart.contentSize = CGSizeMake(_contentSize.width * 6, (_contentSize.height - 33.0f)/3.0f);
    scrollViewBottomChart.pagingEnabled = YES;
    scrollViewBottomChart.delegate = self;
    [scrollViewBottomChart setScrollEnabled:NO];
    
    // 设置单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [scrollViewBottomChart addGestureRecognizer:tap];

    self.scrollViewBottomChart = scrollViewBottomChart;
    [self addSubview:scrollViewBottomChart];
}

- (void)initCandleStickChart {
    CCSBOLLMASlipCandleStickChart *candleStickChart = nil;
    
    if (self.orientationType == GroupChartHorizontalType) {
        candleStickChart = [[CCSBOLLMASlipCandleStickChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _contentSize.width - _contentSize.width/HORIZONTAL_LEFT_RIGHT_SCALE, _contentSize.height/3.0f * 2.0f)];
    }else{
        candleStickChart = [[CCSBOLLMASlipCandleStickChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _contentSize.width, (_contentSize.height - 33.0f)/3.0f * 2.0f)];
    }
    
    self.candleStickChart = candleStickChart;
    [self initCandleStickChartData];
    
    //设置stickData
    candleStickChart.maxValue = 340;
    candleStickChart.minValue = 240;
    candleStickChart.axisCalc = 1;
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.displayLatitudeTitle  = YES;
    candleStickChart.userInteractionEnabled = YES;
    
//    candleStickChart.positiveStickBorderColor = [@"#ED4D4D" str2Color];
//    candleStickChart.negativeStickFillColor = [@"#52BA27" str2Color];
    candleStickChart.positiveStickBorderColor = LINE_COLORS[0];
    candleStickChart.positiveStickFillColor = LINE_COLORS[0];
    candleStickChart.negativeStickBorderColor = LINE_COLORS[1];
    candleStickChart.negativeStickFillColor = LINE_COLORS[1];
    
//    candleStickChart.candleStickStyle = GroupCandleStickChartTypeBar;
//    candleStickChart.axisYPosition = CCSGridChartYAxisPositionRight;
//    candleStickChart.displayNumber = 50;
//    candleStickChart.displayFrom = 0;
    candleStickChart.bollingerBandStyle = CCSBollingerBandStyleNone;
    candleStickChart.axisCalc = AXIS_CALC_PARM;
    candleStickChart.latitudeNum = 3;
    
    // 边框颜色
    candleStickChart.displayLongitudeTitle = YES;
    candleStickChart.axisMarginBottom = 15.0f;
    
    candleStickChart.chartDelegate = self.chartDelegate;
    
    self.candleStickChart.backgroundColor = _chartsBackgroundColor;
    
    [candleStickChart addTarget:self action:@selector(candleStickChartTouch:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self addSubview:candleStickChart];
    
    UIView *vOhlcContainer = [[UIView alloc] init];
    [vOhlcContainer setFrame:CGRectMake(0.0f, 0.0f, candleStickChart.frame.size.width, 30.0f)];
    [vOhlcContainer setBackgroundColor:[UIColor clearColor]];
    [self addSubview:vOhlcContainer];
    
    UILabel *lblOpenLabel = [[UILabel alloc] init];
    [lblOpenLabel setFrame:CGRectMake(0.0f, 8.0f, 15.0f, vOhlcContainer.frame.size.height)];
    [lblOpenLabel setTextColor:[UIColor lightGrayColor]];
    [lblOpenLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblOpenLabel setText:@"开:"];
    [vOhlcContainer addSubview:lblOpenLabel];
    UILabel *lblOpen = [[UILabel alloc] init];
    [lblOpen setFrame:CGRectMake(lblOpenLabel.frame.size.width+3.0f, 8.0f, 35.0f, vOhlcContainer.frame.size.height)];
    [lblOpen setTextColor:[UIColor lightGrayColor]];
    [lblOpen setFont:[UIFont systemFontOfSize:11.0f]];
    [lblOpen setText:@"0.0"];
    [vOhlcContainer addSubview:lblOpen];
    _lblOpen = lblOpen;
    
    UILabel *lblCloseLabel = [[UILabel alloc] init];
    [lblCloseLabel setFrame:CGRectMake(lblOpen.frame.origin.x + lblOpen.frame.size.width, 8.0f, lblOpenLabel.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblCloseLabel setTextColor:[UIColor lightGrayColor]];
    [lblCloseLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblCloseLabel setText:@"收:"];
    [vOhlcContainer addSubview:lblCloseLabel];
    UILabel *lblClose = [[UILabel alloc] init];
    [lblClose setFrame:CGRectMake(lblCloseLabel.frame.origin.x + lblCloseLabel.frame.size.width, 8.0f, lblOpen.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblClose setTextColor:[UIColor lightGrayColor]];
    [lblClose setFont:[UIFont systemFontOfSize:11.0f]];
    [lblClose setText:@"0.0"];
    [vOhlcContainer addSubview:lblClose];
    _lblClose = lblClose;
    
    UILabel *lblHighLabel = [[UILabel alloc] init];
    [lblHighLabel setFrame:CGRectMake(lblClose.frame.origin.x + lblClose.frame.size.width, 8.0f, lblOpenLabel.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblHighLabel setTextColor:[UIColor lightGrayColor]];
    [lblHighLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblHighLabel setText:@"高:"];
    [vOhlcContainer addSubview:lblHighLabel];
    UILabel *lblHigh = [[UILabel alloc] init];
    [lblHigh setFrame:CGRectMake(lblHighLabel.frame.origin.x + lblHighLabel.frame.size.width, 8.0f, lblOpen.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblHigh setTextColor:[UIColor lightGrayColor]];
    [lblHigh setFont:[UIFont systemFontOfSize:11.0f]];
    [lblHigh setText:@"0.0"];
    [vOhlcContainer addSubview:lblHigh];
    _lblHigh = lblHigh;
    
    UILabel *lblLowLabel = [[UILabel alloc] init];
    [lblLowLabel setFrame:CGRectMake(lblHigh.frame.origin.x + lblHigh.frame.size.width, 8.0f, lblOpenLabel.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblLowLabel setTextColor:[UIColor lightGrayColor]];
    [lblLowLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblLowLabel setText:@"低:"];
    [vOhlcContainer addSubview:lblLowLabel];
    UILabel *lblLow = [[UILabel alloc] init];
    [lblLow setFrame:CGRectMake(lblLowLabel.frame.origin.x + lblLowLabel.frame.size.width, 8.0f, lblOpen.frame.size.width, vOhlcContainer.frame.size.height)];
    [lblLow setTextColor:[UIColor lightGrayColor]];
    [lblLow setFont:[UIFont systemFontOfSize:11.0f]];
    [lblLow setText:@"0.0"];
    [vOhlcContainer addSubview:lblLow];
    _lblLow = lblLow;
}

- (void)initCandleStickChartData {
    if (self.groupChartData) {
        self.candleStickChart.stickData = self.groupChartData.candleStickData;
        self.candleStickChart.linesData = self.groupChartData.candleStickLinesData;
        self.candleStickChart.bollingerBandData = self.groupChartData.candleStickBollingerBandData;
        
//        self.candleStickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.candleStickChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
        
        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
            CCSOHLCVDData *item = [self.chartData objectAtIndex:i];
            CCSCandleStickChartData *stickData = [[CCSCandleStickChartData alloc] init];
//            stickData.open = [item.open doubleValue];
//            stickData.high = [item.high doubleValue];
//            stickData.low = [item.low doubleValue];
//            stickData.close = [item.close doubleValue];
            stickData.open = item.open;
            stickData.high = item.high;
            stickData.low = item.low;
            stickData.close = item.close;
            stickData.change = 0;
            stickData.date = [item.date dateWithFormat:@"yyyy-MM-dd HH:mm:ss" target:@"yy-MM-dd"];
            // 增加数据
            [stickDatas addObject:stickData];
        }
        NSMutableArray *maLines = [[NSMutableArray alloc] init];
        [maLines addObject: [self.chartData computeMAData:5]];
        [maLines addObject: [self.chartData computeMAData:25]];
        
        self.candleStickChart.stickData = stickDatas;
        self.candleStickChart.linesData = maLines;
        self.candleStickChart.bollingerBandData = [self.chartData computeBOLLData:20 optInNbDevUp:2 optInNbDevDn:2];
        
        self.candleStickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.candleStickChart setNeedsDisplay];
    }
}

- (void)initStickChart {
    CCSMAColoredStickChart *stickchart = [[CCSMAColoredStickChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    stickchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.stickChart = stickchart;
    
    //初始化数据
    [self initStickChartData];
    
    //设置stickData
    self.stickChart.maxValue = 800000;
    self.stickChart.minValue = 0;
    self.stickChart.stickFillColor = [UIColor colorWithRed:0.7 green:0.7 blue:0 alpha:0.8];
    
//    self.stickChart.displayNumber = 50;
//    self.stickChart.displayFrom = 0;
    self.stickChart.displayLongitudeTitle = NO;
    self.stickChart.axisMarginBottom = 3;
    
    self.stickChart.chartDelegate = self.chartDelegate;
    self.stickChart.backgroundColor = _chartsBackgroundColor;
    
    [self.scrollViewBottomChart addSubview:self.stickChart];
    
    UIView *vVOLContainer = [[UIView alloc] init];
    [vVOLContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vVOLContainer setBackgroundColor:[UIColor clearColor]];
    [self.stickChart addSubview:vVOLContainer];
    
    UILabel *lblVOLLabel = [[UILabel alloc] init];
    [lblVOLLabel setFrame:CGRectMake(0.0f, 8.0f, 30.0f, vVOLContainer.frame.size.height)];
    [lblVOLLabel setTextColor:[UIColor lightGrayColor]];
    [lblVOLLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblVOLLabel setText:@"VOL:"];
    [vVOLContainer addSubview:lblVOLLabel];
    UILabel *lblVOL = [[UILabel alloc] init];
    [lblVOL setFrame:CGRectMake(lblVOLLabel.frame.size.width+3.0f, 8.0f, vVOLContainer.frame.size.width, vVOLContainer.frame.size.height)];
    [lblVOL setTextColor:[UIColor lightGrayColor]];
    [lblVOL setFont:[UIFont systemFontOfSize:11.0f]];
    [lblVOL setText:@"0.0"];
    [vVOLContainer addSubview:lblVOL];
    _lblVOL = lblVOL;
}

- (void)initStickChartData {
    if (self.groupChartData) {
        self.stickChart.stickData = self.groupChartData.stickData;
        self.stickChart.linesData = self.groupChartData.stickMAData;
//        self.stickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.stickChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
        
        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
            CCSOHLCVDData *item = [self.chartData objectAtIndex:i];
            CCSColoredStickChartData *stickData = [[CCSColoredStickChartData alloc] init];
//            stickData.high = [item.vol doubleValue];
            stickData.high = item.vol;
            stickData.low = 0;
            stickData.date = [item.date dateWithFormat:@"yyyy-MM-dd HH:mm:ss" target:@"yy-MM-dd"];
            
//            if ([item.close doubleValue] > [item.open doubleValue]) {
//                stickData.fillColor = [UIColor clearColor];
//                stickData.borderColor = [UIColor redColor];
//            } else if ([item.close doubleValue] < [item.open doubleValue]) {
//                stickData.fillColor = [UIColor greenColor];
//                stickData.borderColor = [UIColor clearColor];
//            } else {
//                stickData.fillColor = [UIColor lightGrayColor];
//                stickData.borderColor = [UIColor clearColor];
//            }
            if (item.close > item.open) {
                stickData.fillColor = [UIColor clearColor];
                stickData.borderColor = [UIColor redColor];
            } else if (item.close < item.open) {
                stickData.fillColor = [UIColor greenColor];
                stickData.borderColor = [UIColor clearColor];
            } else {
                stickData.fillColor = [UIColor lightGrayColor];
                stickData.borderColor = [UIColor clearColor];
            }
            //增加数据
            [stickDatas addObject:stickData];
        }
        
        self.stickChart.stickData = stickDatas;
        self.stickChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.stickChart setNeedsDisplay];
    }
}

- (void)initMACDChart {
    CCSMACDChart *macdchart = [[CCSMACDChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    macdchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.macdChart = macdchart;
    
    //初始化数据
    [self initMACDChartData];
    
    //设置stickData
    self.macdChart.stickFillColor = [UIColor colorWithRed:0.7 green:0.7 blue:0 alpha:0.8];
    self.macdChart.positiveStickStrokeColor = [@"#ED4D4D" str2Color];
    self.macdChart.positiveStickFillColor = [@"#ED4D4D" str2Color];
    self.macdChart.negativeStickStrokeColor = [@"#52BA27" str2Color];
    self.macdChart.negativeStickFillColor = [@"#52BA27" str2Color];
    
//    self.macdChart.maxValue = 300000;
//    self.macdChart.minValue = -300000;
//    self.macdChart.maxSticksNum = 100;
//    self.macdChart.macdDisplayType = CCSMACDChartDisplayTypeStick;
//    self.macdChart.positiveStickColor = [UIColor redColor];
//    self.macdChart.negativeStickColor = [UIColor greenColor];
    self.macdChart.macdLineColor = LINE_COLORS[0];
    self.macdChart.deaLineColor = LINE_COLORS[1];
    self.macdChart.diffLineColor = LINE_COLORS[2];
//    self.macdChart.displayNumber = 50;
//    self.macdChart.displayFrom = 0;
    self.macdChart.axisCalc = AXIS_CALC_PARM;
    self.macdChart.displayLongitudeTitle = NO;
    self.macdChart.axisMarginBottom = 3;
    
    self.macdChart.chartDelegate = self.chartDelegate;
    self.macdChart.backgroundColor = _chartsBackgroundColor;
    
    [self.scrollViewBottomChart addSubview:self.macdChart];
    
    UIView *vMACDContainer = [[UIView alloc] init];
    [vMACDContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vMACDContainer setBackgroundColor:[UIColor clearColor]];
    [self.macdChart addSubview:vMACDContainer];
    
    UILabel *lblMACDLabel = [[UILabel alloc] init];
    [lblMACDLabel setFrame:CGRectMake(0.0f, 8.0f, 100.0f, vMACDContainer.frame.size.height)];
    [lblMACDLabel setTextColor:[UIColor lightGrayColor]];
    [lblMACDLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblMACDLabel setText:@"MACD(9,12,26):"];
    [vMACDContainer addSubview:lblMACDLabel];
    _lblMACDLabel = lblMACDLabel;
    UILabel *lblMACD = [[UILabel alloc] init];
    [lblMACD setFrame:CGRectMake(lblMACDLabel.frame.size.width+3.0f, 8.0f, vMACDContainer.frame.size.width, vMACDContainer.frame.size.height)];
    [lblMACD setTextColor:[UIColor lightGrayColor]];
    [lblMACD setFont:[UIFont systemFontOfSize:11.0f]];
    [lblMACD setText:@"-0.0 DIF:-0.0 DEA:-0.0"];
    [vMACDContainer addSubview:lblMACD];
    _lblMACD = lblMACD;
}

- (void)initMACDChartData {
    if (self.groupChartData) {
        self.macdChart.stickData = self.groupChartData.macdStickData;
        
        [self.macdChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
//        NSMutableArray *stickDatas = [[NSMutableArray alloc] initWithCapacity:[self.chartData count]];
//        for (NSInteger i = [self.chartData count] - 1; i >= 0; i--) {
//            OHLCVDGroupData *item = [self.chartData objectAtIndex:i];
//            CCSCandleStickChartData *stickData = [[CCSCandleStickChartData alloc] init];
//            stickData.open = [item.open doubleValue];
//            stickData.high = [item.high doubleValue];
//            stickData.low = [item.low doubleValue];
//            stickData.close = [item.close doubleValue];
//            stickData.change = 0;
//            stickData.date = [item.date dateWithFormat:@"yyyy-MM-ddHH:mm:ss" target:@"yy-MM-dd"];
//            //增加数据
//            [stickDatas addObject:stickData];
//        }
        
        self.macdChart.stickData = [self.chartData computeMACDData:12 optInSlowPeriod:26 optInSignalPeriod:9];
//        self.macdChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.macdChart setNeedsDisplay];
    }
}

- (void)initKDJChart {
    CCSSlipLineChart *kdjchart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 2, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    kdjchart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.kdjChart = kdjchart;
    
    //初始化数据
    [self initKDJChartData];
    
    //设置stickData
//    self.kdjChart.displayNumber = 50;
//    self.kdjChart.displayFrom = 0;
    self.kdjChart.latitudeNum = 2;
    self.kdjChart.displayLongitudeTitle = NO;
    self.kdjChart.axisMarginBottom = 3;
    
    self.kdjChart.autoCalcRange = NO;
    self.kdjChart.maxValue = 120;
    self.kdjChart.minValue = -20;
    
    self.kdjChart.chartDelegate = self.chartDelegate;
    self.kdjChart.backgroundColor = _chartsBackgroundColor;
    
    [self.scrollViewBottomChart addSubview:self.kdjChart];
    
    UIView *vKDJContainer = [[UIView alloc] init];
    [vKDJContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vKDJContainer setBackgroundColor:[UIColor clearColor]];
    [self.kdjChart addSubview:vKDJContainer];
    
    UILabel *lblKDJLabel = [[UILabel alloc] init];
    [lblKDJLabel setFrame:CGRectMake(0.0f, 8.0f, 80.0f, vKDJContainer.frame.size.height)];
    [lblKDJLabel setTextColor:[UIColor lightGrayColor]];
    [lblKDJLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [lblKDJLabel setText:@"KDJ(9,3,3):"];
    [vKDJContainer addSubview:lblKDJLabel];
    _lblKDJLabel = lblKDJLabel;
    UILabel *lblKDJ = [[UILabel alloc] init];
    [lblKDJ setFrame:CGRectMake(lblKDJLabel.frame.size.width+3.0f, 8.0f, vKDJContainer.frame.size.width, vKDJContainer.frame.size.height)];
    [lblKDJ setTextColor:[UIColor lightGrayColor]];
    [lblKDJ setFont:[UIFont systemFontOfSize:11.0f]];
    [lblKDJ setText:@"DIF:-0.0 DEA:-0.0"];
    [vKDJContainer addSubview:lblKDJ];
    _lblKDJ = lblKDJ;
}

- (void)initKDJChartData {
    if (self.groupChartData) {
        self.kdjChart.linesData = self.groupChartData.kdjLinesData;
//        self.kdjChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.kdjChart.maxValue = 120;
        self.kdjChart.minValue = -20;
        
        [self.kdjChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        
        self.kdjChart.linesData = [self.chartData computeKDJData:9 optInSlowK_Period:3 optInSlowD_Period:3];
        self.kdjChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.kdjChart.maxValue = 120;
        self.kdjChart.minValue = -20;
        
        [self.kdjChart setNeedsDisplay];
    }
}

- (void)initRSIChart {
    CCSSlipLineChart *rsiChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 3, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    rsiChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.rsiChart = rsiChart;
    
    //初始化数据
    [self initRSIChartData];
    
    //设置stickData
//    self.rsiChart.displayNumber = 50;
//    self.rsiChart.displayFrom = 0;
    self.rsiChart.displayLongitudeTitle = NO;
    self.rsiChart.axisMarginBottom = 3;
    
    self.rsiChart.autoCalcRange = NO;
    self.rsiChart.maxValue = 100;
    self.rsiChart.minValue = 0;
    
    self.rsiChart.chartDelegate = self.chartDelegate;
    self.rsiChart.backgroundColor = _chartsBackgroundColor;
    
    [self.scrollViewBottomChart addSubview:self.rsiChart];
    
    UIView *vRSIContainer = [[UIView alloc] init];
    [vRSIContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vRSIContainer setBackgroundColor:[UIColor clearColor]];
    [self.rsiChart addSubview:vRSIContainer];
    
    UILabel *lblRSI = [[UILabel alloc] init];
    [lblRSI setFrame:CGRectMake(0.0f, 8.0f, vRSIContainer.frame.size.width, vRSIContainer.frame.size.height)];
    [lblRSI setTextColor:[UIColor lightGrayColor]];
    [lblRSI setFont:[UIFont systemFontOfSize:11.0f]];
    [lblRSI setText:@"RSI6: 0.00 RSI12:0.00"];
    [vRSIContainer addSubview:lblRSI];
    _lblRSI = lblRSI;
}

- (void)initRSIChartData {
    if (self.groupChartData) {
        self.rsiChart.linesData = self.groupChartData.rsiLinesData;
//        self.rsiChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.rsiChart.maxValue = 100;
        self.rsiChart.minValue = 0;
        
        [self.rsiChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        
        NSMutableArray *linesData = [[NSMutableArray alloc] init];
        [linesData addObject:[self.chartData computeRSIData:6]];
        [linesData addObject:[self.chartData computeRSIData:12]];
        [linesData addObject:[self.chartData computeRSIData:24]];
        
        self.rsiChart.linesData = linesData;
        self.rsiChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.rsiChart.maxValue = 100;
        self.rsiChart.minValue = 0;
        
        [self.rsiChart setNeedsDisplay];
    }
}

- (void)initWRChart {
    CCSSlipLineChart *wrChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 4, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    wrChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.wrChart = wrChart;
    
    //初始化数据
    [self initWRChartData];
    
    //设置stickData
//    self.wrChart.displayNumber = 50;
//    self.wrChart.displayFrom = 0;
    self.wrChart.noneDisplayValues = [NSMutableArray arrayWithObjects:WR_NONE_DISPLAY,nil];
    self.wrChart.displayLongitudeTitle = NO;
    self.wrChart.axisMarginBottom = 3;
    
    self.wrChart.autoCalcRange = NO;
    self.wrChart.maxValue = 100;
    self.wrChart.minValue = 0;
    
    self.wrChart.chartDelegate = self.chartDelegate;
    self.wrChart.backgroundColor = _chartsBackgroundColor;
    // self.wrChart.noneDisplayValue = 9999;
    
    [self.scrollViewBottomChart addSubview:self.wrChart];
    
    UIView *vWRContainer = [[UIView alloc] init];
    [vWRContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vWRContainer setBackgroundColor:[UIColor clearColor]];
    [self.wrChart addSubview:vWRContainer];
    
    UILabel *lblWR = [[UILabel alloc] init];
    [lblWR setFrame:CGRectMake(0.0f, 8.0f, vWRContainer.frame.size.width, vWRContainer.frame.size.height)];
    [lblWR setTextColor:[UIColor lightGrayColor]];
    [lblWR setFont:[UIFont systemFontOfSize:11.0f]];
    [lblWR setText:@"WR(10): 0.00"];
    [vWRContainer addSubview:lblWR];
    _lblWR = lblWR;
}

- (void)initWRChartData {
    if (self.groupChartData) {
        self.wrChart.linesData = self.groupChartData.wrLinesData;
//        self.wrChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.wrChart.maxValue = 0;
        self.wrChart.minValue = -100;
        
        [self.wrChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        self.wrChart.linesData = [self.chartData computeWRData:6];
        self.wrChart.singleTouchPoint = CGPointMake(-1, -1);
        
        self.wrChart.maxValue = 100;
        self.wrChart.minValue = 0;
        
        [self.wrChart setNeedsDisplay];
    }
}

- (void)initCCIChart {
    CCSSlipLineChart *cciChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 5, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    cciChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.cciChart = cciChart;
    
    //初始化数据
    [self initCCIChartData];
    
    //设置stickData
//    self.cciChart.displayNumber = 50;
//    self.cciChart.displayFrom = 0;
    self.cciChart.displayLongitudeTitle = NO;
    self.cciChart.axisMarginBottom = 3;
    
    self.cciChart.chartDelegate = self.chartDelegate;
    self.cciChart.backgroundColor = _chartsBackgroundColor;
    
    [self.scrollViewBottomChart addSubview:self.cciChart];
    
    UIView *vCCIContainer = [[UIView alloc] init];
    [vCCIContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vCCIContainer setBackgroundColor:[UIColor clearColor]];
    [self.cciChart addSubview:vCCIContainer];
    
    UILabel *lblCCI = [[UILabel alloc] init];
    [lblCCI setFrame:CGRectMake(0.0f, 8.0f, vCCIContainer.frame.size.width, vCCIContainer.frame.size.height)];
    [lblCCI setTextColor:[UIColor lightGrayColor]];
    [lblCCI setFont:[UIFont systemFontOfSize:11.0f]];
    [lblCCI setText:@"CCI(14): 0.00"];
    [vCCIContainer addSubview:lblCCI];
    _lblCCI = lblCCI;
}

- (void)initCCIChartData {
    if (self.groupChartData) {
        self.cciChart.linesData = self.groupChartData.cciLinesData;
//        self.cciChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.cciChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        
        self.cciChart.linesData = [self.chartData computeCCIData:14];
        self.cciChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.cciChart setNeedsDisplay];
    }
}

- (void)initBOLLChart {
    CCSSlipLineChart *bollChart = [[CCSSlipLineChart alloc] initWithFrame:CGRectMake(self.scrollViewBottomChart.frame.size.width * 6, 0, self.scrollViewBottomChart.frame.size.width, self.scrollViewBottomChart.frame.size.height)];
    bollChart.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.bollChart = bollChart;
    
    //初始化数据
    [self initBOLLChartData];
    
    //设置stickData
//    self.bollChart.displayNumber = 50;
//    self.bollChart.displayFrom = 0;
    self.bollChart.displayLongitudeTitle = NO;
    self.bollChart.axisMarginBottom = 3;
    
    self.bollChart.chartDelegate = self.chartDelegate;
    self.bollChart.backgroundColor = _chartsBackgroundColor;
    self.bollChart.axisCalc = AXIS_CALC_PARM;
    
    [self.scrollViewBottomChart addSubview:self.bollChart];
    
    UIView *vBOLLContainer = [[UIView alloc] init];
    [vBOLLContainer setFrame:CGRectMake(0.0f, 0.0f, self.stickChart.frame.size.width, 30.0f)];
    [vBOLLContainer setBackgroundColor:[UIColor clearColor]];
    [self.bollChart addSubview:vBOLLContainer];
    
    UILabel *lblBOLL = [[UILabel alloc] init];
    [lblBOLL setFrame:CGRectMake(0.0f, 8.0f, vBOLLContainer.frame.size.width, vBOLLContainer.frame.size.height)];
    [lblBOLL setTextColor:[UIColor lightGrayColor]];
    [lblBOLL setFont:[UIFont systemFontOfSize:11.0f]];
    [lblBOLL setText:@"BOLL(20,3,3): 0.00 0.00 0.00"];
    [vBOLLContainer addSubview:lblBOLL];
    _lblBOLL = lblBOLL;
}

- (void)initBOLLChartData {
    if (self.groupChartData) {
        self.bollChart.linesData = self.groupChartData.bollLinesData;
//        self.bollChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.bollChart setNeedsDisplay];
        
        return;
    }
    
    if (self.chartData != NULL) {
        self.bollChart.linesData = [self.chartData computeBOLLData:20 optInNbDevUp:2 optInNbDevDn:2];
        self.bollChart.singleTouchPoint = CGPointMake(-1, -1);
        
        [self.bollChart setNeedsDisplay];
    }
}

- (void)candleStickChartTouch:(id)sender {
    NSInteger i = self.candleStickChart.selectedStickIndex;
    
    if (self.candleStickChart.stickData && [self.candleStickChart.stickData count] > 0) {
        CCSCandleStickChartData *ohlc = [self.candleStickChart.stickData objectAtIndex:i];
        CCSCandleStickChartData *lastohlc;
        //第一根k线时，处理前日比
        if (i == 0) {
            lastohlc = [[CCSCandleStickChartData alloc] initWithOpen:0 high:0 low:0 close:ohlc.close - ohlc.change date:@""];
        } else {
            lastohlc = [self.candleStickChart.stickData objectAtIndex:i - 1];
        }
        
        //设置标签值
        _lblOpen.text = [[[NSString stringWithFormat:@"%f", ohlc.open/1000] decimal:0] zero];
        _lblHigh.text = [[[NSString stringWithFormat:@"%f", ohlc.high/1000] decimal:0] zero];
        _lblLow.text = [[[NSString stringWithFormat:@"%f", ohlc.low/1000] decimal:0] zero];
        _lblClose.text = [[[NSString stringWithFormat:@"%f", ohlc.close/1000] decimal:0] zero];
        
//        self.lblChange.text = [NSString stringWithFormat:@"%@(%@%%)",
//                               [[NSString stringWithFormat:@"%f", ohlc.change] decimalWithSign:2],
//                               [[NSString stringWithFormat:@"%f", ohlc.change * 100 / lastohlc.close] decimalWithSign:2]];
        
//        self.lblPreClose.text = [NSString stringWithFormat:@"前日終値:%@", [[[NSString stringWithFormat:@"%f", lastohlc.close] decimal:2] zero]];
//        
//        self.lblDate.text = ohlc.date;
        
        //设置标签文本颜色
        if (ohlc.open == 0) {
            self.lblOpen.textColor = [UIColor lightGrayColor];
        } else {
            //设置标签文本颜色
            self.lblOpen.textColor = ohlc.open != lastohlc.close ? ohlc.open > lastohlc.close ? LINE_COLORS[0] : LINE_COLORS[1] : [UIColor lightGrayColor];
        }
        
        if (ohlc.high == 0) {
            self.lblHigh.textColor = [UIColor lightGrayColor];
        } else {
            //设置标签文本颜色
            self.lblHigh.textColor = ohlc.high != lastohlc.close ? ohlc.high > lastohlc.close ? LINE_COLORS[0] : LINE_COLORS[1] : [UIColor lightGrayColor];
        }
        
        if (ohlc.low == 0) {
            self.lblLow.textColor = [UIColor lightGrayColor];
        } else {
            self.lblLow.textColor = ohlc.low != lastohlc.close ? ohlc.low > lastohlc.close ? LINE_COLORS[0] : LINE_COLORS[1] : [UIColor lightGrayColor];
        }
        
        if (ohlc.close == 0) {
            self.lblClose.textColor = [UIColor lightGrayColor];
        } else {
            self.lblClose.textColor = ohlc.close != lastohlc.close ? ohlc.close > lastohlc.close ? LINE_COLORS[0] : LINE_COLORS[1] : [UIColor lightGrayColor];
        }
        
        if (ohlc.change == 0) {
            self.lblChange.textColor = [UIColor lightGrayColor];
        } else {
            self.lblChange.textColor = ohlc.close != lastohlc.close ? ohlc.close > lastohlc.close ? LINE_COLORS[0] : LINE_COLORS[1] : [UIColor lightGrayColor];
        }
        
    }
    
    if (self.stickChart.stickData && [self.stickChart.stickData count] > 0) {
        //成交量
        _lblVOL.text = [[[[NSString stringWithFormat:@"%f", ((CCSStickChartData *) [self.stickChart.stickData objectAtIndex:i]).high/10000] decimal] zero] append:@"万"];
    }
    
    if (self.candleStickChart.linesData && [self.candleStickChart.linesData count] > 0) {
        
        //均线数据
        CCSTitledLine *ma5 = [self.candleStickChart.linesData objectAtIndex:0];
        CCSTitledLine *ma10 = [self.candleStickChart.linesData objectAtIndex:1];
        
        //MA5
        if (ma5 && ma5.data && [ma5.data count] > 0) {
            if (((CCSLineData *) [ma5.data objectAtIndex:i]).value != 0) {
                self.lblSubTitle1.text = [NSString stringWithFormat:@"%@: %@", ma5.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [ma5.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
            } else {
                self.lblSubTitle1.text = @"";
            }
            self.lblSubTitle1.textColor = ma5.color;
        }
        
        //MA10
        if (ma10 && ma10.data && [ma10.data count] > 0) {
            if (((CCSLineData *) [ma10.data objectAtIndex:i]).value != 0) {
                self.lblSubTitle2.text = [NSString stringWithFormat:@"%@: %@", ma10.title, [[[NSString stringWithFormat:@"%f", ((CCSLineData *) [ma10.data objectAtIndex:i]).value / self.candleStickChart.axisCalc] decimal:2] zeroIsBlank]];
            } else {
                self.lblSubTitle2.text = @"";
            }
            self.lblSubTitle2.textColor = ma10.color;
        }
        
        if (GroupChartViewTypeVOL == self.bottomChartType) {
            if (self.stickChart.stickData && [self.stickChart.stickData count] > 0) {
                self.lblSubTitle6.text = [NSString stringWithFormat:@"VOL: %@", self.lblVolume.text];
            }
            
        } else if (GroupChartViewTypeMACD == self.bottomChartType) {
            if (self.macdChart.stickData && [self.macdChart.stickData count] > 0) {
                
                CCSMACDData *macdData = [self.macdChart.stickData objectAtIndex:i];
                if (macdData.diff != 0) {
                    self.lblSubTitle6.text = [NSString stringWithFormat:@"DIFF: %@", [[[NSString stringWithFormat:@"%f", (macdData.diff / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle6.text = @"";
                }
                self.lblSubTitle6.textColor = self.macdChart.diffLineColor;
                
                if (macdData.dea != 0) {
                    self.lblSubTitle7.text = [NSString stringWithFormat:@"DEA: %@", [[[NSString stringWithFormat:@"%f", (macdData.dea / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle7.text = @"";
                }
                self.lblSubTitle7.textColor = self.macdChart.deaLineColor;
                
                if (macdData.macd != 0) {
                    self.lblSubTitle8.text = [NSString stringWithFormat:@"MACD: %@", [[[NSString stringWithFormat:@"%f", (macdData.macd / self.macdChart.axisCalc)] decimal:2] zeroIsBlank]];
                } else {
                    self.lblSubTitle8.text = @"";
                }
                self.lblSubTitle8.textColor = self.macdChart.macdLineColor;
                
                if (macdData) {
                    [_lblMACD setText:[NSString stringWithFormat:@"DIF:%@ DEA:%@", [[NSString stringWithFormat:@"%f", macdData.diff] decimal:2], [[NSString stringWithFormat:@"%f", macdData.dea] decimal:2]]];
                }else{
                    [_lblMACD setText:[NSString stringWithFormat:@"DIF:%f DEA:%f", 0.0f, 0.0f]];
                }
            }
        } else if (GroupChartViewTypeKDJ == self.bottomChartType) {
            NSMutableArray *kdjData = [[NSMutableArray alloc] init];
            [self.groupChartData.kdjLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CCSTitledLine *line = self.groupChartData.kdjLinesData[idx];
                CCSLineData *lineData = line.data[i];
                NSString *kdj = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
                [kdjData addObject:kdj];
            }];
            if (kdjData && [kdjData count] == 3) {
                [_lblKDJ setText:[NSString stringWithFormat:@"K:%@ D:%@ J:%@", kdjData[0], kdjData[1], kdjData[2]]];
            }else{
                [_lblKDJ setText:[NSString stringWithFormat:@"K:%@ D:%@ J:%@", @"0.00", @"0.00", @"0.00"]];
            }
        } else if (GroupChartViewTypeRSI == self.bottomChartType) {
            NSString *rsiN1 = [RSI_N1 getUserDefaultString];
            NSString *rsiN2 = [RSI_N2 getUserDefaultString];
            
            NSMutableArray *rsiData = [[NSMutableArray alloc] init];
            [self.groupChartData.rsiLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CCSTitledLine *line = self.groupChartData.rsiLinesData[idx];
                CCSLineData *lineData = line.data[i];
                NSString *rsi = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
                [rsiData addObject:rsi];
            }];
            if (rsiData && [rsiData count] == 3) {
                [_lblRSI setText:[NSString stringWithFormat:@"RSI%@: %@ RSI%@: %@ RSI24: %@", rsiN1, rsiData[0], rsiN2, rsiData[1], rsiData[2]]];
            }else{
                [_lblRSI setText:[NSString stringWithFormat:@"RSI%@: %@ RSI%@: %@ RSI24: %@", rsiN1, @"0.00", rsiN2, @"0.00", @"0.00"]];
            }
        } else if (GroupChartViewTypeWR == self.bottomChartType) {
            NSString *wrN = [WR_N getUserDefaultString];
            if (self.groupChartData.wrLinesData && [self.groupChartData.wrLinesData count] > 0) {
                CCSTitledLine *wrLine = self.groupChartData.wrLinesData[0];
                CCSLineData *wrLineData = wrLine.data[i];
                NSString *wr = [[NSString stringWithFormat:@"%f", wrLineData.value] decimal:2];
                
                [_lblWR setText:[NSString stringWithFormat:@"WR(%@): %@", wrN, wr]];
            }else{
                [_lblWR setText:[NSString stringWithFormat:@"WR(%@): %@", wrN, @"0.00"]];
            }
        } else if (GroupChartViewTypeCCI == self.bottomChartType) {
            NSString *cciN = [CCI_N getUserDefaultString];
            if (self.groupChartData.cciLinesData && [self.groupChartData.cciLinesData count] > 0) {
                CCSTitledLine *cciLine = self.groupChartData.cciLinesData[0];
                CCSLineData *cciLineData = cciLine.data[i];
                NSString *cci = [[NSString stringWithFormat:@"%f", cciLineData.value] decimal:2];
                
                [_lblCCI setText:[NSString stringWithFormat:@"CCI(%@): %@", cciN, cci]];
            }else{
                [_lblCCI setText:[NSString stringWithFormat:@"CCI(%@): %@", cciN, @"0.00"]];
            }
        } else if (GroupChartViewTypeBOLL == self.bottomChartType) {
            NSString *bollN = [BOLL_N getUserDefaultString];
            
            NSMutableArray *bollData = [[NSMutableArray alloc] init];
            [self.groupChartData.bollLinesData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CCSTitledLine *line = self.groupChartData.bollLinesData[idx];
                CCSLineData *lineData = line.data[i];
                NSString *boll = [[NSString stringWithFormat:@"%f", lineData.value] decimal:2];
                [bollData addObject:boll];
            }];
            if (bollData && [bollData count] == 3) {
                [_lblBOLL setText:[NSString stringWithFormat:@"BOLL(%@,2,2): %@, %@, %@", bollN, bollData[0], bollData[1], bollData[2]]];
            }else{
                [_lblBOLL setText:[NSString stringWithFormat:@"BOLL(%@,2,2): %@, %@, %@", bollN, @"0.00", @"0.00", @"0.00"]];
            }
        }
    }
    
    //成交量图设置线条
    //[self.stickChart setSelectedPointAddReDraw:self.candleStickChart.singleTouchPoint];
    
}

#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{
    if (self.segBottomChartType.selectedSegmentIndex == 6) {
        self.segBottomChartType.selectedSegmentIndex = 0;
    }else{
        self.segBottomChartType.selectedSegmentIndex = self.segBottomChartType.selectedSegmentIndex + 1;
    }
    
    [self segBottomChartTypeTypeValueChaged:self.segBottomChartType];
}

- (void)segBottomChartTypeTypeValueChaged:(UISegmentedControl *)segmentedControl {
    self.lblSubTitle3.text = @"";
    self.lblSubTitle3.textColor = [UIColor blackColor];
    self.lblSubTitle4.text = @"";
    self.lblSubTitle5.textColor = [UIColor blackColor];
    self.lblSubTitle5.text = @"";
    self.lblSubTitle6.textColor = [UIColor blackColor];
    self.lblSubTitle6.text = @"";
    self.lblSubTitle6.textColor = [UIColor blackColor];
    self.lblSubTitle7.text = @"";
    self.lblSubTitle7.textColor = [UIColor blackColor];
    self.lblSubTitle8.text = @"";
    self.lblSubTitle8.textColor = [UIColor blackColor];
    self.lblSubTitle9.text = @"";
    self.lblSubTitle9.textColor = [UIColor blackColor];
    self.lblSubTitle10.text = @"";
    self.lblSubTitle10.textColor = [UIColor blackColor];
    
    // 得到每页宽度
    CGFloat pageWidth = self.scrollViewBottomChart.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int page = (int) floor((self.scrollViewBottomChart.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (segmentedControl.selectedSegmentIndex != page) {
        //滚动相应的距离
        self.scrollViewBottomChart.contentOffset = CGPointMake(pageWidth * segmentedControl.selectedSegmentIndex, self.scrollViewBottomChart.contentOffset.y);
    }
    
    self.candleStickChart.bollingerBandStyle = CCSBollingerBandStyleNone;
    
    CGFloat selectedViewX = 0.0f;
    
    if (0 == self.segBottomChartType.selectedSegmentIndex) {
        self.stickChart.displayFrom = self.candleStickChart.displayFrom;
        self.stickChart.displayNumber = self.candleStickChart.displayNumber;
        [self.stickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeVOL;
        
        selectedViewX = 0.0f;
    } else if (1 == self.segBottomChartType.selectedSegmentIndex) {
        self.macdChart.displayFrom = self.candleStickChart.displayFrom;;
        self.macdChart.displayNumber = self.candleStickChart.displayNumber;
        [self.macdChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeMACD;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f;
    } else if (2 == self.segBottomChartType.selectedSegmentIndex) {
        self.kdjChart.displayFrom = self.candleStickChart.displayFrom;;
        self.kdjChart.displayNumber = self.candleStickChart.displayNumber;
        [self.kdjChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeKDJ;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f*2;
    } else if (3 == self.segBottomChartType.selectedSegmentIndex) {
        self.rsiChart.displayFrom = self.candleStickChart.displayFrom;;
        self.rsiChart.displayNumber = self.candleStickChart.displayNumber;
        [self.rsiChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeRSI;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f*3;
    } else if (4 == self.segBottomChartType.selectedSegmentIndex) {
        self.wrChart.displayFrom = self.candleStickChart.displayFrom;;
        self.wrChart.displayNumber = self.candleStickChart.displayNumber;
        [self.wrChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeWR;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f*4;
    } else if (5 == self.segBottomChartType.selectedSegmentIndex) {
        self.cciChart.displayFrom = self.candleStickChart.displayFrom;;
        self.cciChart.displayNumber = self.candleStickChart.displayNumber;
        [self.cciChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        self.bottomChartType = GroupChartViewTypeCCI;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f*5;
    } else if (6 == self.segBottomChartType.selectedSegmentIndex) {
        self.bollChart.displayFrom = self.candleStickChart.displayFrom;;
        self.bollChart.displayNumber = self.candleStickChart.displayNumber;
        [self.bollChart performSelector:@selector(setNeedsDisplay) withObject:nil];
        
        self.candleStickChart.bollingerBandStyle = CCSBollingerBandStyleBand;
        self.bottomChartType = GroupChartViewTypeBOLL;
        
        selectedViewX = (_contentSize.width - 50.0f)/7.0f*6;
    }
    
    [self moveSelectedView:selectedViewX];
    
    [self.candleStickChart performSelector:@selector(setNeedsDisplay) withObject:nil];
}

- (void)setting:(UIButton *) sender{
    if (self.setting) {
        self.setting();
    }
}

- (void)moveSelectedView:(CGFloat)x{
    [UIView animateWithDuration:0.2f animations:^{
        [_vSelected setFrame:CGRectMake(x, _vSelected.frame.origin.y, _vSelected.frame.size.width, _vSelected.frame.size.height)];
    }];
}

/*******************************************************************************
* Unused Codes
*******************************************************************************/

@end
