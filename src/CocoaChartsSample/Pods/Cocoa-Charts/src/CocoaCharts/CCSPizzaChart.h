//
//  CCSPizzaChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-11-8.
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
 CCSPizzaChart
 
 CCSPizzaChart is inherts from CCSPieChart which can display selected part aparts
 from the pie
 
 CCSPizzaChartは丸グラフの一種です、選べたデータを丸グラフから一部分割表示は可能です。
 
 CCSPizzaChart继承于CCSPieChart的，可以在CCSPieChart基础上将选中的部分单独抽出表示的图
 */
@interface CCSPizzaChart : CCSPieChart {
    CCUInt _selectedIndex;
    CCFloat _offsetLength;
}

/*!
 Selected part of the pie which will take up from the pie
 選べた、分割表示されているデータのインデクス
 被选中的饼图的部分，这部分会从饼中切出
 */
@property(assign, nonatomic) CCUInt selectedIndex;

/*!
 Offset length what is the distance from the center of the pie to the selected part
 丸の中心から、選べた部分の距離
 圆心与被分割出来的那部分的距离
 */
@property(assign, nonatomic) CCFloat offsetLength;


/*!
 @abstract change the selected part's index
 選べた部分のインデクスを変更する
 变更选中的部分的index
 
 @param index Selected part's index
 選べた部分のインデクス
 选中的index
 */
- (void)selectPartByIndex:(CCUInt)index;

@end
