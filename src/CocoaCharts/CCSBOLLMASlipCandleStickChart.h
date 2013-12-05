//
//  CCSBOLLMASlipCandleStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMASlipCandleStickChart.h"

@interface CCSBOLLMASlipCandleStickChart : CCSMASlipCandleStickChart {
    NSArray *_bollingerBandData;

    CGFloat _areaAlpha;
    BOOL _displayBollingerBand;
}

@property(retain, nonatomic) NSArray *bollingerBandData;

@property(assign, nonatomic) CGFloat areaAlpha;


@end
