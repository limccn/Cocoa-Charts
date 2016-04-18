//
//  CCSMASlipCandleStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
