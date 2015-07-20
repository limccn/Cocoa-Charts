//
//  CCSDonutChart.h
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
#import "CCSPieChart.h"

/*!
 CCSDonutChart
 
 CCSDonutChart is a kind of graph that display all in a Donut-like graph, each of
 the data will get a part of the Donut. 
 
 CCSDonutChartは丸グラフの一種です
 
 CCSDonutChart是最简单的原型图，形如甜甜圈，因而得名
 */
@interface CCSDonutChart :CCSPieChart  {
    CCUInt _donutWidth;
}

/*!
 Width of the donut
 ドーナツの広さ
 环状图图的宽度
 */
@property(assign, nonatomic) CCUInt donutWidth;

@end
