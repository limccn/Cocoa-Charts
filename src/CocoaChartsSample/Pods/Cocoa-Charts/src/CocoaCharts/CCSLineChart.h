//
//  CCSLineChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-25.
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

#import <Foundation/Foundation.h>
#import "CCSGridChart.h"
#import "CCSStickChart.h"

typedef enum {
    CCSLineAlignTypeCenter,
    CCSLineAlignTypeJustify
} CCSLineAlignType;

/*!
 CCSLineChart
 
 CCSLineChart is a kind of graph that draw some lines on a CCSGridChart
 
 CCSLineChartはCCSGridChartの表面でラインを書いたラインチャードです。
 
 CCSLineChart是在CCSGridChart上绘制一条或多条线条的图
 */
@interface CCSLineChart : CCSGridChart {
    NSArray *_linesData;
    CCUInt _selectedIndex;
    CCFloat _lineWidth;
    CCFloat _maxValue;
    CCFloat _minValue;
    CCUInt _axisCalc;
    BOOL _autoCalcRange;
    BOOL _balanceRange;
    CCSLineAlignType _lineAlignType;
}

/*!
 Data for display data
 ラインを表示用データ
 表示线条用的数据
 */
@property(strong, nonatomic, setter = setLinesData:) NSArray *linesData;


/*! 
 Selected data's index
 选中的方柱位置
 */
@property(assign, nonatomic) CCUInt selectedIndex;

/*! 
 Displayed line's width
 ラインのサイズ
 线宽
 */
@property(assign, nonatomic) CCFloat lineWidth;

/*! 
 Max display value of axis Y
 Y軸の最大値
 Y轴显示最大值
 */
@property(assign, nonatomic) CCFloat maxValue;

/*! 
 Min display value of axis Y
 Y軸の最小値
 Y轴显示最小值
 */
@property(assign, nonatomic) CCFloat minValue;

/*!
 fast calculator for axis Y degrees （display degrees＝degrees/axisCalc）
 Y軸目盛りの快速計算子，（表示目盛り＝計算目盛り/axisCalc）
 Y轴显示值的快速计算子（表示刻度＝ 计算刻度/axisCalc）
 */
@property(assign, nonatomic) CCUInt axisCalc;

@property(assign, nonatomic) BOOL autoCalcRange;
@property(assign, nonatomic) BOOL balanceRange;

@property(assign, nonatomic) CCSLineAlignType lineAlignType;


/*!
 @abstract Draw lines to this graph
 ラインデータを使いてラインを書く
 使用数据绘制线条
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawData:(CGRect)rect;

/*!
 @abstract Init X axis degrees
 初期化X軸の目盛
 初始化X轴的刻度
 */
- (void)initAxisY;

/*!
 @abstract Init Y axis degrees
 初期化Y軸の目盛
 初始化Y轴的刻度
 */
- (void)initAxisX;

- (void)calcDataValueRange;

- (void)calcValueRangePaddingZero;

- (void)calcValueRangeFormatForAxis;

- (void)calcValueRange;

- (void)calcBalanceRange;

- (void)setSelectedPointAddReDraw:(CGPoint)point;

-(CCFloat) computeValueY:(CCFloat)value inRect:(CGRect)rect;

@end
