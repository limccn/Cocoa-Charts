//
//  CCSBOLLMASlipCandleStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
    CCFloat _bollingerBandAlpha;
    CCUInt _bollingerBandStyle;
}

@property(retain, nonatomic) NSArray *bollingerBandData;
@property(retain, nonatomic) UIColor *bollingerBandColor;
@property(assign, nonatomic) CCFloat bollingerBandAlpha;
@property(assign, nonatomic) CCUInt bollingerBandStyle;

@end
