//
//  CCSMACDChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSSlipStickChart.h"

typedef enum {
    CCSMACDChartDisplayTypeStick,
    CCSMACDChartDisplayTypeLineStick,
    CCSMACDChartDisplayTypeLine
} CCSMACDChartDisplayType;


@interface CCSMACDChart : CCSSlipStickChart {
    CCSMACDChartDisplayType _macdDisplayType;
    
    UIColor *_positiveStickStrokeColor;
    UIColor *_negativeStickStrokeColor;
    UIColor *_positiveStickFillColor;
    UIColor *_negativeStickFillColor;
    UIColor *_macdLineColor;
    UIColor *_diffLineColor;
    UIColor *_deaLineColor;
}

@property(strong, nonatomic) NSArray *linesData;

@property(assign, nonatomic) CCSMACDChartDisplayType macdDisplayType;

@property(strong, nonatomic) UIColor *positiveStickStrokeColor;
@property(strong, nonatomic) UIColor *negativeStickStrokeColor;
@property(strong, nonatomic) UIColor *positiveStickFillColor;
@property(strong, nonatomic) UIColor *negativeStickFillColor;
@property(strong, nonatomic) UIColor *macdLineColor;
@property(strong, nonatomic) UIColor *diffLineColor;
@property(strong, nonatomic) UIColor *deaLineColor;

@end
