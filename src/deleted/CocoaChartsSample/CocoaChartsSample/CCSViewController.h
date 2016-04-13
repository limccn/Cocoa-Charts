//
//  CCSViewController.h
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
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

typedef enum {
    CCSChartTypeGridChart = 0,
    CCSChartTypeLineChart = 1,
    CCSChartTypeStickChart = 2,
    CCSChartTypeMAStickChart = 3,
    CCSChartTypeCandleStickChart = 4,
    CCSChartTypeMACandleStickChart = 5,
    CCSChartTypePieChart = 6,
    CCSChartTypePizzaChart = 7,
    CCSChartTypeSpiderWebChart = 8,
    CCSChartTypeMinusStickChart = 9,
    CCSChartTypeMACDChart = 10,
    CCSChartTypeAreaChart = 11,
    CCSChartTypeStackedAreaChart = 12,
    CCSChartTypeBandAreaChart = 13,
    CCSChartTypeRadarChart = 14,
    CCSChartTypeSlipStickChart = 15,
    CCSChartTypeColoredSlipStickChart = 16,
    CCSChartTypeSlipCandleStickChart = 17,
    CCSChartTypeMASlipCandleStickChart = 18,
    CCSChartTypeBOLLMASlipCandleStickChart = 19,
    CCSChartTypeSlipLineChart = 20,


} CCSChartType;

@interface CCSViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}

@property(retain, nonatomic) UITableView *tableView;

@end
