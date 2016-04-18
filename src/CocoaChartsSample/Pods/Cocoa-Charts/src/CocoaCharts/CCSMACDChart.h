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
    
    UIColor *_positiveStickColor;
    UIColor *_negativeStickColor;
    UIColor *_macdLineColor;
    UIColor *_diffLineColor;
    UIColor *_deaLineColor;
}

@property(strong, nonatomic) NSArray *linesData;

@property(assign, nonatomic) CCSMACDChartDisplayType macdDisplayType;

@property(strong, nonatomic) UIColor *positiveStickColor;
@property(strong, nonatomic) UIColor *negativeStickColor;
@property(strong, nonatomic) UIColor *macdLineColor;
@property(strong, nonatomic) UIColor *diffLineColor;
@property(strong, nonatomic) UIColor *deaLineColor;

@end
