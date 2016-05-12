//
//  CCSBOLLMASlipCandleStickChart.h
//  Cocoa-Charts
//
//  Created by limc on 13-10-27.
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

#import "CCSMASlipCandleStickChart.h"


/*!
 CCSBollingerBandStyle
 
 布林带的显示样式
 CCSBollingerBandStyleBand => 带状，包含边框
 CCSBollingerBandStyleLane => 边框
 CCSBollingerBandStyleNoBorder => 带状、不包含边框
 CCSBollingerBandStyleNone => 不显示
 */
typedef enum {
    CCSBollingerBandStyleBand = 0,
    CCSBollingerBandStyleLane = 1,
    CCSBollingerBandStyleNoBorder = 2,
    CCSBollingerBandStyleNone = 9,
} CCSBollingerBandStyle;


/*!
 CCSBOLLMASlipCandleStickChart
 
 支持显示布林带的K线图表
 */
@interface CCSBOLLMASlipCandleStickChart : CCSMASlipCandleStickChart {
    NSArray *_bollingerBandData;
    UIColor *_bollingerBandColor;
    CCFloat _bollingerBandAlpha;
    CCUInt _bollingerBandStyle;
}

/*!
 显示布林带的数据
 */
@property(strong, nonatomic) NSArray *bollingerBandData;

/*!
 显示布林带的填充颜色
 */
@property(strong, nonatomic) UIColor *bollingerBandColor;

/*!
 显示布林带的填充透明度
 */
@property(assign, nonatomic) CCFloat bollingerBandAlpha;

/*!
 显示布林带的样式
 */
@property(assign, nonatomic) CCUInt bollingerBandStyle;

@end
