//
//  CCSGridChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-24.
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

#import <UIKit/UIKit.h>
#import "CCSBaseChartView.h"

@protocol CCSChartDelegate <NSObject>
@optional
- (void)CCSChartBeTouchedOn:(CGPoint)point indexAt:(NSUInteger) index;
- (void)CCSChartDisplayChangedFrom:(NSUInteger)from number:(NSUInteger) number;
@end

/*!
 @typedef enum CCSGridChartAxisPosition
 XY Axis' Display position in grid 
 X軸、Y軸の表示位置
 X轴、Y轴在画面种的表示位置
 */
typedef enum {
    CCSGridChartAxisYPositionLeft,               //Axis Y left
    CCSGridChartAxisYPositionRight,              //Axis Y right
    CCSGridChartAxisXPositionTop,                //Axis X top
    CCSGridChartAxisXPositionBottom              //Axis X bottom
} CCSGridChartAxisPosition;

/*!
 CCSGridChart
 
 CCSGridChart is base type of all the charts that use a grid to display
 like line-chart stick-chart etc. CCSGridChart implemented a simple grid
 with basic functions what can be used in it's inherited charts.
 
 CCSGridChartは全部グリドチャートのベスクラスです、一部処理は共通化け実現した。
 
 CCSGridChart是所有网格图表的基础类对象，它实现了基本的网格图表功能，这些功能将被它的继承类使用
 */
@interface CCSGridChart : CCSBaseChartView {
    NSMutableArray *_axisXTitles;
    NSMutableArray *_axisYTitles;
    UIColor *_axisXColor;
    UIColor *_axisYColor;
    UIColor *_longitudeColor;
    UIColor *_latitudeColor;
    UIColor *_borderColor;
    UIColor *_longitudeFontColor;
    UIColor *_latitudeFontColor;
    UIColor *_crossLinesColor;
    UIColor *_crossLinesFontColor;
    CGFloat _axisMarginLeft;
    CGFloat _axisMarginBottom;
    CGFloat _axisMarginTop;
    CGFloat _axisMarginRight;
    NSUInteger _longitudeFontSize;
    NSUInteger _latitudeFontSize;
    NSUInteger _axisXPosition;
    NSUInteger _axisYPosition;
    BOOL _displayAxisXTitle;
    BOOL _displayAxisYTitle;
    BOOL _displayLongitude;
    BOOL _dashLongitude;
    BOOL _displayLatitude;
    BOOL _dashLatitude;
    BOOL _displayBorder;
    BOOL _displayCrossXOnTouch;
    BOOL _displayCrossYOnTouch;
    CGPoint _singleTouchPoint;
    
    UIViewController<CCSChartDelegate> *_chartDelegate;
}

/*!
 Titles Array for display of X axis
 X軸の表示用タイトル配列
 X轴标题数组
 */
@property(retain, nonatomic) NSMutableArray *axisXTitles;

/*!
 Titles for display of Y axis
 Y軸の表示用タイトル配列
 Y轴标题数组
 */
@property(retain, nonatomic) NSMutableArray *axisYTitles;

/*!
 Color of X axis
 X軸の色
 坐标轴X的显示颜色
 */
@property(retain, nonatomic) UIColor *axisXColor;

/*!
 Color of Y axis
 Y軸の色
 坐标轴Y的显示颜色
 */
@property(retain, nonatomic) UIColor *axisYColor;

/*!
 Color of grid‘s longitude line
 経線の色
 网格经线的显示颜色
 */
@property(retain, nonatomic) UIColor *longitudeColor;

/*!
 Color of grid‘s latitude line
 緯線の色
 网格纬线的显示颜色
 */
@property(retain, nonatomic) UIColor *latitudeColor;

/*!
 Color of grid‘s border line
 枠線の色
 图边框的颜色
 */
@property(retain, nonatomic) UIColor *borderColor;

/*!
 Color of text for the longitude　degrees display
 経度のタイトルの色
 经线刻度字体颜色
 */
@property(retain, nonatomic) UIColor *longitudeFontColor;

/*!
 Color of text for the latitude　degrees display
 緯度のタイトルの色
 纬线刻度字体颜色
 */
@property(retain, nonatomic) UIColor *latitudeFontColor;

/*!
 Color of cross line inside grid when touched
 タッチしたポイント表示用十字線の色
 十字交叉线颜色
 */
@property(retain, nonatomic) UIColor *crossLinesColor;

/*!
 Color of cross line degree text when touched
 タッチしたポイント表示用十字線度数文字の色
 十字交叉线坐标轴字体颜色
 */
@property(retain, nonatomic) UIColor *crossLinesFontColor;

/*!
 Margin of the axis to the left border
 轴線より左枠線の距離
 轴线左边距
 */
@property(assign, nonatomic) CGFloat axisMarginLeft;

/*!
 Margin of the axis to the bottom border
 轴線より下枠線の距離
 轴线下边距
 */
@property(assign, nonatomic) CGFloat axisMarginBottom;

/*!
 Margin of the axis to the top border
 轴線より上枠線の距離
 轴线上边距
 */
@property(assign, nonatomic) CGFloat axisMarginTop;

/*!
 Margin of the axis to the top border
 轴線より右枠線の距離
 轴线右边距
 */
@property(assign, nonatomic) CGFloat axisMarginRight;

/*!
 Font size of text for the longitude　degrees display
 経度のタイトルの文字サイズ
 经线刻度字体大小
 */
@property(assign, nonatomic) NSUInteger longitudeFontSize;

/*!
 Font size of text for the latitude　degrees display
 緯度のタイトルの文字サイズ
 纬线刻度字体大小
 */
@property(assign, nonatomic) NSUInteger latitudeFontSize;

/*!
 The position of X axis(top,bottom) reference:CCSGridChartAxisPosition
 X軸の表示位置（上、下）参照：CCSGridChartAxisPosition
 X轴显示位置（上、下）参看：CCSGridChartAxisPosition
 */
@property(assign, nonatomic) NSUInteger axisXPosition;

/*!
 The position of Y axis(left,right) reference:CCSGridChartAxisPosition
 Y軸の表示位置（左、右）参照：CCSGridChartAxisPosition
 Y轴显示位置（左、右）参看：CCSGridChartAxisPosition
 */
@property(assign, nonatomic) NSUInteger axisYPosition;

/*!
 Should display the degrees in X axis？
 X軸のタイトルを表示するか？
 X轴上的标题是否显示
 */
@property(assign, nonatomic) BOOL displayAxisXTitle;

/*!
 Should display the degrees in Y axis？
 Y軸のタイトルを表示するか？
 Y轴上的标题是否显示
 */
@property(assign, nonatomic) BOOL displayAxisYTitle;

/*!
 Should display longitude line？
 経線を表示するか？
 经线是否显示
 */
@property(assign, nonatomic) BOOL displayLongitude;

/*!
 Should display longitude as dashed line？
 経線を点線にするか？
 经线是否显示为虚线
 */
@property(assign, nonatomic) BOOL dashLongitude;

/*!
 Should display longitude line？
 緯線を表示するか？
 纬线是否显示
 */
@property(assign, nonatomic) BOOL displayLatitude;

/*!
 Should display latitude as dashed line？
 緯線を点線にするか？
 纬线是否显示为虚线
 */
@property(assign, nonatomic) BOOL dashLatitude;

/*!
 Should display the border？
 枠を表示するか？
 控件是否显示边框
 */
@property(assign, nonatomic) BOOL displayBorder;

/*!
 Should display the Y cross line if grid is touched？
 タッチしたポイントがある場合、十字線の垂直線を表示するか？
 在控件被点击时，显示十字竖线线
 */
@property(assign, nonatomic) BOOL displayCrossXOnTouch;

/*!
 Should display the Y cross line if grid is touched？
 タッチしたポイントがある場合、十字線の水平線を表示するか？
 在控件被点击时，显示十字横线线
 */
@property(assign, nonatomic) BOOL displayCrossYOnTouch;

/*!
 Touched point inside of grid
 タッチしたポイント
 单点触控的选中点
 */
@property(assign, nonatomic ,setter = setSingleTouchPoint:) CGPoint singleTouchPoint;


/*!
 Touched point inside of grid
 タッチしたポイント
 单点触控的选中点
 */
@property(assign, nonatomic) UIViewController<CCSChartDelegate> *chartDelegate;


/*!
 @abstract Draw the border
 枠を書く。
 绘制边框
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawBorder:(CGRect)rect;

/*!
 @abstract Draw the X Axis
 X軸を書く。
 绘制X轴 
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawXAxis:(CGRect)rect;

/*!
 @abstract Draw the Y Axis
 Y軸を書く。
 绘制Y轴
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawYAxis:(CGRect)rect;

/*!
 @abstract Draw the latitude lines
 緯線を書く。
 绘制纬线
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawAxisGridX:(CGRect)rect;

/*!
 @abstract Draw the longitude lines
 経線を書く。
 绘制经线
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawAxisGridY:(CGRect)rect;

/*!
 @abstract Draw the cross lines
 十字線を書く。
 绘制十字交叉线
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawCrossLines:(CGRect)rect;

/*!
 @abstract calculate the x axis display degrees of touched point
 経度数の表示目盛りを計算する。
 计算经度的表示刻度
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 
 @result NSString * the calculated value
 計算出した目盛り
 刻度结果
 
 */
- (NSString *)calcAxisXGraduate:(CGRect)rect;

/*!
 @abstract calculate the y axis display degrees of touched point
 緯度数の表示目盛りを計算する。
 计算纬度的表示刻度
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 
 @result NSString * the calculated value
 計算出した目盛り
 刻度结果
 */
- (NSString *)calcAxisYGraduate:(CGRect)rect;

/*!
 @abstract calculate the x axis display value of touched point (value:0.0～1.0)
 経度数を計算する。(度数：0.0~1.0)
 计算经度的度数 (度数：0.0~1.0)
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 
 @result CGFloat the calculated value
 計算出した度数
 经度计算结果
 
 */
- (CGFloat)touchPointAxisXValue:(CGRect)rect;

/*!
 @abstract calculate the y axis display value of touched point (value:0.0～1.0)
 緯度数を計算する。(度数：0.0~1.0)
 计算纬度的度数 (度数：0.0~1.0)
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 
 @result CGFloat the calculated value
 計算出した度数］
 纬度计算结果
 */
- (CGFloat)touchPointAxisYValue:(CGRect)rect;

/*!
 @abstract Zoom out the grid
 縮小表示する。
 缩小 
 */
- (void)zoomOut;

/*!
 @abstract Zoom out the grid
 拡大表示する。
 放大表示
 */
- (void)zoomIn;

@end
