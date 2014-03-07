//
//  CCSBOLLMASlipCandleStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMASlipCandleStickChart.h"



typedef enum {
    CCSBollingerBandStyleBand = 0,
    CCSBollingerBandStyleLane = 1,
    CCSBollingerBandStyleNoBorder = 2,
    CCSBollingerBandStyleNone = 9,
} CCSBollingerBandStyle;


@interface CCSBOLLMASlipCandleStickChart : CCSMASlipCandleStickChart {
    NSArray *_bollingerBandData;
    UIColor *_bollingerBandColor;
    CGFloat _bollingerBandAlpha;
    NSUInteger _bollingerBandStyle;
}

@property(retain, nonatomic) NSArray *bollingerBandData;
@property(retain, nonatomic) UIColor *bollingerBandColor;
@property(assign, nonatomic) CGFloat bollingerBandAlpha;
@property(assign, nonatomic) NSUInteger bollingerBandStyle;

@end
