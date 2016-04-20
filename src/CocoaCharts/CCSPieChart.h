//
//  CCSPieChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-26.
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
#import "CCSBaseChartView.h"

/*!
 CCSPieChart
 
 CCSPieChart is a kind of graph that display all in a pie-like graph, each of 
 the data will get a part of the pie. another kind of pie chart you can refer
 from CCSPizzaChart
 
 CCSPieChartは丸グラフの一種です、分割表示をお使い場合、CCSPizzaChartを利用してください
 
 CCSPieChart是最简单的饼图，如果您需要可以分割表示的饼图，请参照CCSPizzaChart
 */
@interface CCSPieChart : CCSBaseChartView {
    NSArray *_data;
    UIColor *_radiusColor;
    UIColor *_circleBorderColor;
    UIFont *_titleFont;
    UIColor *_titleTextColor;
    CCUInt _radius;
    BOOL _displayRadius;
    BOOL _displayValueTitle;
    CGPoint _position;
}

/*!
 Data Array for display data
 表示用データ
 表示用的数据
 */
@property(strong, nonatomic) NSArray *data;

/*!
 Color for the division lines inside the chart
 丸の分割線の色
 饼图的分割线的颜色
 */
@property(strong, nonatomic) UIColor *radiusColor;

/*!
 Color for the border of the pie circle
 丸のボーダーの色
 饼图的弧线颜色
 */
@property(strong, nonatomic) UIColor *circleBorderColor;

/*!
 Title Font
 タイトルのフォント
 标签的字体
 */
@property(strong, nonatomic) UIFont *titleFont;

/*!
 Title text color
 タイトルの色
 标签的字体的颜色
 */
@property(strong, nonatomic) UIColor *titleTextColor;

/*!
 Radius of the pie circle
 丸の半径
 饼图的半径
 */
@property(assign, nonatomic) CCUInt radius;

/*!
 Display the division lines?
 丸の分割線を表示するか?
 显示分割线？
 */
@property(assign, nonatomic) BOOL displayRadius;

/*!
 Display the title for each apart of pie
 丸の各部分のタイトルを表示するか
 显示分割部分的标题？
 */
@property(assign, nonatomic) BOOL displayValueTitle;

/*!
 The position for display the graph
 丸の中心点の位置
 饼图的中心位置
 */
@property(assign, nonatomic) CGPoint position;

/*!
 @abstract Draw a pie chart
 丸チャードを書く
 使用数据绘制饼图
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawData:(CGRect)rect;
@end
