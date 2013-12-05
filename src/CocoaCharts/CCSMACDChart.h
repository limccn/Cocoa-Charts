//
//  CCSMACDChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSMAStickChart.h"

/*!
 @typedef enum CCSGridChartAxisPosition
 XY Axis' Display position in grid
 X軸、Y軸の表示位置
 X轴、Y轴在画面种的表示位置
 */
typedef enum {
    CCSMACDChartDisplayTypeStick,
    CCSMACDChartDisplayTypeLineStick,
    CCSMACDChartDisplayTypeLine
} CCSMACDChartDisplayType;


@interface CCSMACDChart : CCSMAStickChart {

    NSInteger _macdDisplayType;

    UIColor *_positiveStickColor;
    UIColor *_negativeStickColor;
    UIColor *_macdLineColor;
    UIColor *_diffLineColor;
    UIColor *_deaLineColor;
}

@property(assign, nonatomic) NSInteger macdDisplayType;

@property(retain, nonatomic) UIColor *positiveStickColor;
@property(retain, nonatomic) UIColor *negativeStickColor;
@property(retain, nonatomic) UIColor *macdLineColor;
@property(retain, nonatomic) UIColor *diffLineColor;
@property(retain, nonatomic) UIColor *deaLineColor;

@end
