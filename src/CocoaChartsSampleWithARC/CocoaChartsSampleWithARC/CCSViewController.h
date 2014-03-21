//
//  CCSViewController.h
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
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

@property(strong, nonatomic) UITableView *tableView;

@end
