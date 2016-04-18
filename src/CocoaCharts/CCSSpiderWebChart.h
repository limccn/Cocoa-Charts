//
//  CCSSpiderWebChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-27.
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
 CCSSpiderWebChart
 
 CCSSpiderWebChart is a kind of graph that display data on web-like graph. each
 data was displayed in the longitude lines,like a area graph.
 
 CCSSpiderWebChartは丸グラフとアリアグラフを合わせるのグラフ一種です、データをワッブで表示します。
 
 CCSSpiderWebChart是一种将数据内容显示在网状图上的一种图表、是将饼图和面积图结合表示的一种图表
 */
@interface CCSSpiderWebChart : CCSBaseChartView {
    NSArray *_data;
    NSArray *_titles;
    UIColor *_longitudeColor;
    UIColor *_latitudeColor;
    UIColor *_spiderWebFillColor;
    CCUInt _longitudeLength;
    CCUInt _latitudeNum;
    CCUInt _longitudeNum;
    BOOL _displayLatitude;
    BOOL _displayLongitude;
    CGPoint _position;
}

/*!
 Data Array for display data
 表示用データ
 表示用的数据
 */
@property(strong, nonatomic) NSArray *data;

/*!
 Titles for display data
 表示データのタイトルリスト
 数据的标题
 */
@property(strong, nonatomic) NSArray *titles;

/*!
 Color of web‘s longitude line
 経線の色
 蛛网经线的显示颜色
 */
@property(strong, nonatomic) UIColor *longitudeColor;

/*!
 Color of web‘s latitude line
 緯線の色
 蛛网纬线的显示颜色
 */
@property(strong, nonatomic) UIColor *latitudeColor;

/*!
 蛛网填充颜色 
 */
@property(strong, nonatomic) UIColor *spiderWebFillColor;

/*!
 Radius of the spider web
 ワッブの半径
 蛛网图经线半径长度
 */
@property(assign, nonatomic) CCUInt longitudeLength;

/*!
 Numbers of latitude
 緯線数量
 纬线数
 */
@property(assign, nonatomic) CCUInt latitudeNum;

/*!
 Numbers of longitude
 経線数量
 经线数
 */
@property(assign, nonatomic) CCUInt longitudeNum;

/*!
 Should display latitude line？
 緯線を表示するか？
 纬线是否显示
 */
@property(assign, nonatomic) BOOL displayLatitude;

/*!
 Should display longitude line？
 経線を表示するか？
 经线是否显示
 */
@property(assign, nonatomic) BOOL displayLongitude;

/*!
 The position for display the spider web
 ワッブの中心点の位置
 蛛网的中心位置
 */
@property(assign, nonatomic) CGPoint position;

/*!
 @abstract Draw the data for spider web
 ワッブチャートのデータを書く
 绘制蛛网上的数据
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawData:(CGRect)rect;

/*!
 @abstract Draw the spider web
 ワッブを書く
 绘制蛛网
 
 @param rect the rect of the grid
 グリドのrect
 图表的rect
 */
- (void)drawSpiderWeb:(CGRect)rect;

@end
