//
//  CCSMASlipCandleStickChart.h
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

#import "CCSSlipCandleStickChart.h"

@interface CCSMASlipCandleStickChart : CCSSlipCandleStickChart {
    NSArray *_linesData;
}

/*!
 Data for display data
 ラインを表示用データ
 表示线条用的数据
 */
@property(strong, nonatomic) NSArray *linesData;

/*!
 @abstract Draw lines to this graph
 ラインデータを使いてラインを書く
 使用数据绘制线条
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawLinesData:(CGRect)rect;


@end
